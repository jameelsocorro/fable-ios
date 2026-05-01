import SwiftUI

struct TodayQuestCard: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let streakCount: Int
    let onComplete: (QuestDefinition) -> Void

    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
    @State private var holdProgress: CGFloat = 0
    @State private var fillOrigin: CGPoint?
    @State private var isHolding = false
    @State private var holdTask: Task<Void, Never>?
    @State private var completionFeedbackTrigger = false

    private let holdDuration: TimeInterval = 1.2
    private let tickCount = 60

    var body: some View {
        ZStack(alignment: .topTrailing) {
            QuestCardBody(
                quest: quest,
                isCompleted: isCompleted,
                differentiateWithoutColor: differentiateWithoutColor
            )
            .frame(maxWidth: .infinity)
            .frame(minHeight: 300)
            .background {
                QuestCardBackground(
                    quest: quest,
                    isCompleted: isCompleted,
                    holdProgress: holdProgress,
                    fillOrigin: fillOrigin,
                    reduceMotion: reduceMotion
                )
            }
            .clipShape(cardShape)
            .overlay {
                cardShape.strokeBorder(
                    isCompleted ? quest.platform.accentColor.opacity(0.65) : theme.colors.border.opacity(0.65),
                    lineWidth: isCompleted ? 1.5 : 1
                )
            }
            .scaleEffect(isHolding && !reduceMotion ? 0.985 : 1)
            .animation(.spring(response: 0.28, dampingFraction: 0.86), value: isHolding)
            .contentShape(cardShape)
            .gesture(holdGesture)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(quest.title), \(quest.platform.displayName)")
            .accessibilityValue(isCompleted ? "Completed" : "Incomplete")
            .accessibilityHint(isCompleted ? "" : "Press and hold to complete")
            .accessibilityAddTraits(.isButton)
            .accessibilityAction(named: "Complete quest") {
                completeFromAccessibility()
            }

            QuestCardStatusBadge(
                quest: quest,
                isCompleted: isCompleted,
                streakCount: streakCount
            )
            .offset(x: -theme.spacing.lg, y: theme.spacing.lg)
        }
        .onDisappear(perform: cancelHold)
        .sensoryFeedback(.impact(weight: .medium), trigger: completionFeedbackTrigger)
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: LeviRadius.xl)
    }

    private var holdGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                guard !isCompleted else { return }

                fillOrigin = value.location

                if !isHolding {
                    beginHold()
                }
            }
            .onEnded { _ in
                guard !isCompleted else { return }

                if holdProgress < 1 {
                    cancelHold()
                }
            }
    }

    private func beginHold() {
        isHolding = true
        holdTask?.cancel()

        holdTask = Task { @MainActor in
            for tick in 1...tickCount {
                guard !Task.isCancelled else { return }

                try? await Task.sleep(nanoseconds: UInt64(holdDuration * 1_000_000_000 / Double(tickCount)))

                guard !Task.isCancelled else { return }

                let progress = CGFloat(tick) / CGFloat(tickCount)
                withAnimation(reduceMotion ? .linear(duration: 0.01) : .linear(duration: holdDuration / Double(tickCount))) {
                    holdProgress = progress
                }
            }

            completeHold()
        }
    }

    private func completeHold() {
        holdTask?.cancel()
        holdTask = nil
        isHolding = false
        holdProgress = 1
        completionFeedbackTrigger.toggle()
        onComplete(quest)
    }

    private func cancelHold() {
        holdTask?.cancel()
        holdTask = nil
        isHolding = false

        withAnimation(reduceMotion ? .easeOut(duration: 0.01) : .spring(response: 0.28, dampingFraction: 0.86)) {
            holdProgress = 0
        }
    }

    private func completeFromAccessibility() {
        guard !isCompleted else { return }
        fillOrigin = nil
        holdProgress = 1
        onComplete(quest)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            TodayQuestCard(
                quest: QuestCatalog.all[0],
                isCompleted: false,
                streakCount: 2,
                onComplete: { _ in }
            )

            TodayQuestCard(
                quest: QuestCatalog.all[3],
                isCompleted: true,
                streakCount: 3,
                onComplete: { _ in }
            )
        }
        .padding()
    }
    .background(LeviAppTheme(selection: .system).colors.background)
    .environment(\.theme, LeviAppTheme(selection: .system))
}

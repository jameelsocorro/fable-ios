import SwiftUI

struct TodayQuestCard: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let streakCount: Int
    let onComplete: (QuestDefinition) -> Void
    let onUndo: (QuestDefinition) -> Void

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
    @State private var fillProgress: CGFloat = 0
    @State private var shouldBumpStreak = false
    @State private var displayedStreakCount: Int = 0
    @State private var completionFeedbackTrigger = false
    @State private var successFeedbackTrigger = false
    @State private var undoFeedbackTrigger = false

    var body: some View {
        HStack(spacing: theme.spacing.lg) {
            TodayQuestStreakBadge(
                quest: quest,
                streakCount: displayedStreakCount,
                isCompleted: isCompleted,
                shouldBump: shouldBumpStreak
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(quest.title)
                    .font(.system(.title2, design: .serif, weight: .semibold))
                    .foregroundStyle(titleForegroundColor)
                    .strikethrough(isCompleted, color: titleForegroundColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)

                Text(quest.platform.displayName)
                    .font(.system(.subheadline))
                    .foregroundStyle(titleForegroundColor.opacity(0.5))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibilityHidden(true)

            if differentiateWithoutColor && isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(titleForegroundColor)
                    .accessibilityHidden(true)
            }

            HStack(spacing: theme.spacing.sm) {
                if isCompleted {
                    QuestActionButton(
                        systemImage: "arrow.uturn.backward",
                        accessibilityLabel: "Undo \(quest.title)",
                        accessibilityHint: "Removes today's completion for \(quest.platform.displayName).",
                        action: { onUndo(quest) }
                    )
                } else {
                    QuestActionButton(
                        systemImage: "plus",
                        accessibilityLabel: "Complete \(quest.title)",
                        accessibilityHint: "Marks this \(quest.platform.displayName) quest complete.",
                        action: { onComplete(quest) }
                    )
                }
            }
        }
        .padding(.horizontal, theme.spacing.lg)
        .padding(.vertical, theme.spacing.lg)
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .center)
        .background {
            TodayQuestFillBackground(
                quest: quest,
                isCompleted: isCompleted,
                fillProgress: fillProgress
            )
        }
        .clipShape(.rect(cornerRadius: LeviRadius.lg))
        .accessibilityElement(children: .contain)
        .accessibilityLabel("\(quest.title), \(quest.platform.displayName)")
        .accessibilityValue(isCompleted ? "Completed. Current streak \(streakCount)." : "Incomplete. Current streak \(streakCount).")
        .onAppear {
            displayedStreakCount = streakCount
            fillProgress = isCompleted ? 1 : 0
        }
        .onChange(of: isCompleted) { _, newValue in
            updateCompletionState(newValue)
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: completionFeedbackTrigger)
        .sensoryFeedback(.success, trigger: successFeedbackTrigger)
        .sensoryFeedback(.impact(weight: .light), trigger: undoFeedbackTrigger)
    }

    private var titleForegroundColor: Color {
        guard isCompleted else { return theme.colors.textPrimary }
        return switch quest.platform {
        case .threads, .x: colorScheme == .dark ? theme.colors.textInverse : .white
        case .linkedin, .youtube, .pinterest, .mastodon, .facebook: .white
        case .instagram: theme.colors.textPrimary
        case .tiktok, .reddit, .bluesky, .snapchat: theme.colors.textInverse
        }
    }

    private func updateCompletionState(_ completed: Bool) {
        shouldBumpStreak = false

        if completed {
            fillProgress = 0
            completionFeedbackTrigger.toggle()

            if reduceMotion {
                fillProgress = 1
                displayedStreakCount = streakCount
                return
            }

            withAnimation(.spring(response: 0.52, dampingFraction: 0.88)) {
                fillProgress = 1
            } completion: {
                successFeedbackTrigger.toggle()
                displayedStreakCount = streakCount  // reveal the real count only now
                withAnimation(.spring(response: 0.24, dampingFraction: 0.48)) {
                    shouldBumpStreak = true
                } completion: {
                    withAnimation(.spring(response: 0.22, dampingFraction: 0.82)) {
                        shouldBumpStreak = false
                    }
                }
            }
        } else {
            undoFeedbackTrigger.toggle()
            displayedStreakCount = streakCount  // revert immediately on undo
            if reduceMotion {
                fillProgress = 0
            } else {
                withAnimation(.spring(response: 0.40, dampingFraction: 0.90)) {
                    fillProgress = 0
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 24) {
            TodayQuestCard(
                quest: QuestCatalog.all[0],
                isCompleted: false,
                streakCount: 0,
                onComplete: { _ in },
                onUndo: { _ in }
            )

            TodayQuestCard(
                quest: QuestCatalog.all[3],
                isCompleted: true,
                streakCount: 3,
                onComplete: { _ in },
                onUndo: { _ in }
            )
        }
        .padding()
    }
    .background(LeviAppTheme(selection: .system).colors.background)
    .environment(\.theme, LeviAppTheme(selection: .system))
}

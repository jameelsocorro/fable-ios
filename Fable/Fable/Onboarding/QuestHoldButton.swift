import SwiftUI

struct QuestHoldButton: View {
    let quest: QuestDefinition
    let completion: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var progress = 0.0
    @State private var didComplete = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(quest.platform.accentColor.opacity(0.18), lineWidth: 10)
                .frame(width: 172, height: 172)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(quest.platform.accentColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .frame(width: 172, height: 172)
                .rotationEffect(.degrees(-90))

            Circle()
                .fill(quest.platform.accentColor.opacity(0.16))
                .frame(width: 128 + (28 * progress), height: 128 + (28 * progress))

            Image(systemName: quest.platform.symbolName)
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(quest.platform.accentColor)
                .accessibilityHidden(true)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Hold to commit \(quest.title)")
        .accessibilityHint("Keep holding until the circle fills.")
        .accessibilityAddTraits(.isButton)
        .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 32) {
            complete()
        } onPressingChanged: { isPressing in
            updateProgress(isPressing: isPressing)
        }
        .sensoryFeedback(.success, trigger: didComplete)
    }

    private func updateProgress(isPressing: Bool) {
        guard !didComplete else {
            return
        }

        if isPressing {
            withAnimation(.linear(duration: reduceMotion ? 0.01 : 1.0)) {
                progress = 1
            }
        } else {
            withAnimation(.easeOut(duration: reduceMotion ? 0.01 : 0.18)) {
                progress = 0
            }
        }
    }

    private func complete() {
        guard !didComplete else {
            return
        }

        didComplete = true
        progress = 1
        completion()
    }
}

#Preview {
    QuestHoldButton(quest: QuestCatalog.all[0], completion: {})
}

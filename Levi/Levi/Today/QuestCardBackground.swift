import SwiftUI

struct QuestCardBackground: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let holdProgress: CGFloat
    let fillOrigin: CGPoint?
    let reduceMotion: Bool

    @Environment(\.theme) private var theme

    var body: some View {
        ZStack {
            theme.colors.surface

            QuestCardOrganicFill(
                progress: isCompleted ? 1 : holdProgress,
                origin: fillOrigin,
                color: quest.platform.accentColor,
                reduceMotion: reduceMotion
            )

            if isCompleted || holdProgress > 0.55 {
                Color.white.opacity(0.18)
            }
        }
    }
}

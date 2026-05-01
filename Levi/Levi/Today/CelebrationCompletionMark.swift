import SwiftUI

struct CelebrationCompletionMark: View {
    let quest: QuestDefinition
    let reduceMotion: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(quest.platform.accentColor, lineWidth: 12)
                .frame(width: 260, height: 260)

            Image(systemName: quest.platform.symbolName)
                .font(.system(size: 96, weight: .bold))
                .foregroundStyle(quest.platform.accentColor)
                .scaleEffect(reduceMotion ? 1 : 1.05)
        }
        .accessibilityHidden(true)
    }
}

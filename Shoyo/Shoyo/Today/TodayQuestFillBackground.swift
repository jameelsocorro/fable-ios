import SwiftUI

struct TodayQuestFillBackground: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let fillProgress: CGFloat

    @Environment(\.theme) private var theme

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: ShoyoRadius.lg)

        shape
            .fill(theme.colors.surfacePrimary)
            .overlay(alignment: .leading) {
                quest.platform.accentColor
                    .containerRelativeFrame(.horizontal) { length, _ in length * fillProgress }
                    .frame(maxHeight: .infinity)
                    .opacity(isCompleted || fillProgress > 0 ? 1 : 0)
            }
    }
}

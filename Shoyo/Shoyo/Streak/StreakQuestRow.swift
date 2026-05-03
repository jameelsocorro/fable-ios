import SwiftUI

struct StreakQuestRow: View {
    let quest: QuestDefinition
    let strip: [StreakDayState]

    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: theme.spacing.sm) {
            platformIcon
                .frame(width: 18, height: 18)
                .foregroundStyle(quest.platform.accentFillStyle)

            Text(quest.title)
                .font(.system(.subheadline, design: .default, weight: .medium))
                .foregroundStyle(theme.colors.textPrimary)
                .lineLimit(1)

            Spacer()

            HStack(spacing: StreakCommitGridBox.defaultSpacing) {
                ForEach(strip) { day in
                    StreakCommitGridBox(
                        intensity: day.isCompleted ? 3 : 0,
                        activeFillStyle: quest.platform.accentFillStyle
                    )
                }
            }
        }
        .padding(.horizontal, theme.spacing.lg)
        .padding(.vertical, theme.spacing.md)
    }

    @ViewBuilder
    private var platformIcon: some View {
        if let imageName = quest.platform.customImageName {
            Image(imageName)
                .resizable()
                .scaledToFit()
        } else {
            Image(systemName: quest.platform.symbolName)
        }
    }
}

#Preview {
    let quest = QuestDefinition(
        id: "instagram-story",
        platform: .instagram,
        title: "Post a Story",
        isFirstSessionRecommendation: true
    )
    let strip = StreakCalculator.recentDays(
        count: 7,
        completionDates: [
            .now,
            Calendar.current.date(byAdding: .day, value: -2, to: .now)!
        ],
        now: .now
    )

    StreakQuestRow(quest: quest, strip: strip)
        .padding()
        .environment(\.theme, ShoyoAppTheme(selection: .system))
}

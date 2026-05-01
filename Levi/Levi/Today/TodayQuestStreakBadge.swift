import SwiftUI

struct TodayQuestStreakBadge: View {
    let quest: QuestDefinition
    let streakCount: Int
    let isCompleted: Bool
    let shouldBump: Bool

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "flame.fill")
                .font(.system(.title3, weight: .bold))
                .accessibilityHidden(true)

            Text("\(streakCount)")
                .font(.system(.body, design: .serif, weight: .bold))
        }
        .foregroundStyle(foregroundColor)
        .frame(width: 72, height: 72)
        .background(backgroundStyle, in: .rect(cornerRadius: LeviRadius.md))
        .scaleEffect(shouldBump ? 1.12 : 1)
        .accessibilityHidden(true)
    }

    private var backgroundStyle: AnyShapeStyle {
        if isCompleted {
            AnyShapeStyle(theme.colors.surface.opacity(0.96))
        } else {
            AnyShapeStyle(
                LinearGradient(
                    colors: [
                        quest.platform.accentColor.opacity(0.72),
                        quest.platform.accentColor
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }

    private var foregroundColor: Color {
        if isCompleted { return theme.colors.textPrimary }
        return switch quest.platform {
        case .threads, .x: colorScheme == .dark ? theme.colors.textInverse : .white
        case .linkedin, .youtube, .pinterest, .mastodon, .facebook: .white
        case .instagram: theme.colors.textPrimary
        case .tiktok, .reddit, .bluesky, .snapchat: theme.colors.textInverse
        }
    }
}

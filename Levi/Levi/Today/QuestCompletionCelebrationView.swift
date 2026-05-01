import SwiftUI

struct QuestCompletionCelebrationView: View {
    let context: QuestCompletionContext
    let onBackHome: () -> Void

    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            theme.colors.background
                .ignoresSafeArea()

            CelebrationDottedBackdrop(accentColor: context.quest.platform.accentColor)

            VStack(spacing: theme.spacing.xxl) {
                Text("Quest completed!")
                    .font(.title2.bold())
                    .foregroundStyle(theme.colors.textPrimary)
                    .padding(.top, theme.spacing.xxl)

                Spacer(minLength: theme.spacing.xl)

                CelebrationCompletionMark(quest: context.quest, reduceMotion: reduceMotion)

                VStack(spacing: theme.spacing.md) {
                    Text("^[\(context.streakCount) day](inflect: true)")
                        .font(.largeTitle.bold())
                        .foregroundStyle(theme.colors.textPrimary)

                    Text("That's one more vote toward keeping \(context.projectName) visible.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(theme.colors.textSecondary)
                        .padding(.horizontal, theme.spacing.xl)
                }

                CelebrationWeekRow(recentDays: context.recentDays)

                Spacer()

                VStack(spacing: theme.spacing.md) {
                    Button("View streak details") {
                    }
                    .buttonStyle(LeviSecondaryButtonStyle())
                    .disabled(true)

                    Button("Back to Home", action: onBackHome)
                        .buttonStyle(LeviPrimaryButtonStyle())
                }
                .padding(.horizontal, theme.spacing.xl)
                .padding(.bottom, theme.spacing.xl)
            }
        }
    }
}

#Preview {
    QuestCompletionCelebrationView(
        context: QuestCompletionContext(
            quest: QuestCatalog.all[3],
            projectName: "Levi",
            completedAt: .now,
            streakCount: 2,
            recentDays: StreakCalculator.recentDays(completionDates: [.now], now: .now)
        ),
        onBackHome: {}
    )
    .environment(\.theme, LeviAppTheme(selection: .system))
}

import SwiftUI
import SwiftData

struct TodayView: View {
    let profile: FounderProfile
    @Query private var completions: [QuestCompletion]
    @Environment(\.theme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                VStack(alignment: .leading, spacing: theme.spacing.sm) {
                    HStack(alignment: .firstTextBaseline, spacing: theme.spacing.sm) {
                        Image(systemName: "flame.fill")
                            .foregroundStyle(theme.colors.primary)
                            .font(.title2)
                            .accessibilityHidden(true)

                        Text("Day 1")
                            .font(.largeTitle.bold())
                            .foregroundStyle(theme.colors.textPrimary)
                    }

                    Text("Keep \(profile.displayProjectName) visible.")
                        .font(.body)
                        .foregroundStyle(theme.colors.textSecondary)
                }

                Text("One quest keeps today alive. More is extra momentum.")
                    .font(.callout)
                    .foregroundStyle(theme.colors.textSecondary)
                    .padding(theme.spacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(theme.colors.primary.opacity(0.07), in: RoundedRectangle(cornerRadius: FableRadius.sm))

                VStack(spacing: theme.spacing.md) {
                    ForEach(todayQuests) { quest in
                        TodayQuestRow(quest: quest, isCommitted: isCommitted(quest))
                    }
                }
            }
            .padding(theme.spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(theme.colors.background)
    }

    private var todayQuests: [QuestDefinition] {
        QuestCatalog.quests(for: profile.selectedPlatforms)
    }

    private var committedQuestIDsToday: Set<String> {
        let calendar = Calendar.current
        return Set(
            completions
                .filter { calendar.isDateInToday($0.completedAt) }
                .map(\.questID)
        )
    }

    private func isCommitted(_ quest: QuestDefinition) -> Bool {
        committedQuestIDsToday.contains(quest.id)
    }
}

#Preview {
    let profile = FounderProfile(projectName: "Fable", selectedPlatformIDs: ["threads", "instagram"], hasCompletedOnboarding: true, onboardingStep: .complete)

    TodayView(profile: profile)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
}

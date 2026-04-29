import SwiftUI
import SwiftData

struct TodayView: View {
    let profile: FounderProfile
    @Query private var completions: [QuestCompletion]
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                // Glass streak header card
                HStack(alignment: .center, spacing: theme.spacing.md) {
                    ZStack {
                        Circle()
                            .fill(theme.colors.primary.opacity(0.08))
                            .frame(width: 56, height: 56)

                        Circle()
                            .fill(theme.colors.primary.opacity(0.14))
                            .frame(width: 42, height: 42)

                        Image(systemName: "flame.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(theme.colors.primary)
                            .accessibilityHidden(true)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Day 1")
                            .font(.title2.bold())
                            .foregroundStyle(theme.colors.textPrimary)

                        Text("Keep \(profile.displayProjectName) visible.")
                            .font(.subheadline)
                            .foregroundStyle(theme.colors.textSecondary)
                    }

                    Spacer()
                }
                .padding(theme.spacing.lg)
                .glassCard(cornerRadius: FableRadius.md)

                // Hint callout with glass treatment
                HStack(spacing: theme.spacing.sm) {
                    Image(systemName: "bolt.fill")
                        .font(.caption.bold())
                        .foregroundStyle(theme.colors.primary)
                        .accessibilityHidden(true)

                    Text("One quest keeps today alive. More is extra momentum.")
                        .font(.callout)
                        .foregroundStyle(theme.colors.textSecondary)
                }
                .padding(theme.spacing.md)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: FableRadius.sm, style: .continuous)
                        .fill(theme.colors.primary.opacity(colorScheme == .dark ? 0.12 : 0.07))
                        .overlay {
                            RoundedRectangle(cornerRadius: FableRadius.sm, style: .continuous)
                                .strokeBorder(theme.colors.primary.opacity(0.18), lineWidth: 1)
                        }
                }

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

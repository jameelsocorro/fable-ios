import SwiftUI
import SwiftData

struct StreakView: View {
    let profile: FounderProfile

    @Query(sort: \QuestCompletion.completedAt) private var completions: [QuestCompletion]
    @Environment(\.theme) private var theme

    var body: some View {
        NavigationStack {
            ZStack {
                theme.colors.background.ignoresSafeArea()

                if completions.isEmpty {
                    ContentUnavailableView(
                        "No streaks yet",
                        systemImage: "flame.fill",
                        description: Text("Complete your first quest to start tracking.")
                    )
                    .foregroundStyle(theme.colors.textSecondary)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: theme.spacing.lg) {
                            statsRow

                            StreakCommitBoard(grid: yearGrid)
                                .padding(.horizontal, theme.spacing.xl)

                            perQuestSection
                        }
                        .padding(.top, theme.spacing.sm)
                        .padding(.bottom, theme.spacing.xxl)
                    }
                }
            }
            .navigationTitle("Streaks")
            .navigationBarTitleDisplayMode(.large)
        }
    }

    // MARK: - Sections

    private var statsRow: some View {
        HStack(spacing: theme.spacing.sm) {
            statCard(label: "TOTAL", value: "\(completions.count)", isAccented: true)
            statCard(label: "STREAK", value: "\(currentStreak)d", isAccented: false)
            statCard(label: "RATE", value: "\(Int(completionRate * 100))%", isAccented: false)
        }
        .padding(.horizontal, theme.spacing.xl)
    }

    private var perQuestSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            VStack(spacing: 0) {
                ForEach(quests) { quest in
                    StreakQuestRow(
                        quest: quest,
                        strip: StreakCalculator.recentDays(
                            count: 7,
                            completionDates: questCompletionDates(for: quest)
                        )
                    )

                    if quest.id != quests.last?.id {
                        Divider()
                            .padding(.horizontal, theme.spacing.lg)
                    }
                }
            }
            .card()
            .padding(.horizontal, theme.spacing.xl)
        }
    }

    // MARK: - Computed

    private var completionDates: [Date] {
        completions.map(\.completedAt)
    }

    private var currentStreak: Int {
        StreakCalculator.currentStreak(completionDates: completionDates)
    }

    private var completionRate: Double {
        StreakCalculator.completionRate(completionDates: completionDates, in: .now)
    }

    private var yearGrid: [[StreakGridCell?]] {
        let cal = Calendar.current
        let end = cal.date(byAdding: .day, value: 1, to: cal.startOfDay(for: .now))!
        guard let start = cal.date(byAdding: .month, value: -12, to: cal.startOfDay(for: .now)) else { return [] }
        return StreakCalculator.grid(for: DateInterval(start: start, end: end), completionDates: completionDates)
    }

    private var quests: [QuestDefinition] {
        QuestCatalog.quests(for: profile.selectedPlatforms)
            .sorted {
                if $0.platform.sortIndex != $1.platform.sortIndex {
                    return $0.platform.sortIndex < $1.platform.sortIndex
                }
                return $0.title < $1.title
            }
    }

    private func questCompletionDates(for quest: QuestDefinition) -> [Date] {
        completions
            .filter { $0.questID == quest.id }
            .map(\.completedAt)
    }

    // MARK: - Stat card

    @ViewBuilder
    private func statCard(label: String, value: String, isAccented: Bool) -> some View {
        if isAccented {
            statCardContent(label: label, value: value, isAccented: true)
                .background {
                    RoundedRectangle(cornerRadius: ShoyoRadius.sm, style: .continuous)
                        .fill(theme.colors.primary)
                }
        } else {
            statCardContent(label: label, value: value, isAccented: false)
                .card()
        }
    }

    private func statCardContent(label: String, value: String, isAccented: Bool) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.xs) {
            Text(label)
                .font(.system(.caption2, design: .monospaced, weight: .semibold))
                .foregroundStyle(
                    isAccented
                        ? theme.colors.primaryForeground.opacity(0.8)
                        : theme.colors.textSecondary
                )

            Text(value)
                .font(.system(.title2, design: .default, weight: .bold))
                .foregroundStyle(
                    isAccented
                        ? theme.colors.primaryForeground
                        : theme.colors.textPrimary
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(theme.spacing.lg)
    }
}

#Preview {
    let profile = FounderProfile(
        projectName: "Shoyo",
        selectedPlatformIDs: ["threads", "instagram", "tiktok"],
        hasCompletedOnboarding: true,
        onboardingStep: .complete
    )

    let container = try! ModelContainer(
        for: FounderProfile.self, QuestCompletion.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let quests = QuestCatalog.quests(for: profile.selectedPlatforms)
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: .now)

    for dayOffset in stride(from: -30, through: 0, by: 1) {
        guard let date = calendar.date(byAdding: .day, value: dayOffset, to: today) else { continue }
        guard dayOffset.isMultiple(of: 2) || dayOffset > -3 else { continue }
        for quest in quests.prefix(2) {
            container.mainContext.insert(
                QuestCompletion(questID: quest.id, platform: quest.platform, completedAt: date)
            )
        }
    }

    return StreakView(profile: profile)
        .modelContainer(container)
        .environment(\.theme, ShoyoAppTheme(selection: .system))
}

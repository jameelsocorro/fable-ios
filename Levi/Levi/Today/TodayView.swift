import SwiftUI
import SwiftData

struct TodayView: View {
    let profile: FounderProfile

    @Query(sort: \QuestCompletion.completedAt, order: .reverse) private var completions: [QuestCompletion]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme
    @State private var selectedTab: TodayTab = .home
    @State private var saveError: Error?

    var body: some View {
        ZStack(alignment: .bottom) {
            theme.colors.background
                .ignoresSafeArea()

            PageGradientBackground(center: UnitPoint(x: 0.25, y: 0.15))

            ScrollView {
                VStack(alignment: .leading, spacing: theme.spacing.xl) {
                    VStack(alignment: .leading, spacing: theme.spacing.sm) {
                        Text("Today")
                            .font(.system(.largeTitle, design: .serif, weight: .bold))
                            .foregroundStyle(theme.colors.textPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        TodayWeekStrip(days: recentDays)

                        Rectangle()
                            .fill(theme.colors.border)
                            .frame(height: 1)
                            .padding(.horizontal, -theme.spacing.xl)
                    }

                    if todayQuests.isEmpty {
                        ContentUnavailableView(
                            "No quests today",
                            systemImage: "sparkles",
                            description: Text("Your selected platforms do not have quests available yet.")
                        )
                        .foregroundStyle(theme.colors.textSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.top, theme.spacing.xxl)
                    } else {
                        let committed = committedQuestIDsToday
                        VStack(spacing: theme.spacing.xl) {
                            ForEach(todayQuests) { quest in
                                TodayQuestCard(
                                    quest: quest,
                                    isCompleted: committed.contains(quest.id),
                                    streakCount: currentStreak,
                                    onComplete: complete,
                                    onUndo: undoCompletion
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, theme.spacing.xl)
                .padding(.top, theme.spacing.xl)
                .padding(.bottom, 120)
            }

            TodayFloatingTabBar(selectedTab: $selectedTab)
                .padding(.bottom, theme.spacing.lg)
        }
        .alert("Unable to Save", isPresented: Binding(
            get: { saveError != nil },
            set: { if !$0 { saveError = nil } }
        )) {
            Button("OK") { saveError = nil }
        } message: {
            Text("Your progress could not be saved. Please try again.")
        }
    }

    private var todayQuests: [QuestDefinition] {
        QuestCatalog.quests(for: profile.selectedPlatforms)
    }

    private var completionDates: [Date] {
        completions.map(\.completedAt)
    }

    private var recentDays: [StreakDayState] {
        StreakCalculator.recentDays(completionDates: completionDates)
    }

    private var currentStreak: Int {
        StreakCalculator.currentStreak(completionDates: completionDates)
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

    private func completionForToday(_ quest: QuestDefinition) -> QuestCompletion? {
        let calendar = Calendar.current

        return completions.first { completion in
            completion.questID == quest.id && calendar.isDateInToday(completion.completedAt)
        }
    }

    private func complete(_ quest: QuestDefinition) {
        guard !isCommitted(quest) else { return }

        let completion = QuestCompletion(
            questID: quest.id,
            platform: quest.platform,
            completedAt: Date()
        )

        modelContext.insert(completion)

        do {
            try modelContext.save()
        } catch {
            modelContext.delete(completion)
            saveError = error
        }
    }

    private func undoCompletion(_ quest: QuestDefinition) {
        guard let completion = completionForToday(quest) else { return }

        modelContext.delete(completion)

        do {
            try modelContext.save()
        } catch {
            let restoredCompletion = QuestCompletion(
                id: completion.id,
                questID: completion.questID,
                platform: completion.platform ?? quest.platform,
                completedAt: completion.completedAt,
                completionKind: completion.completionKind
            )
            modelContext.insert(restoredCompletion)
            saveError = error
        }
    }
}

#Preview {
    let profile = FounderProfile(
        projectName: "Levi",
        selectedPlatformIDs: ["threads", "instagram", "tiktok"],
        hasCompletedOnboarding: true,
        onboardingStep: .complete
    )

    TodayView(profile: profile)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(\.theme, LeviAppTheme(selection: .system))
}

import SwiftUI
import SwiftData

struct TodayView: View {
    let profile: FounderProfile

    @Query(sort: \QuestCompletion.completedAt, order: .reverse) private var completions: [QuestCompletion]
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme
    @State private var saveError: Error?
    @State private var isShowingSaveError = false
    @State private var selectedDayStart: Date?

    var body: some View {
        ZStack {
            theme.colors.background
                .ignoresSafeArea()

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(alignment: .leading, spacing: theme.spacing.xl) {
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
                                let committed = committedQuestIDsForSelectedDay
                                VStack(spacing: theme.spacing.xl) {
                                    ForEach(todayQuests) { quest in
                                        TodayQuestCard(
                                            quest: quest,
                                            isCompleted: committed.contains(quest.id),
                                            streakCount: selectedDayStreaksByQuestID[quest.id] ?? 0,
                                            onComplete: complete,
                                            onUndo: undoCompletion
                                        )
                                        .id("\(quest.id)-\(selectedQuestDayStart.timeIntervalSinceReferenceDate)")
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, theme.spacing.xl)
                        .padding(.top, theme.spacing.xl)
                        .padding(.bottom, theme.spacing.xl)
                    } header: {
                        TodayStickyHeader(
                            days: recentDays,
                            selectedDayStart: selectedDayStart,
                            onSelectDay: selectDay
                        )
                    }
                }
            }
        }
        .alert("Unable to Save", isPresented: $isShowingSaveError) {
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

    private var selectedQuestDayStart: Date {
        let calendar = Calendar.current
        return selectedDayStart ?? calendar.startOfDay(for: .now)
    }

    private func selectDay(_ day: StreakDayState) {
        selectedDayStart = day.dayStart
    }

    private var selectedDayStreaksByQuestID: [String: Int] {
        let grouped = Dictionary(grouping: completions, by: \.questID)
        return grouped.mapValues {
            StreakCalculator.currentStreak(
                completionDates: $0.map(\.completedAt),
                now: selectedQuestDayStart
            )
        }
    }

    private var committedQuestIDsForSelectedDay: Set<String> {
        let calendar = Calendar.current
        return Set(
            completions
                .filter { calendar.isDate($0.completedAt, inSameDayAs: selectedQuestDayStart) }
                .map(\.questID)
        )
    }

    private func isCommitted(_ quest: QuestDefinition) -> Bool {
        committedQuestIDsForSelectedDay.contains(quest.id)
    }

    private func completionForSelectedDay(_ quest: QuestDefinition) -> QuestCompletion? {
        let calendar = Calendar.current

        return completions.first { completion in
            completion.questID == quest.id && calendar.isDate(completion.completedAt, inSameDayAs: selectedQuestDayStart)
        }
    }

    private func complete(_ quest: QuestDefinition) {
        guard !isCommitted(quest) else { return }

        let completion = QuestCompletion(
            questID: quest.id,
            platform: quest.platform,
            completedAt: completionDateForSelectedDay
        )

        modelContext.insert(completion)

        do {
            try modelContext.save()
        } catch {
            modelContext.delete(completion)
            saveError = error
            isShowingSaveError = true
        }
    }

    private func undoCompletion(_ quest: QuestDefinition) {
        guard let completion = completionForSelectedDay(quest) else { return }

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
            isShowingSaveError = true
        }
    }

    private var completionDateForSelectedDay: Date {
        let calendar = Calendar.current

        if calendar.isDateInToday(selectedQuestDayStart) {
            return .now
        }

        return selectedQuestDayStart
    }
}

#Preview {
    let profile = FounderProfile(
        projectName: "Shoyo",
        selectedPlatformIDs: ["threads", "instagram", "tiktok"],
        hasCompletedOnboarding: true,
        onboardingStep: .complete
    )

    TodayView(profile: profile)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(\.theme, ShoyoAppTheme(selection: .system))
}

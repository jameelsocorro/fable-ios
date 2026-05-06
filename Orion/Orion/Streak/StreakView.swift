import SwiftUI
import SwiftData

struct StreakView: View {
    let profile: FounderProfile

    @Query(sort: \QuestCompletion.completedAt) private var completions: [QuestCompletion]
    @Environment(SubscriptionManager.self) private var subscriptionManager
    @Environment(\.theme) private var theme
    @State private var scrollOffset: CGFloat = 0
    @State private var activePaywallTrigger: OrionPaywallTrigger?

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                OrionScreenTitle("Streaks", scrollOffset: scrollOffset)

                if completions.isEmpty {
                    ContentUnavailableView(
                        "No streaks yet",
                        systemImage: "flame.fill",
                        description: Text("Complete your first quest to start tracking.")
                    )
                    .foregroundStyle(theme.colors.textSecondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: theme.spacing.lg) {
                            statsRow

                            if subscriptionManager.hasOrionPro {
                                StreakCommitBoard(grid: yearGrid)
                                    .padding(.horizontal, theme.spacing.xl)

                                platformAnalyticsSection
                                perQuestSection
                            } else {
                                recentHistorySection
                                lockedAdvancedSection
                            }
                        }
                        .padding(.top, theme.spacing.sm)
                        .padding(.bottom, theme.spacing.xxl)
                    }
                    .scrollIndicators(.hidden)
                    .onScrollGeometryChange(for: CGFloat.self) { geometry in
                        max(geometry.contentOffset.y, 0)
                    } action: { _, newValue in
                        scrollOffset = newValue
                    }
                }
            }
            .background(theme.colors.background.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .sheet(item: $activePaywallTrigger) { trigger in
                OrionPaywallSheet(trigger: trigger) {}
            }
        }
    }

    // MARK: - Sections

    private var statsRow: some View {
        HStack(spacing: theme.spacing.md) {
            statCard(label: "TOTAL", value: "\(completions.count)", isAccented: true)
            statCard(label: "STREAK", value: "\(currentStreak)d", isAccented: false)

            if subscriptionManager.hasOrionPro {
                statCard(label: "BEST", value: "\(longestStreak)d", isAccented: false)
            } else {
                statCard(label: "RATE", value: "\(Int(completionRate * 100))%", isAccented: false)
            }
        }
        .padding(.horizontal, theme.spacing.xl)
    }

    private var recentHistorySection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text("Recent History")
                .font(.headline)
                .foregroundStyle(theme.colors.textPrimary)
                .padding(.horizontal, theme.spacing.xl)

            StreakRecentHistoryCard(days: recentDays)
                .padding(.horizontal, theme.spacing.xl)
        }
    }

    private var lockedAdvancedSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.lg) {
            lockedRow(
                title: "Unlock the full 12-month activity board",
                subtitle: "See the complete path of your consistency.",
                systemImage: "lock.fill",
                trigger: .fullHistory
            )

            lockedRow(
                title: "Unlock platform and quest analytics",
                subtitle: "Find which places you actually keep showing up.",
                systemImage: "chart.bar.xaxis",
                trigger: .advancedAnalytics
            )
        }
        .padding(.horizontal, theme.spacing.xl)
    }

    private var perQuestSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text("Quest Patterns")
                .font(.headline)
                .foregroundStyle(theme.colors.textPrimary)
                .padding(.horizontal, theme.spacing.xl)

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

    private var platformAnalyticsSection: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text("Platform Focus")
                .font(.headline)
                .foregroundStyle(theme.colors.textPrimary)
                .padding(.horizontal, theme.spacing.xl)

            VStack(spacing: 0) {
                ForEach(selectedPlatforms) { platform in
                    platformAnalyticsRow(for: platform)

                    if platform.id != selectedPlatforms.last?.id {
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

    private var longestStreak: Int {
        StreakCalculator.longestStreak(completionDates: completionDates)
    }

    private var yearGrid: [[StreakGridCell?]] {
        let cal = Calendar.current
        let end = cal.date(byAdding: .day, value: 1, to: cal.startOfDay(for: .now))!
        guard let start = cal.date(byAdding: .month, value: -12, to: cal.startOfDay(for: .now)) else { return [] }
        return StreakCalculator.grid(for: DateInterval(start: start, end: end), completionDates: completionDates)
    }

    private var recentDays: [StreakDayState] {
        let freeDays = ProAccess.recentHistoryDayLimit(hasOrionPro: false) ?? 14
        return StreakCalculator.recentDays(count: freeDays, completionDates: completionDates)
    }

    private var quests: [QuestDefinition] {
        QuestCatalog.quests(for: effectiveSelectedPlatforms)
            .sorted {
                if $0.platform.sortIndex != $1.platform.sortIndex {
                    return $0.platform.sortIndex < $1.platform.sortIndex
                }
                return $0.title < $1.title
            }
    }

    private var selectedPlatforms: [SocialPlatform] {
        effectiveSelectedPlatforms.sorted { $0.sortIndex < $1.sortIndex }
    }

    private var effectiveSelectedPlatforms: Set<SocialPlatform> {
        ProAccess.effectivePlatforms(
            from: profile.selectedPlatforms,
            hasOrionPro: subscriptionManager.hasOrionPro
        )
    }

    private func questCompletionDates(for quest: QuestDefinition) -> [Date] {
        completions
            .filter { $0.questID == quest.id }
            .map(\.completedAt)
    }

    private func completionDates(for platform: SocialPlatform) -> [Date] {
        completions
            .filter { $0.platform == platform }
            .map(\.completedAt)
    }

    private func platformAnalyticsRow(for platform: SocialPlatform) -> some View {
        let dates = completionDates(for: platform)
        let rate = StreakCalculator.completionRate(completionDates: dates, in: .now)

        return HStack(spacing: theme.spacing.md) {
            Label(platform.displayName, systemImage: platform.symbolName)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(theme.colors.textPrimary)

            Spacer()

            VStack(alignment: .trailing, spacing: theme.spacing.xs) {
                Text("\(dates.count)")
                    .font(OrionFont.subwayTickerGrid(size: 18, relativeTo: .body))
                    .foregroundStyle(theme.colors.textPrimary)

                Text("\(Int(rate * 100))% this month")
                    .font(.caption)
                    .foregroundStyle(theme.colors.textSecondary)
            }
        }
        .padding(theme.spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func lockedRow(
        title: String,
        subtitle: String,
        systemImage: String,
        trigger: OrionPaywallTrigger
    ) -> some View {
        Button {
            activePaywallTrigger = trigger
        } label: {
            HStack(alignment: .center, spacing: theme.spacing.md) {
                Image(systemName: systemImage)
                    .font(.headline)
                    .foregroundStyle(theme.colors.primary)
                    .frame(width: 28)
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    Text(title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(theme.colors.textPrimary)

                    Text(subtitle)
                        .font(.footnote)
                        .foregroundStyle(theme.colors.textSecondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(theme.colors.textTertiary)
                    .accessibilityHidden(true)
            }
            .padding(theme.spacing.lg)
            .frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .card()
        .accessibilityHint("Shows Orion Pro upgrade options")
    }

    // MARK: - Stat card

    @ViewBuilder
    private func statCard(label: String, value: String, isAccented: Bool) -> some View {
        if isAccented {
            statCardContent(label: label, value: value, isAccented: true)
                .background {
                    RoundedRectangle(cornerRadius: OrionRadius.sm, style: .continuous)
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
                .font(OrionFont.subwayTickerGrid(size: 22, relativeTo: .body))
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
        projectName: "Orion",
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
        .environment(\.theme, OrionAppTheme(selection: .system))
        .environment(SubscriptionManager())
}

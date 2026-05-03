import SwiftUI

struct TodayStickyHeader: View {
    let days: [StreakDayState]
    let selectedDayStart: Date?
    let onSelectDay: (StreakDayState) -> Void

    @Environment(\.theme) private var theme

    init(
        days: [StreakDayState],
        selectedDayStart: Date? = nil,
        onSelectDay: @escaping (StreakDayState) -> Void = { _ in }
    ) {
        self.days = days
        self.selectedDayStart = selectedDayStart
        self.onSelectDay = onSelectDay
    }

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.sm) {
            Text("Today")
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .foregroundStyle(theme.colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            TodayWeekStrip(
                days: days,
                selectedDayStart: selectedDayStart,
                onSelectDay: onSelectDay
            )

            Rectangle()
                .fill(theme.colors.border)
                .frame(height: 1)
                .padding(.horizontal, -theme.spacing.xl)
        }
        .padding(.horizontal, theme.spacing.xl)
        .padding(.top, theme.spacing.xl)
        .background {
            theme.colors.background
                .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    TodayStickyHeader(
        days: StreakCalculator.recentDays(
            completionDates: [.now],
            now: .now
        )
    )
    .environment(\.theme, ShoyoAppTheme(selection: .system))
}

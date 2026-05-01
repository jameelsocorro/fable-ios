import SwiftUI

struct TodayStickyHeader: View {
    let days: [StreakDayState]
    let selectedDayStart: Date?
    let onSelectDay: (StreakDayState) -> Void

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

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
            ZStack {
                theme.colors.background

                RadialGradient(
                    colors: [
                        theme.colors.primary.opacity(colorScheme == .dark ? 0.20 : 0.12),
                        Color.clear
                    ],
                    center: UnitPoint(x: 0.25, y: 0.15),
                    startRadius: 10,
                    endRadius: 300
                )
            }
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
    .environment(\.theme, LeviAppTheme(selection: .system))
}

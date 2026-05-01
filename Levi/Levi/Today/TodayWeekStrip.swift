import SwiftUI

struct TodayWeekStrip: View {
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
        HStack(spacing: 0) {
            ForEach(days) { day in
                TodayWeekStripDayButton(
                    day: day,
                    isSelected: isSelected(day),
                    onSelect: { onSelectDay(day) }
                )
            }
        }
        .padding(.vertical, theme.spacing.sm)
        .padding(.horizontal, theme.spacing.xs)
    }

    private func isSelected(_ day: StreakDayState) -> Bool {
        guard let selectedDayStart else { return day.isToday }
        return Calendar.current.isDate(day.dayStart, inSameDayAs: selectedDayStart)
    }
}

#Preview {
    TodayWeekStrip(
        days: StreakCalculator.recentDays(
            completionDates: [.now],
            now: .now
        )
    )
    .padding()
    .environment(\.theme, LeviAppTheme(selection: .system))
}

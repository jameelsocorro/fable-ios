import Foundation

nonisolated enum StreakCalculator {
    static func currentStreak(
        completionDates: [Date],
        now: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        let completedDays = Set(completionDates.map { calendar.startOfDay(for: $0) })
        guard !completedDays.isEmpty else { return 0 }

        var cursor = calendar.startOfDay(for: now)
        var streak = 0
        var consecutiveMisses = 0

        while consecutiveMisses < 2 {
            if completedDays.contains(cursor) {
                streak += 1
                consecutiveMisses = 0
            } else {
                consecutiveMisses += 1
            }

            guard let previousDay = calendar.date(byAdding: .day, value: -1, to: cursor) else {
                break
            }
            cursor = previousDay
        }

        return streak
    }

    static func recentDays(
        count: Int = 7,
        completionDates: [Date],
        now: Date = .now,
        calendar: Calendar = .current
    ) -> [StreakDayState] {
        let todayStart = calendar.startOfDay(for: now)
        let groupedCounts = Dictionary(grouping: completionDates) { date in
            calendar.startOfDay(for: date)
        }
        .mapValues(\.count)

        return (0..<count).reversed().compactMap { offset in
            guard let dayStart = calendar.date(byAdding: .day, value: -offset, to: todayStart) else {
                return nil
            }

            return StreakDayState(
                dayStart: dayStart,
                completionCount: groupedCounts[dayStart, default: 0],
                isToday: calendar.isDate(dayStart, inSameDayAs: todayStart)
            )
        }
    }
}

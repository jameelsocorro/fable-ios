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

    static func grid(
        for interval: DateInterval,
        completionDates: [Date],
        calendar: Calendar = .current
    ) -> [[StreakGridCell?]] {
        let countsByDay = Dictionary(grouping: completionDates) {
            calendar.startOfDay(for: $0)
        }.mapValues(\.count)

        let startOfInterval = calendar.startOfDay(for: interval.start)

        // Monday-first column: Mon=0 … Sun=6. Calendar weekday: Sun=1, Mon=2 … Sat=7.
        let weekday = calendar.component(.weekday, from: startOfInterval)
        let paddingCount = (weekday - 2 + 7) % 7

        var cells: [StreakGridCell?] = Array(repeating: nil, count: paddingCount)

        var cursor = startOfInterval
        while cursor < interval.end {
            let count = countsByDay[cursor, default: 0]
            cells.append(StreakGridCell(date: cursor, intensity: min(count, 3), isInMonth: true))
            guard let next = calendar.date(byAdding: .day, value: 1, to: cursor) else { break }
            cursor = next
        }

        // Fill trailing nils to complete the last row of 7
        let remainder = cells.count % 7
        if remainder != 0 {
            cells.append(contentsOf: Array(repeating: nil, count: 7 - remainder))
        }

        return stride(from: 0, to: cells.count, by: 7).map { start in
            Array(cells[start..<min(start + 7, cells.count)])
        }
    }

    static func completionRate(
        completionDates: [Date],
        in month: Date,
        now: Date = .now,
        calendar: Calendar = .current
    ) -> Double {
        guard !completionDates.isEmpty,
              let monthInterval = calendar.dateInterval(of: .month, for: month) else { return 0.0 }

        let monthStart = monthInterval.start
        // monthInterval.end is the exclusive start of the next month; subtract 1 day for the true last day
        guard let lastDayOfMonth = calendar.date(byAdding: .day, value: -1, to: monthInterval.end) else {
            return 0.0
        }

        let today = calendar.startOfDay(for: now)
        let upperBound = today < lastDayOfMonth ? today : lastDayOfMonth
        guard upperBound >= monthStart else { return 0.0 }

        let elapsedDays = (calendar.dateComponents([.day], from: monthStart, to: upperBound).day ?? 0) + 1
        guard elapsedDays > 0 else { return 0.0 }

        let completedDayCount = Set(
            completionDates
                .map { calendar.startOfDay(for: $0) }
                .filter { $0 >= monthStart && $0 <= upperBound }
        ).count

        return Double(completedDayCount) / Double(elapsedDays)
    }

    static func longestStreak(
        completionDates: [Date],
        now: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        let completedDays = Set(completionDates.map { calendar.startOfDay(for: $0) })
        guard let firstCompletedDay = completedDays.min() else { return 0 }

        var cursor = firstCompletedDay
        let lastDay = calendar.startOfDay(for: now)
        var currentRun = 0
        var longestRun = 0
        var consecutiveMisses = 0

        while cursor <= lastDay {
            if completedDays.contains(cursor) {
                currentRun += 1
                consecutiveMisses = 0
                longestRun = max(longestRun, currentRun)
            } else {
                consecutiveMisses += 1
                if consecutiveMisses >= 2 {
                    currentRun = 0
                    consecutiveMisses = 0
                }
            }

            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: cursor) else {
                break
            }
            cursor = nextDay
        }

        return longestRun
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

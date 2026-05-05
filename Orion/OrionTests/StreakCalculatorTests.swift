import Foundation
import Testing
@testable import Orion

struct StreakCalculatorTests {
    private let calendar: Calendar = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar
    }()

    private var now: Date {
        DateComponents(
            calendar: calendar,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: 2026,
            month: 5,
            day: 1,
            hour: 12
        ).date!
    }

    private func day(_ offset: Int) -> Date {
        calendar.date(byAdding: .day, value: offset, to: now)!
    }

    @Test func currentStreakCountsConsecutiveCompletedDays() {
        let streak = StreakCalculator.currentStreak(
            completionDates: [day(0), day(-1), day(-2)],
            now: now,
            calendar: calendar
        )

        #expect(streak == 3)
    }

    @Test func currentStreakAllowsOneMissedGraceDay() {
        let streak = StreakCalculator.currentStreak(
            completionDates: [day(0), day(-2)],
            now: now,
            calendar: calendar
        )

        #expect(streak == 2)
    }

    @Test func currentStreakResetsAfterTwoConsecutiveMisses() {
        let streak = StreakCalculator.currentStreak(
            completionDates: [day(0), day(-3)],
            now: now,
            calendar: calendar
        )

        #expect(streak == 1)
    }

    @Test func currentStreakSurvivesWhenTodayIsGraceDay() {
        let streak = StreakCalculator.currentStreak(
            completionDates: [day(-1), day(-2)],
            now: now,
            calendar: calendar
        )

        #expect(streak == 2)
    }

    @Test func currentStreakIsZeroAfterTwoMissesBeforeToday() {
        let streak = StreakCalculator.currentStreak(
            completionDates: [day(-2)],
            now: now,
            calendar: calendar
        )

        #expect(streak == 0)
    }

    @Test func currentStreakIsZeroWhenNoCompletions() {
        let streak = StreakCalculator.currentStreak(
            completionDates: [],
            now: now,
            calendar: calendar
        )

        #expect(streak == 0)
    }

    @Test func recentDaysReturnsCorrectCountWithNoCompletions() {
        let days = StreakCalculator.recentDays(
            count: 7,
            completionDates: [],
            now: now,
            calendar: calendar
        )

        #expect(days.count == 7)
        #expect(days.last?.isToday == true)
        #expect(days.allSatisfy { $0.completionCount == 0 })
    }

    @Test func recentDaysEndsWithTodayAndCountsMultipleCompletions() {
        let days = StreakCalculator.recentDays(
            count: 7,
            completionDates: [day(0), day(0), day(-2)],
            now: now,
            calendar: calendar
        )

        #expect(days.count == 7)
        #expect(days.last?.isToday == true)
        #expect(days.last?.completionCount == 2)
        #expect(days[4].completionCount == 1)
    }

    // MARK: - grid()

    @Test func gridForCurrentMonthHasExpectedRowCount() {
        // May 2026 starts Friday → 4 padding + 31 days = 35 cells = 5 rows
        guard let monthInterval = calendar.dateInterval(of: .month, for: now) else {
            Issue.record("Could not compute month interval")
            return
        }
        let grid = StreakCalculator.grid(for: monthInterval, completionDates: [], calendar: calendar)
        #expect(grid.count == 5)
        #expect(grid.allSatisfy { $0.count == 7 })
    }

    @Test func gridFirstRowHasFourLeadingNilsForMay2026() {
        // May 1 is Friday → Mon(nil) Tue(nil) Wed(nil) Thu(nil) Fri(May1) Sat(May2) Sun(May3)
        guard let monthInterval = calendar.dateInterval(of: .month, for: now) else { return }
        let grid = StreakCalculator.grid(for: monthInterval, completionDates: [], calendar: calendar)
        #expect(grid[0][0] == nil)
        #expect(grid[0][1] == nil)
        #expect(grid[0][2] == nil)
        #expect(grid[0][3] == nil)
        #expect(grid[0][4] != nil) // May 1 (Friday)
    }

    @Test func gridIntensityIsZeroForDayWithNoCompletions() {
        guard let monthInterval = calendar.dateInterval(of: .month, for: now) else { return }
        let grid = StreakCalculator.grid(for: monthInterval, completionDates: [], calendar: calendar)
        #expect(grid[0][4]?.intensity == 0) // May 1, no completions
    }

    @Test func gridIntensityTwoForTwoCompletionsOnSameDay() {
        guard let monthInterval = calendar.dateInterval(of: .month, for: now) else { return }
        let grid = StreakCalculator.grid(
            for: monthInterval,
            completionDates: [day(0), day(0)],
            calendar: calendar
        )
        #expect(grid[0][4]?.intensity == 2) // May 1, two completions
    }

    @Test func gridIntensityIsCappedAtThree() {
        guard let monthInterval = calendar.dateInterval(of: .month, for: now) else { return }
        let dates = Array(repeating: day(0), count: 5)
        let grid = StreakCalculator.grid(for: monthInterval, completionDates: dates, calendar: calendar)
        #expect(grid[0][4]?.intensity == 3) // May 1, 5 completions → capped at 3
    }

    // MARK: - completionRate()

    @Test func completionRateIsZeroWithNoCompletions() {
        let rate = StreakCalculator.completionRate(
            completionDates: [],
            in: now,
            now: now,
            calendar: calendar
        )
        #expect(rate == 0.0)
    }

    @Test func completionRateIsOneWhenOnlyElapsedDayIsCompleted() {
        // now = May 1; one completion on May 1; 1 elapsed day; 1 completed → 1.0
        let rate = StreakCalculator.completionRate(
            completionDates: [day(0)],
            in: now,
            now: now,
            calendar: calendar
        )
        #expect(rate == 1.0)
    }

    @Test func completionRateCountsDistinctDaysOnly() {
        // Two completions on same day still counts as 1 unique completed day
        let rate = StreakCalculator.completionRate(
            completionDates: [day(0), day(0)],
            in: now,
            now: now,
            calendar: calendar
        )
        #expect(rate == 1.0)
    }

    @Test func completionRateUsesElapsedDaysForCurrentMonth() {
        // now param = May 3 (day 2 offset); completions on May 1 + May 2; 3 elapsed days
        let rate = StreakCalculator.completionRate(
            completionDates: [day(0), day(1)],
            in: now,
            now: day(2),
            calendar: calendar
        )
        #expect(abs(rate - 2.0 / 3.0) < 0.001)
    }

    @Test func completionRateForPastMonthUsesFullMonthLength() {
        // April 2026 has 30 days; now = May 1; 15 completions on April 1–15 → 15/30 = 0.5
        let april1 = day(-30) // 30 days before May 1 = April 1
        let aprilCompletions = (0..<15).compactMap {
            calendar.date(byAdding: .day, value: $0, to: april1)
        }
        let rate = StreakCalculator.completionRate(
            completionDates: aprilCompletions,
            in: april1,
            now: now,
            calendar: calendar
        )
        #expect(abs(rate - 0.5) < 0.001)
    }

    // MARK: - longestStreak()

    @Test func longestStreakCountsBestRunWithGraceDay() {
        let streak = StreakCalculator.longestStreak(
            completionDates: [day(-8), day(-7), day(-5), day(-4), day(-1), day(0)],
            now: now,
            calendar: calendar
        )

        #expect(streak == 4)
    }

    @Test func longestStreakIsZeroWithNoCompletions() {
        let streak = StreakCalculator.longestStreak(
            completionDates: [],
            now: now,
            calendar: calendar
        )

        #expect(streak == 0)
    }
}

import Foundation
import Testing
@testable import Levi

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
}

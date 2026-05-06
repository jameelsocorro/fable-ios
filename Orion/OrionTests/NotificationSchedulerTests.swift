import Testing
import UserNotifications
@testable import Orion

struct NotificationSchedulerTests {
    private let calendar: Calendar = {
        var c = Calendar(identifier: .gregorian)
        c.timeZone = TimeZone(secondsFromGMT: 0)!
        return c
    }()

    // 10 AM UTC on 2026-05-06 — well before the 8 PM cutoff
    private var now: Date {
        DateComponents(
            calendar: calendar,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: 2026, month: 5, day: 6, hour: 10
        ).date!
    }

    @Test func identifierFormatsDateCorrectly() {
        let id = NotificationScheduler.identifier(for: now, calendar: calendar)
        #expect(id == "orion.daily.2026-05-06")
    }

    @Test func schedulesIncompleteUnscheduledDay() {
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [],
            pendingIdentifiers: [],
            now: now,
            windowDays: 1,
            calendar: calendar
        )
        #expect(toSchedule.count == 1)
        #expect(toCancel.isEmpty)
    }

    @Test func doesNotRescheduleAlreadyPendingDay() {
        let id = NotificationScheduler.identifier(for: now, calendar: calendar)
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [],
            pendingIdentifiers: [id],
            now: now,
            windowDays: 1,
            calendar: calendar
        )
        #expect(toSchedule.isEmpty)
        #expect(toCancel.isEmpty)
    }

    @Test func doesNotScheduleCompletedDay() {
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [now],
            pendingIdentifiers: [],
            now: now,
            windowDays: 1,
            calendar: calendar
        )
        #expect(toSchedule.isEmpty)
        #expect(toCancel.isEmpty)
    }

    @Test func cancelsCompletedDayThatIsPending() {
        let id = NotificationScheduler.identifier(for: now, calendar: calendar)
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [now],
            pendingIdentifiers: [id],
            now: now,
            windowDays: 1,
            calendar: calendar
        )
        #expect(toSchedule.isEmpty)
        #expect(toCancel == [id])
    }

    @Test func skipsTodayWhenPast8PM() {
        let late = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: 2026, month: 5, day: 6, hour: 21
        ).date!
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [],
            pendingIdentifiers: [],
            now: late,
            windowDays: 1,
            calendar: calendar
        )
        #expect(toSchedule.isEmpty)
        #expect(toCancel.isEmpty)
    }

    @Test func schedulesTomorrowWhenTodayIsPast8PM() {
        let late = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(secondsFromGMT: 0),
            year: 2026, month: 5, day: 6, hour: 21
        ).date!
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [],
            pendingIdentifiers: [],
            now: late,
            windowDays: 2,
            calendar: calendar
        )
        #expect(toSchedule.count == 1)
        let scheduledID = NotificationScheduler.identifier(for: toSchedule[0], calendar: calendar)
        #expect(scheduledID == "orion.daily.2026-05-07")
        #expect(toCancel.isEmpty)
    }

    @Test func schedulesFullWindowOfUncompletedDays() {
        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: [],
            pendingIdentifiers: [],
            now: now,
            windowDays: 14,
            calendar: calendar
        )
        #expect(toSchedule.count == 14)
        #expect(toCancel.isEmpty)
    }

    @Test func notificationRequestHasCorrectContent() {
        let request = NotificationScheduler.notificationRequest(for: now, calendar: calendar)
        #expect(request.content.title == "Time to show your work")
        #expect(request.content.body == "You haven't posted today — keep your streak alive.")
        #expect(request.identifier == "orion.daily.2026-05-06")
    }
}

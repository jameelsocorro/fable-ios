import Foundation
import UserNotifications

@MainActor
final class NotificationScheduler {

    // MARK: - Identifier

    static func identifier(for date: Date, calendar: Calendar = .current) -> String {
        let c = calendar.dateComponents([.year, .month, .day], from: date)
        let year = c.year ?? 0
        let month = c.month ?? 0
        let day = c.day ?? 0
        let mm = month < 10 ? "0\(month)" : "\(month)"
        let dd = day < 10 ? "0\(day)" : "\(day)"
        return "orion.daily.\(year)-\(mm)-\(dd)"
    }

    // MARK: - Pure scheduling logic

    static func pendingDates(
        completedDates: [Date],
        pendingIdentifiers: Set<String>,
        now: Date,
        windowDays: Int = 14,
        calendar: Calendar = .current
    ) -> (toSchedule: [Date], toCancel: [String]) {
        let todayStart = calendar.startOfDay(for: now)
        guard let cutoff = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: now)
        else { return ([], []) }

        var toSchedule: [Date] = []
        var toCancel: [String] = []

        for offset in 0..<windowDays {
            guard let day = calendar.date(byAdding: .day, value: offset, to: todayStart) else { continue }

            if offset == 0 && now >= cutoff { continue }

            let id = identifier(for: day, calendar: calendar)
            let hasCompletion = completedDates.contains { calendar.isDate($0, inSameDayAs: day) }
            let isPending = pendingIdentifiers.contains(id)

            if !hasCompletion && !isPending {
                toSchedule.append(day)
            } else if hasCompletion && isPending {
                toCancel.append(id)
            }
        }

        return (toSchedule, toCancel)
    }

    // MARK: - Notification request factory

    static func notificationRequest(for date: Date, calendar: Calendar = .current) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = "Time to show your work"
        content.body = "You haven't posted today — keep your streak alive."
        content.sound = .default
        content.badge = 1

        var fire = calendar.dateComponents([.year, .month, .day], from: date)
        fire.hour = 20
        fire.minute = 0
        fire.second = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: fire, repeats: false)
        return UNNotificationRequest(
            identifier: identifier(for: date, calendar: calendar),
            content: content,
            trigger: trigger
        )
    }

    // MARK: - Scheduling service

    func refreshWindow(completedDates: [Date]) async {
        let center = UNUserNotificationCenter.current()
        let settings = await center.notificationSettings()
        guard settings.authorizationStatus == .authorized
                || settings.authorizationStatus == .provisional else { return }

        let pending = await center.pendingNotificationRequests()
        let pendingIDs = Set(pending.map(\.identifier))

        let (toSchedule, toCancel) = NotificationScheduler.pendingDates(
            completedDates: completedDates,
            pendingIdentifiers: pendingIDs,
            now: .now
        )

        if !toCancel.isEmpty {
            center.removePendingNotificationRequests(withIdentifiers: toCancel)
        }

        for date in toSchedule {
            try? await center.add(NotificationScheduler.notificationRequest(for: date))
        }
    }
}

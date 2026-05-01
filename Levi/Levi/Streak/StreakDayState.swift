import Foundation

nonisolated struct StreakDayState: Identifiable, Equatable {
    let dayStart: Date
    let completionCount: Int
    let isToday: Bool

    var id: Date { dayStart }
    var isCompleted: Bool { completionCount > 0 }
}

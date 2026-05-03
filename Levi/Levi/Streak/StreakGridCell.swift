import Foundation

nonisolated struct StreakGridCell: Identifiable, Equatable {
    let date: Date
    let intensity: Int    // 0 = none, 1 = low, 2 = medium, 3 = full (raw count capped at 3)
    let isInMonth: Bool   // reserved for multi-month expansion; always true in current MVP

    var id: Date { date }
}

import Foundation

nonisolated struct QuestCompletionContext: Identifiable {
    let id = UUID()
    let quest: QuestDefinition
    let projectName: String
    let completedAt: Date
    let streakCount: Int
    let recentDays: [StreakDayState]
}

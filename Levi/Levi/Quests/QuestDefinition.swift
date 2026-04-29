nonisolated struct QuestDefinition: Identifiable, Hashable {
    let id: String
    let platform: SocialPlatform
    let title: String
    let isFirstSessionRecommendation: Bool
}

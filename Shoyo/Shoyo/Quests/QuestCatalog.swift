nonisolated enum QuestCatalog {
    static let all: [QuestDefinition] = [
        QuestDefinition(id: "threads-post", platform: .threads, title: "Post", isFirstSessionRecommendation: true),
        QuestDefinition(id: "x-post", platform: .x, title: "Post", isFirstSessionRecommendation: true),
        QuestDefinition(id: "linkedin-post", platform: .linkedin, title: "Post", isFirstSessionRecommendation: true),
        QuestDefinition(id: "instagram-story", platform: .instagram, title: "Post a Story", isFirstSessionRecommendation: true),
        QuestDefinition(id: "instagram-reel", platform: .instagram, title: "Post a Reel", isFirstSessionRecommendation: false),
        QuestDefinition(id: "instagram-feed", platform: .instagram, title: "Post to Feed", isFirstSessionRecommendation: false),
        QuestDefinition(id: "tiktok-post", platform: .tiktok, title: "Post a TikTok", isFirstSessionRecommendation: true),
        QuestDefinition(id: "youtube-short", platform: .youtube, title: "Post a Short", isFirstSessionRecommendation: true),
        QuestDefinition(id: "youtube-community", platform: .youtube, title: "Post a Community Update", isFirstSessionRecommendation: false),
        QuestDefinition(id: "reddit-subreddit", platform: .reddit, title: "Share in a subreddit", isFirstSessionRecommendation: true),
        QuestDefinition(id: "facebook-post", platform: .facebook, title: "Post", isFirstSessionRecommendation: true),
        QuestDefinition(id: "bluesky-post", platform: .bluesky, title: "Post", isFirstSessionRecommendation: true),
        QuestDefinition(id: "pinterest-pin", platform: .pinterest, title: "Create a Pin", isFirstSessionRecommendation: true),
        QuestDefinition(id: "snapchat-story", platform: .snapchat, title: "Post to Story", isFirstSessionRecommendation: true),
        QuestDefinition(id: "mastodon-post", platform: .mastodon, title: "Post", isFirstSessionRecommendation: true),
    ]

    static func quests(for platforms: Set<SocialPlatform>) -> [QuestDefinition] {
        all.filter { platforms.contains($0.platform) }
    }

    static func quest(id: String) -> QuestDefinition? {
        all.first { $0.id == id }
    }

    static func firstSessionRecommendations(for platforms: Set<SocialPlatform>) -> [QuestDefinition] {
        platforms
            .sorted { $0.sortIndex < $1.sortIndex }
            .compactMap { platform in
                all.first { quest in
                    quest.platform == platform && quest.isFirstSessionRecommendation
                }
            }
    }
}

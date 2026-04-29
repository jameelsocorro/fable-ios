nonisolated enum QuestCatalog {
    static let all: [QuestDefinition] = [
        QuestDefinition(id: "threads-post", platform: .threads, title: "Post on Threads", isFirstSessionRecommendation: true),
        QuestDefinition(id: "x-post", platform: .x, title: "Post on X", isFirstSessionRecommendation: true),
        QuestDefinition(id: "linkedin-post", platform: .linkedin, title: "Post on LinkedIn", isFirstSessionRecommendation: true),
        QuestDefinition(id: "instagram-story", platform: .instagram, title: "Post a Story on Instagram", isFirstSessionRecommendation: true),
        QuestDefinition(id: "instagram-reel", platform: .instagram, title: "Post a Reel on Instagram", isFirstSessionRecommendation: false),
        QuestDefinition(id: "instagram-feed", platform: .instagram, title: "Post to Feed on Instagram", isFirstSessionRecommendation: false),
        QuestDefinition(id: "tiktok-post", platform: .tiktok, title: "Post a TikTok", isFirstSessionRecommendation: true),
        QuestDefinition(id: "youtube-short", platform: .youtube, title: "Post a Short on YouTube", isFirstSessionRecommendation: true),
        QuestDefinition(id: "youtube-community", platform: .youtube, title: "Post a Community update on YouTube", isFirstSessionRecommendation: false),
        QuestDefinition(id: "reddit-subreddit", platform: .reddit, title: "Share in a relevant subreddit", isFirstSessionRecommendation: true),
        QuestDefinition(id: "facebook-post", platform: .facebook, title: "Post on Facebook", isFirstSessionRecommendation: true),
        QuestDefinition(id: "bluesky-post", platform: .bluesky, title: "Post on Bluesky", isFirstSessionRecommendation: true),
        QuestDefinition(id: "pinterest-pin", platform: .pinterest, title: "Create a Pin on Pinterest", isFirstSessionRecommendation: true),
        QuestDefinition(id: "snapchat-story", platform: .snapchat, title: "Post to Story on Snapchat", isFirstSessionRecommendation: true),
        QuestDefinition(id: "mastodon-post", platform: .mastodon, title: "Post on Mastodon", isFirstSessionRecommendation: true),
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

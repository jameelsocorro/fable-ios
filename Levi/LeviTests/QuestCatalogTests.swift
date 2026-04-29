import Testing
@testable import Levi

struct QuestCatalogTests {
    @Test func allV1PlatformsArePresent() {
        #expect(SocialPlatform.allCases.map(\.id) == [
            "threads",
            "x",
            "linkedin",
            "instagram",
            "tiktok",
            "youtube",
            "reddit",
            "facebook",
            "bluesky",
            "pinterest",
            "snapchat",
            "mastodon",
        ])
    }

    @Test func everyPlatformHasAtLeastOneQuest() {
        for platform in SocialPlatform.allCases {
            let quests = QuestCatalog.quests(for: [platform])
            #expect(!quests.isEmpty, "\(platform.displayName) needs a V1 quest")
        }
    }

    @Test func everyPlatformHasFirstSessionRecommendation() {
        for platform in SocialPlatform.allCases {
            let recommendations = QuestCatalog.firstSessionRecommendations(for: [platform])
            #expect(recommendations.count == 1)
            #expect(recommendations.first?.platform == platform)
        }
    }

    @Test func firstSessionRecommendationsFollowPlatformOrder() {
        let selected: Set<SocialPlatform> = [.youtube, .threads, .instagram]

        let recommendations = QuestCatalog.firstSessionRecommendations(for: selected)

        #expect(recommendations.map(\.platform) == [.threads, .instagram, .youtube])
    }
}

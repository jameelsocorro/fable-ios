import Testing
@testable import Orion

struct ProAccessTests {
    @Test func freeUsersCanSelectUpToTwoPlatforms() {
        #expect(ProAccess.platformLimit(hasOrionPro: false) == 2)
    }

    @Test func proUsersCanSelectAllPlatforms() {
        #expect(ProAccess.platformLimit(hasOrionPro: true) == SocialPlatform.allCases.count)
    }

    @Test func freeUsersCanAddSecondPlatform() {
        let selected: Set<SocialPlatform> = [.threads]

        #expect(ProAccess.canSelect(.instagram, selectedPlatforms: selected, hasOrionPro: false))
    }

    @Test func freeUsersCannotAddThirdPlatform() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]

        #expect(!ProAccess.canSelect(.youtube, selectedPlatforms: selected, hasOrionPro: false))
    }

    @Test func freeUsersCanDeselectEvenAtLimit() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]

        #expect(ProAccess.canSelect(.threads, selectedPlatforms: selected, hasOrionPro: false))
    }

    @Test func proUsersCanAddAnySupportedPlatform() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]

        #expect(ProAccess.canSelect(.youtube, selectedPlatforms: selected, hasOrionPro: true))
    }

    @Test func freeEffectivePlatformsKeepFirstTwoBySortOrder() {
        let selected: Set<SocialPlatform> = [.youtube, .threads, .instagram]

        #expect(ProAccess.effectivePlatforms(from: selected, hasOrionPro: false) == [.instagram, .threads])
    }

    @Test func proEffectivePlatformsKeepEverySelectedPlatform() {
        let selected: Set<SocialPlatform> = [.youtube, .threads, .instagram]

        #expect(ProAccess.effectivePlatforms(from: selected, hasOrionPro: true) == selected)
    }

    @Test func freeRecentHistoryLimitIsFourteenDays() {
        #expect(ProAccess.recentHistoryDayLimit(hasOrionPro: false) == 14)
    }

    @Test func proRecentHistoryLimitIsUnlimited() {
        #expect(ProAccess.recentHistoryDayLimit(hasOrionPro: true) == nil)
    }
}

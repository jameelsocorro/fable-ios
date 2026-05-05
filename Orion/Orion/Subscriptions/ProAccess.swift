import Foundation

nonisolated enum ProAccess {
    static let freePlatformLimit = 2
    static let freeRecentHistoryDayLimit = 14

    static func platformLimit(hasOrionPro: Bool) -> Int {
        hasOrionPro ? SocialPlatform.allCases.count : freePlatformLimit
    }

    static func canSelect(
        _ platform: SocialPlatform,
        selectedPlatforms: Set<SocialPlatform>,
        hasOrionPro: Bool
    ) -> Bool {
        if selectedPlatforms.contains(platform) {
            return true
        }

        return selectedPlatforms.count < platformLimit(hasOrionPro: hasOrionPro)
    }

    static func effectivePlatforms(
        from selectedPlatforms: Set<SocialPlatform>,
        hasOrionPro: Bool
    ) -> Set<SocialPlatform> {
        guard !hasOrionPro else { return selectedPlatforms }

        return Set(
            selectedPlatforms
                .sorted { $0.sortIndex < $1.sortIndex }
                .prefix(freePlatformLimit)
        )
    }

    static func recentHistoryDayLimit(hasOrionPro: Bool) -> Int? {
        hasOrionPro ? nil : freeRecentHistoryDayLimit
    }
}

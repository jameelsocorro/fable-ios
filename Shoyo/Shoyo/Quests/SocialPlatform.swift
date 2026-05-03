nonisolated enum SocialPlatform: String, CaseIterable, Codable, Hashable, Identifiable {
    case instagram
    case tiktok
    case threads
    case youtube
    case facebook
    case linkedin
    case x
    case bluesky
    case reddit

    var id: String { rawValue }

    init?(id: String) {
        self.init(rawValue: id)
    }

    var displayName: String {
        switch self {
        case .instagram:
            "Instagram"
        case .tiktok:
            "TikTok"
        case .threads:
            "Threads"
        case .youtube:
            "YouTube"
        case .facebook:
            "Facebook"
        case .linkedin:
            "LinkedIn"
        case .x:
            "X"
        case .bluesky:
            "Bluesky"
        case .reddit:
            "Reddit"
        }
    }

    var group: SocialPlatformGroup {
        switch self {
        case .instagram, .tiktok, .threads, .youtube, .facebook, .linkedin, .x:
            .recommended
        case .bluesky, .reddit:
            .more
        }
    }

    var sortIndex: Int {
        SocialPlatform.allCases.firstIndex(of: self) ?? 0
    }
}

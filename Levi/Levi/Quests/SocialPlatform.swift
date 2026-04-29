nonisolated enum SocialPlatform: String, CaseIterable, Codable, Hashable, Identifiable {
    case threads
    case x
    case linkedin
    case instagram
    case tiktok
    case youtube
    case reddit
    case facebook
    case bluesky
    case pinterest
    case snapchat
    case mastodon

    var id: String { rawValue }

    init?(id: String) {
        self.init(rawValue: id)
    }

    var displayName: String {
        switch self {
        case .threads:
            "Threads"
        case .x:
            "X"
        case .linkedin:
            "LinkedIn"
        case .instagram:
            "Instagram"
        case .tiktok:
            "TikTok"
        case .youtube:
            "YouTube"
        case .reddit:
            "Reddit"
        case .facebook:
            "Facebook"
        case .bluesky:
            "Bluesky"
        case .pinterest:
            "Pinterest"
        case .snapchat:
            "Snapchat"
        case .mastodon:
            "Mastodon"
        }
    }

    var group: SocialPlatformGroup {
        switch self {
        case .threads, .x, .linkedin, .instagram, .tiktok, .youtube, .reddit:
            .recommended
        case .facebook, .bluesky, .pinterest, .snapchat, .mastodon:
            .more
        }
    }

    var sortIndex: Int {
        SocialPlatform.allCases.firstIndex(of: self) ?? 0
    }
}

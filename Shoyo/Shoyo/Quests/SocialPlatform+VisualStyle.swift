import SwiftUI

extension SocialPlatform {
    var accentColor: Color {
        switch self {
        case .instagram:
            .pink
        case .tiktok:
            .cyan
        case .threads:
            .primary
        case .youtube:
            .red
        case .facebook:
            .blue
        case .linkedin:
            .blue
        case .x:
            .primary
        case .bluesky:
            .cyan
        case .reddit:
            .orange
        }
    }

    var symbolName: String {
        switch self {
        case .instagram:
            "camera"
        case .tiktok:
            "music.note"
        case .threads:
            "at"
        case .youtube:
            "play.rectangle"
        case .facebook:
            "person.2"
        case .linkedin:
            "briefcase"
        case .x:
            "xmark"
        case .bluesky:
            "cloud"
        case .reddit:
            "bubble.left.and.bubble.right"
        }
    }

    var customImageName: String? {
        switch self {
        case .instagram: "Social.Insta"
        case .x:         "Social.X"
        case .tiktok:    "Social.Tiktok"
        case .youtube:   "Social.Youtube"
        case .linkedin:  "Social.LinkedIn"
        case .threads:   "Social.Threads"
        case .reddit:    "Social.Reddit"
        case .bluesky:   "Social.Bluesky"
        case .facebook:  "Social.Facebook"
        }
    }
}

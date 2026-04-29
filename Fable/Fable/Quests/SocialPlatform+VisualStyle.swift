import SwiftUI

extension SocialPlatform {
    var accentColor: Color {
        switch self {
        case .threads:
            .primary
        case .x:
            .primary
        case .linkedin:
            .blue
        case .instagram:
            .pink
        case .tiktok:
            .cyan
        case .youtube:
            .red
        case .reddit:
            .orange
        case .facebook:
            .blue
        case .bluesky:
            .cyan
        case .pinterest:
            .red
        case .snapchat:
            .yellow
        case .mastodon:
            .purple
        }
    }

    var symbolName: String {
        switch self {
        case .threads:
            "at"
        case .x:
            "xmark"
        case .linkedin:
            "briefcase"
        case .instagram:
            "camera"
        case .tiktok:
            "music.note"
        case .youtube:
            "play.rectangle"
        case .reddit:
            "bubble.left.and.bubble.right"
        case .facebook:
            "person.2"
        case .bluesky:
            "cloud"
        case .pinterest:
            "pin"
        case .snapchat:
            "bolt"
        case .mastodon:
            "megaphone"
        }
    }
}

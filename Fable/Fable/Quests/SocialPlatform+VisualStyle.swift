import SwiftUI
import ColorTokensKit

extension SocialPlatform {
    var accentColor: Color {
        switch self {
        case .threads:
            Color.proGray._800.toColor()
        case .x:
            Color.proGray._900.toColor()
        case .linkedin:
            Color.proBlue.fableAccent
        case .instagram:
            Color.proRuby.fableAccent
        case .tiktok:
            Color.proCyan.fableAccent
        case .youtube:
            Color.proRed.fableAccent
        case .reddit:
            Color.proOrange.fableAccent
        case .facebook:
            Color.proBlue.fableAccent
        case .bluesky:
            Color.proSky.fableAccent
        case .pinterest:
            Color.proRuby.fableAccent
        case .snapchat:
            Color.proYellow.fableAccent
        case .mastodon:
            Color.proPurple.fableAccent
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

import SwiftUI

extension SocialPlatform {
    var accentColor: Color {
        switch self {
        case .instagram:
            Color(hex: "#C84393")
        case .tiktok:
            .black
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

    var accentFillStyle: AnyShapeStyle {
        switch self {
        case .instagram:
            AnyShapeStyle(instagramGradient)
        default:
            AnyShapeStyle(accentColor)
        }
    }

    var accentGradient: LinearGradient {
        switch self {
        case .instagram:
            instagramGradient
        default:
            LinearGradient(
                colors: [
                    accentColor.opacity(0.72),
                    accentColor
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private var instagramGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color(hex: "#C84393"),
                Color(hex: "#FB7A4F")
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
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

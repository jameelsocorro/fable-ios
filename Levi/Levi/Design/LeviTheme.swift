import SwiftUI

enum LeviTheme: String, CaseIterable, Identifiable {
    case system
    case sage
    case sand
    case earth
    case sky
    case ruby

    static let storageKey = "selectedTheme"

    var id: String { rawValue }

    init(storedValue: String) {
        self = Self(rawValue: storedValue) ?? .system
    }

    var displayName: String {
        switch self {
        case .system:
            "System"
        case .sage:
            "Sage"
        case .sand:
            "Sand"
        case .earth:
            "Earth"
        case .sky:
            "Sky"
        case .ruby:
            "Ruby"
        }
    }

    var accentColor: Color {
        Color(hex: "#F07820")
    }
}

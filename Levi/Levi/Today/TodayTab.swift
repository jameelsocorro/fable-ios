import Foundation

nonisolated enum TodayTab: String, CaseIterable, Identifiable {
    case home
    case streaks
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .streaks:
            "Streaks"
        case .settings:
            "Settings"
        }
    }

    var symbolName: String {
        switch self {
        case .home:
            "square.fill"
        case .streaks:
            "flame.fill"
        case .settings:
            "gearshape.fill"
        }
    }
}

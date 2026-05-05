import Foundation

nonisolated enum AppTab: String, CaseIterable, Hashable, Identifiable {
    case today
    case streaks
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .today:
            "Today"
        case .streaks:
            "Streaks"
        case .settings:
            "Settings"
        }
    }

    var symbolName: String {
        switch self {
        case .today:
            "checkmark.circle.fill"
        case .streaks:
            "flame.fill"
        case .settings:
            "gearshape.fill"
        }
    }
}

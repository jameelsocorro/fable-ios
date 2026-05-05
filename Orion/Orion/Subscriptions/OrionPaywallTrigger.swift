import Foundation

nonisolated enum OrionPaywallTrigger: String, Identifiable {
    case platformLimit
    case settingsUpgrade
    case fullHistory
    case advancedAnalytics

    var id: String { rawValue }

    var analyticsName: String {
        rawValue
    }
}

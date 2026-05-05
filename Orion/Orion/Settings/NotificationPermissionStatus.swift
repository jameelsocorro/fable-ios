import UserNotifications

nonisolated enum NotificationPermissionStatus: Equatable {
    case allowed
    case denied
    case notDetermined
    case provisional
    case ephemeral
    case unknown

    init(authorizationStatus: UNAuthorizationStatus) {
        switch authorizationStatus {
        case .authorized:
            self = .allowed
        case .denied:
            self = .denied
        case .notDetermined:
            self = .notDetermined
        case .provisional:
            self = .provisional
        case .ephemeral:
            self = .ephemeral
        @unknown default:
            self = .unknown
        }
    }

    var displayName: String {
        switch self {
        case .allowed:
            "Allowed"
        case .denied:
            "Denied"
        case .notDetermined:
            "Not Determined"
        case .provisional:
            "Provisional"
        case .ephemeral:
            "Ephemeral"
        case .unknown:
            "Unknown"
        }
    }

    var canRequestPermission: Bool {
        self == .notDetermined
    }
}

import Testing
import UserNotifications
@testable import Shoyo

struct NotificationPermissionStatusTests {
    @Test
    func displayNamesMatchSettingsCopy() {
        #expect(NotificationPermissionStatus.allowed.displayName == "Allowed")
        #expect(NotificationPermissionStatus.denied.displayName == "Denied")
        #expect(NotificationPermissionStatus.notDetermined.displayName == "Not Determined")
        #expect(NotificationPermissionStatus.provisional.displayName == "Provisional")
        #expect(NotificationPermissionStatus.ephemeral.displayName == "Ephemeral")
        #expect(NotificationPermissionStatus.unknown.displayName == "Unknown")
    }

    @Test
    func authorizationStatusMapsToDisplayStatus() {
        #expect(NotificationPermissionStatus(authorizationStatus: .authorized) == .allowed)
        #expect(NotificationPermissionStatus(authorizationStatus: .denied) == .denied)
        #expect(NotificationPermissionStatus(authorizationStatus: .notDetermined) == .notDetermined)
        #expect(NotificationPermissionStatus(authorizationStatus: .provisional) == .provisional)
        #expect(NotificationPermissionStatus(authorizationStatus: .ephemeral) == .ephemeral)
    }

    @Test
    func onlyNotDeterminedRequestsPermission() {
        #expect(NotificationPermissionStatus.notDetermined.canRequestPermission)
        #expect(!NotificationPermissionStatus.allowed.canRequestPermission)
        #expect(!NotificationPermissionStatus.denied.canRequestPermission)
    }
}

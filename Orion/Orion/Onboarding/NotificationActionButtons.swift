import SwiftUI
import UserNotifications

struct NotificationActionButtons: View {
    let contentVisible: Bool
    let permissionStatus: NotificationPermissionStatus
    let continueAction: () -> Void

    @Environment(\.theme) private var theme
    @Environment(\.openURL) private var openExternalURL

    var body: some View {
        VStack(spacing: theme.spacing.md) {
            Button(allowButtonTitle, action: handleAllow)
                .buttonStyle(OrionPrimaryButtonStyle())
                .padding(.horizontal, theme.spacing.xl)
                .opacity(contentVisible ? 1 : 0)
                .offset(y: contentVisible ? 0 : 16)

            Button("Skip for now", action: continueAction)
                .font(.subheadline)
                .foregroundStyle(theme.colors.textSecondary)
                .padding(.vertical, theme.spacing.sm)
                .opacity(contentVisible ? 1 : 0)
        }
    }

    private var allowButtonTitle: String {
        permissionStatus == .denied ? "Open Settings" : "Allow Notifications"
    }

    private func handleAllow() {
        Task {
            switch permissionStatus {
            case .notDetermined:
                _ = try? await UNUserNotificationCenter.current()
                    .requestAuthorization(options: [.alert, .badge, .sound])
                continueAction()
            case .allowed, .provisional, .ephemeral:
                continueAction()
            case .denied, .unknown:
                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                    openExternalURL(url)
                }
            }
        }
    }
}

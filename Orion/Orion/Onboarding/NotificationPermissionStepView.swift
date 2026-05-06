import SwiftUI
import UserNotifications

struct NotificationPermissionStepView: View {
    let continueAction: () -> Void

    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var permissionStatus: NotificationPermissionStatus = .notDetermined
    @State private var contentVisible = false

    var body: some View {
        ZStack {
            theme.colors.background.ignoresSafeArea()
            PageGradientBackground(center: UnitPoint(x: 0.30, y: 0.65))

            VStack(spacing: 0) {
                Spacer()
                CompanionBubbleView(
                    imageName: "OreoAlarmClock",
                    message: "I'll remind you\nevery evening!",
                    animateTyping: true,
                    showSpeechBubble: false,
                    floatDelay: 0.45,
                    bubbleDelay: 0.37,                    
                )
                Spacer().frame(height: 40)
                NotificationHeroText(contentVisible: contentVisible)
                Spacer()
                NotificationActionButtons(
                    contentVisible: contentVisible,
                    permissionStatus: permissionStatus,
                    continueAction: continueAction
                )
                Spacer().frame(height: theme.spacing.xl)
            }
            .frame(maxWidth: .infinity)
        }
        .task {
            await refreshPermissionStatus()
            if !reduceMotion {
                try? await Task.sleep(for: .milliseconds(540))
            }
            withAnimation(reduceMotion ? nil : .spring(response: 0.60, dampingFraction: 0.82)) {
                contentVisible = true
            }
        }
    }

    @MainActor
    private func refreshPermissionStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        permissionStatus = NotificationPermissionStatus(authorizationStatus: settings.authorizationStatus)
    }
}

#Preview {
    NotificationPermissionStepView(continueAction: {})
        .environment(\.theme, OrionAppTheme(selection: .system))
}

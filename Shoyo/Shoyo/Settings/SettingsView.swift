import SwiftUI
import SwiftData
import UIKit
import UserNotifications

struct SettingsView: View {
    let profile: FounderProfile

    @AppStorage(AppAppearance.storageKey) private var selectedAppearanceRawValue = AppAppearance.system.rawValue
    @Environment(\.openURL) private var openExternalURL
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.theme) private var theme
    @State private var notificationStatus: NotificationPermissionStatus = .unknown
    @State private var isShowingLinkError = false
    @State private var linkErrorMessage = ""
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        NavigationStack {
            List {
                Section("Appearance") {
                    ForEach(AppAppearance.allCases) { appearance in
                        Button {
                            selectAppearance(appearance)
                        } label: {
                            HStack(spacing: theme.spacing.md) {
                                Label(appearance.displayName, systemImage: appearance.symbolName)

                                Spacer()

                                if selectedAppearance == appearance {
                                    Image(systemName: "checkmark")
                                        .bold()
                                        .foregroundStyle(theme.colors.primary)
                                        .accessibilityHidden(true)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .accessibilityValue(selectedAppearance == appearance ? "Selected" : "Not Selected")
                        .accessibilityAddTraits(selectedAppearance == appearance ? .isSelected : [])
                    }
                }

                Section("Platforms") {
                    NavigationLink {
                        SettingsPlatformEditorView(profile: profile)
                    } label: {
                        HStack {
                            Label("Manage Platforms", systemImage: "circle.grid.3x3.fill")

                            Spacer()

                            Text(platformSummary)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                    }
                }

                Section("Billing") {
                    Button {
                        open(SettingsLinks.manageSubscription, label: "Manage Subscription")
                    } label: {
                        HStack {
                            Label("Manage Subscription", systemImage: "creditcard")

                            Spacer()

                            Image(systemName: "arrow.up.forward.square")
                                .foregroundStyle(.secondary)
                                .accessibilityHidden(true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }

                Section("Permissions") {
                    Button(action: handleNotificationTap) {
                        HStack {
                            Label("Notifications", systemImage: "bell.badge")

                            Spacer()

                            Text(notificationStatus.displayName)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityValue(notificationStatus.displayName)
                }

                Section("Support") {
                    supportRow(title: "Rate Shoyo", systemImage: "star", url: SettingsLinks.rateShoyo)
                    supportRow(title: "Support", systemImage: "questionmark.circle", url: SettingsLinks.support)
                    supportRow(title: "Privacy Policy", systemImage: "lock.shield", url: SettingsLinks.privacyPolicy)
                    supportRow(title: "Terms of Service", systemImage: "doc.text", url: SettingsLinks.termsOfService)
                }

                Section {
                } footer: {
                    Text(versionFooter)
                }
            }
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .top, spacing: 0) {
                ShoyoScreenTitle("Settings", scrollOffset: scrollOffset)
            }
            .toolbar(.hidden, for: .navigationBar)
            .tint(theme.colors.primary)
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                max(geometry.contentOffset.y, 0)
            } action: { _, newValue in
                scrollOffset = newValue
            }
            .task {
                await refreshNotificationStatus()
            }
            .onChange(of: scenePhase) { _, newPhase in
                guard newPhase == .active else { return }

                Task {
                    await refreshNotificationStatus()
                }
            }
            .alert("Unable to Open Link", isPresented: $isShowingLinkError) {
            } message: {
                Text(linkErrorMessage)
            }
        }
    }

    private var selectedAppearance: AppAppearance {
        AppAppearance(storedValue: selectedAppearanceRawValue)
    }

    private var platformSummary: String {
        let count = profile.selectedPlatforms.count
        return count == 1 ? "1 platform" : "\(count) platforms"
    }

    private var versionFooter: String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
        return "Version \(version) (\(build))"
    }

    private func selectAppearance(_ appearance: AppAppearance) {
        selectedAppearanceRawValue = appearance.rawValue
    }

    @ViewBuilder
    private func supportRow(title: String, systemImage: String, url: URL?) -> some View {
        if let url {
            Button {
                open(url, label: title)
            } label: {
                HStack {
                    Label(title, systemImage: systemImage)

                    Spacer()

                    Image(systemName: "arrow.up.forward.square")
                        .foregroundStyle(.secondary)
                        .accessibilityHidden(true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        } else {
            LabeledContent {
                Text("Not Available Yet")
                    .foregroundStyle(.secondary)
            } label: {
                Label(title, systemImage: systemImage)
            }
        }
    }

    private func open(_ url: URL, label: String) {
        openExternalURL(url) { accepted in
            guard !accepted else { return }

            Task { @MainActor in
                linkErrorMessage = "\(label) is not available right now."
                isShowingLinkError = true
            }
        }
    }

    private func handleNotificationTap() {
        Task {
            if notificationStatus.canRequestPermission {
                do {
                    _ = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                    await refreshNotificationStatus()
                } catch {
                    await MainActor.run {
                        linkErrorMessage = "Notification permission could not be updated. Please try again."
                        isShowingLinkError = true
                    }
                }
            } else {
                await MainActor.run {
                    openNotificationSettings()
                }
            }
        }
    }

    private func openNotificationSettings() {
        guard let notificationSettingsURL = URL(string: UIApplication.openNotificationSettingsURLString) else {
            guard let appSettingsURL = URL(string: UIApplication.openSettingsURLString) else {
                linkErrorMessage = "Notification Settings is not available right now."
                isShowingLinkError = true
                return
            }

            open(appSettingsURL, label: "Notification Settings")
            return
        }

        open(notificationSettingsURL, label: "Notification Settings")
    }

    @MainActor
    private func refreshNotificationStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        notificationStatus = NotificationPermissionStatus(authorizationStatus: settings.authorizationStatus)
    }
}

#Preview {
    let profile = FounderProfile(
        projectName: "Shoyo",
        selectedPlatformIDs: ["threads", "instagram", "tiktok"],
        hasCompletedOnboarding: true,
        onboardingStep: .complete
    )

    SettingsView(profile: profile)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(\.theme, ShoyoAppTheme(selection: .system))
}

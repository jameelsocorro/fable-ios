import SwiftUI
import SwiftData
import UIKit
import UserNotifications

struct SettingsView: View {
    let profile: FounderProfile

    @AppStorage(AppAppearance.storageKey) private var selectedAppearanceRawValue = AppAppearance.system.rawValue
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.openURL) private var openExternalURL
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.theme) private var theme
    @State private var notificationStatus: NotificationPermissionStatus = .unknown
    @State private var isShowingLinkError = false
    @State private var linkErrorMessage = ""
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        NavigationStack {
            settingsList
            .scrollIndicators(.hidden)
            .safeAreaInset(edge: .top, spacing: 0) {
                screenTitle
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

    private var settingsList: some View {
        List {
            appearanceSection
            platformSection
            billingSection
            notificationSection
            supportSection
            versionFooterSection
        }
    }

    private var screenTitle: some View {
        HStack {
            Text("Settings")
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .foregroundStyle(theme.colors.textPrimary)
                .scaleEffect(titleScale, anchor: .leading)
                .accessibilityAddTraits(.isHeader)

            Spacer()
        }
        .padding(.horizontal, theme.spacing.xl)
        .padding(.top, titleTopPadding)
        .padding(.bottom, titleBottomPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            theme.colors.background
                .ignoresSafeArea(edges: .top)
        }
        .animation(reduceMotion ? nil : .spring(response: 0.22, dampingFraction: 0.86), value: isTitleCollapsed)
    }

    private var appearanceSection: some View {
        Section("Appearance") {
            ForEach(AppAppearance.allCases) { appearance in
                appearanceRow(for: appearance)
            }
        }
    }

    private var platformSection: some View {
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
    }

    private var billingSection: some View {
        Section("Billing") {
            externalLinkRow(
                title: "Manage Subscription",
                systemImage: "creditcard",
                url: SettingsLinks.manageSubscription
            )
        }
    }

    private var notificationSection: some View {
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
    }

    private var supportSection: some View {
        Section("Support") {
            externalLinkRow(title: "Rate Shoyo", systemImage: "star", url: SettingsLinks.rateShoyo)
            externalLinkRow(title: "Support", systemImage: "questionmark.circle", url: SettingsLinks.support)
            externalLinkRow(title: "Privacy Policy", systemImage: "lock.shield", url: SettingsLinks.privacyPolicy)
            externalLinkRow(title: "Terms of Service", systemImage: "doc.text", url: SettingsLinks.termsOfService)
        }
    }

    private var versionFooterSection: some View {
        Section {
        } footer: {
            Text(versionFooter)
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

    private var titleProgress: CGFloat {
        min(max(scrollOffset / 56, 0), 1)
    }

    private var isTitleCollapsed: Bool {
        titleProgress > 0.5
    }

    private var titleScale: CGFloat {
        1 - (0.22 * titleProgress)
    }

    private var titleTopPadding: CGFloat {
        theme.spacing.lg - (theme.spacing.sm * titleProgress)
    }

    private var titleBottomPadding: CGFloat {
        theme.spacing.sm - (theme.spacing.xs * titleProgress)
    }

    private func selectAppearance(_ appearance: AppAppearance) {
        selectedAppearanceRawValue = appearance.rawValue
    }

    private func appearanceRow(for appearance: AppAppearance) -> some View {
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
        .accessibilityAddTraits(accessibilityTraits(for: appearance))
    }

    @ViewBuilder
    private func externalLinkRow(title: String, systemImage: String, url: URL?) -> some View {
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

    private func accessibilityTraits(for appearance: AppAppearance) -> AccessibilityTraits {
        selectedAppearance == appearance ? .isSelected : AccessibilityTraits()
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

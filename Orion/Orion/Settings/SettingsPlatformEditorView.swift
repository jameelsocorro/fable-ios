import SwiftUI
import SwiftData

struct SettingsPlatformEditorView: View {
    let profile: FounderProfile

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(SubscriptionManager.self) private var subscriptionManager
    @Environment(\.theme) private var theme
    @State private var draftPlatforms: Set<SocialPlatform>
    @State private var isShowingSaveError = false
    @State private var activePaywallTrigger: OrionPaywallTrigger?
    @State private var pendingPlatformAfterPurchase: SocialPlatform?

    init(profile: FounderProfile) {
        self.profile = profile
        _draftPlatforms = State(initialValue: profile.selectedPlatforms)
    }

    var body: some View {
        List {
            Section {
                ForEach(SocialPlatform.allCases) { platform in
                    Button {
                        toggle(platform)
                    } label: {
                        HStack(spacing: theme.spacing.md) {
                            Label(platform.displayName, systemImage: platform.symbolName)

                            Spacer()

                            if draftPlatforms.contains(platform) {
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
                    .accessibilityValue(draftPlatforms.contains(platform) ? "Selected" : "Not Selected")
                    .accessibilityAddTraits(accessibilityTraits(for: platform))
                }
            } footer: {
                Text(subscriptionManager.hasOrionPro
                    ? "Keep at least one platform selected so Orion can keep your quest list focused."
                    : "Free keeps you focused on 2 platforms. Orion Pro unlocks every supported platform.")
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Platforms")
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", action: save)
                    .disabled(!canSave)
            }
        }
        .alert("Unable to Save Platforms", isPresented: $isShowingSaveError) {
        } message: {
            Text("Your platform changes could not be saved. Please try again.")
        }
        .sheet(item: $activePaywallTrigger) { trigger in
            OrionPaywallSheet(trigger: trigger) {
                applyPendingPlatformIfPro()
            }
        }
    }

    private var canSave: Bool {
        SettingsPlatformSelection.canSave(draftPlatforms) && draftPlatforms != profile.selectedPlatforms
    }

    private func toggle(_ platform: SocialPlatform) {
        switch SettingsPlatformSelection.toggled(
            platform,
            in: draftPlatforms,
            hasOrionPro: subscriptionManager.hasOrionPro
        ) {
        case .updated(let updatedPlatforms):
            draftPlatforms = updatedPlatforms
        case .requiresPro:
            pendingPlatformAfterPurchase = platform
            activePaywallTrigger = .platformLimit
        }
    }

    private func applyPendingPlatformIfPro() {
        guard subscriptionManager.hasOrionPro, let pendingPlatformAfterPurchase else { return }

        draftPlatforms.insert(pendingPlatformAfterPurchase)
        self.pendingPlatformAfterPurchase = nil
    }

    private func accessibilityTraits(for platform: SocialPlatform) -> AccessibilityTraits {
        draftPlatforms.contains(platform) ? .isSelected : AccessibilityTraits()
    }

    private func save() {
        let previousPlatforms = profile.selectedPlatforms
        profile.selectedPlatforms = draftPlatforms

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            profile.selectedPlatforms = previousPlatforms
            isShowingSaveError = true
        }
    }
}

#Preview {
    NavigationStack {
        SettingsPlatformEditorView(
            profile: FounderProfile(
                projectName: "Orion",
                selectedPlatformIDs: ["threads", "instagram"],
                hasCompletedOnboarding: true,
                onboardingStep: .complete
            )
        )
    }
    .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
    .environment(\.theme, OrionAppTheme(selection: .system))
    .environment(SubscriptionManager())
}

import SwiftUI
import SwiftData

struct OnboardingFlowView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(SubscriptionManager.self) private var subscriptionManager

    @State private var activeProfile: FounderProfile?
    @State private var step: OnboardingStep
    @State private var selectedPlatforms: Set<SocialPlatform>

    init(existingProfile: FounderProfile?) {
        _activeProfile = State(initialValue: existingProfile)
        _step = State(initialValue: existingProfile?.onboardingStep ?? .welcome)
        _selectedPlatforms = State(initialValue: existingProfile?.selectedPlatforms ?? [])
    }

    var body: some View {
        NavigationStack {
            switch step {
            case .welcome:
                WelcomeStepView(start: start)
            case .platformPicker:
                PlatformPickerStepView(
                    selectedPlatforms: $selectedPlatforms,
                    hasOrionPro: subscriptionManager.hasOrionPro,
                    continueAction: savePlatforms
                )
            case .notificationPermission:
                NotificationPermissionStepView(continueAction: continueToApp)
            case .dayOneCelebration, .complete:
                if let activeProfile {
                    TodayView(profile: activeProfile)
                } else {
                    EmptyView()
                }
            }
        }
    }

    private func ensureProfile() -> FounderProfile {
        if let activeProfile {
            return activeProfile
        }

        let profile = FounderProfile()
        modelContext.insert(profile)
        activeProfile = profile
        return profile
    }

    private func setStep(_ newStep: OnboardingStep) {
        let profile = ensureProfile()
        profile.onboardingStep = newStep
        step = newStep
    }

    private func start() {
        setStep(.platformPicker)
    }

    private func savePlatforms() {
        guard !selectedPlatforms.isEmpty else { return }

        let profile = ensureProfile()
        profile.selectedPlatforms = selectedPlatforms
        setStep(.notificationPermission)
    }

    private func continueToApp() {
        let profile = ensureProfile()
        profile.hasCompletedOnboarding = true
        profile.onboardingCompletedAt = .now
        setStep(.complete)
    }
}

#Preview {
    OnboardingFlowView(existingProfile: nil)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(SubscriptionManager())
}

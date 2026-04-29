import Testing
@testable import Levi

@MainActor
struct FounderProfileTests {
    @Test func selectedPlatformsRoundTripThroughStoredIDs() {
        let profile = FounderProfile()

        profile.selectedPlatforms = [.instagram, .threads, .youtube]

        #expect(profile.selectedPlatformIDs == ["threads", "instagram", "youtube"])
        #expect(profile.selectedPlatforms == [.threads, .instagram, .youtube])
    }

    @Test func routeStaysInOnboardingUntilCelebrationIsDismissed() {
        let profile = FounderProfile()
        profile.hasCompletedOnboarding = true
        profile.onboardingStep = .dayOneCelebration

        #expect(AppRoute.route(for: profile) == .onboarding)
    }

    @Test func routeMovesToTodayOnlyAfterCompleteStep() {
        let profile = FounderProfile()
        profile.hasCompletedOnboarding = true
        profile.onboardingStep = .complete

        #expect(AppRoute.route(for: profile) == .today)
    }

    @Test func preferredProfilePrioritizesCompletedOnboarding() {
        let onboardingProfile = FounderProfile()
        onboardingProfile.onboardingStep = .platformPicker

        let completedProfile = FounderProfile()
        completedProfile.hasCompletedOnboarding = true
        completedProfile.onboardingStep = .complete
        completedProfile.onboardingCompletedAt = .now

        let selected = AppRoute.preferredProfile(from: [onboardingProfile, completedProfile])

        #expect(selected === completedProfile)
    }

    @Test func preferredProfileIsDeterministicAcrossInputOrder() {
        let first = FounderProfile(projectName: "Alpha")
        let second = FounderProfile(projectName: "Beta")

        let selectedFromOriginalOrder = AppRoute.preferredProfile(from: [first, second])
        let selectedFromReversedOrder = AppRoute.preferredProfile(from: [second, first])

        #expect(selectedFromOriginalOrder?.persistentModelID == selectedFromReversedOrder?.persistentModelID)
    }
}

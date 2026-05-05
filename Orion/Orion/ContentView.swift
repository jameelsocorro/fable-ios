import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var profiles: [FounderProfile]

    private var activeProfile: FounderProfile? {
        AppRoute.preferredProfile(from: profiles)
    }

    var body: some View {
        switch AppRoute.route(for: activeProfile) {
        case .onboarding:
            OnboardingFlowView(existingProfile: activeProfile)
        case .today:
            if let activeProfile {
                MainTabView(profile: activeProfile)
            } else {
                OnboardingFlowView(existingProfile: nil)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(SubscriptionManager())
}

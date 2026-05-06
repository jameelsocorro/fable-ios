import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var profiles: [FounderProfile]

    private var activeProfile: FounderProfile? {
        AppRoute.preferredProfile(from: profiles)
    }

    private var route: AppRoute {
        AppRoute.route(for: activeProfile)
    }

    var body: some View {
        ZStack {
            switch route {
            case .onboarding:
                OnboardingFlowView(existingProfile: activeProfile)
                    .transition(.asymmetric(insertion: .identity, removal: .opacity))
            case .today:
                if let activeProfile {
                    MainTabView(profile: activeProfile)
                        .transition(.asymmetric(insertion: .opacity, removal: .identity))
                } else {
                    OnboardingFlowView(existingProfile: nil)
                }
            }
        }
        .animation(.easeInOut(duration: 0.8), value: route)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(SubscriptionManager())
}

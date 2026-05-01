import SwiftUI
import SwiftData

struct MainTabView: View {
    let profile: FounderProfile

    @Environment(\.theme) private var theme
    @State private var selectedTab = AppTab.today

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(AppTab.today.title, systemImage: AppTab.today.symbolName, value: AppTab.today) {
                TodayView(profile: profile)
            }

            Tab(AppTab.streaks.title, systemImage: AppTab.streaks.symbolName, value: AppTab.streaks) {
                TabPlaceholderView(
                    tab: .streaks,
                    description: "Your streak heatmap and history will live here."
                )
            }

            Tab(AppTab.settings.title, systemImage: AppTab.settings.symbolName, value: AppTab.settings) {
                TabPlaceholderView(
                    tab: .settings,
                    description: "Project, platform, and theme settings will live here."
                )
            }
        }
        .tint(theme.colors.primary)
    }
}

#Preview {
    let profile = FounderProfile(
        projectName: "Levi",
        selectedPlatformIDs: ["threads", "instagram", "tiktok"],
        hasCompletedOnboarding: true,
        onboardingStep: .complete
    )

    MainTabView(profile: profile)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
        .environment(\.theme, LeviAppTheme(selection: .system))
}

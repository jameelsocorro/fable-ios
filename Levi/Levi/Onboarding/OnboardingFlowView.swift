import SwiftUI
import SwiftData

struct OnboardingFlowView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var activeProfile: FounderProfile?
    @State private var step: OnboardingStep
    @State private var selectedPlatforms: Set<SocialPlatform>
    @State private var selectedQuest: QuestDefinition?

    init(existingProfile: FounderProfile?) {
        _activeProfile = State(initialValue: existingProfile)
        _step = State(initialValue: existingProfile?.onboardingStep ?? .welcome)
        _selectedPlatforms = State(initialValue: existingProfile?.selectedPlatforms ?? [])

        let firstQuest = existingProfile?.firstQuestID.flatMap(QuestCatalog.quest(id:))
        _selectedQuest = State(initialValue: firstQuest)
    }

    var body: some View {
        NavigationStack {
            switch step {
            case .welcome:
                WelcomeStepView(start: start)
            case .platformPicker:
                PlatformPickerStepView(selectedPlatforms: $selectedPlatforms, continueAction: savePlatforms)
            case .firstQuestPicker:
                FirstQuestPickerStepView(quests: QuestCatalog.firstSessionRecommendations(for: selectedPlatforms), selectQuest: selectQuest)
            case .holdToCommit:
                if let selectedQuest {
                    HoldToCommitStepView(quest: selectedQuest, commitAction: commitSelectedQuest)
                } else {
                    FirstQuestPickerStepView(quests: QuestCatalog.firstSessionRecommendations(for: selectedPlatforms), selectQuest: selectQuest)
                }
            case .dayOneCelebration:
                DayOneCelebrationView(viewToday: finishCelebration)
            case .complete:
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
        guard !selectedPlatforms.isEmpty else {
            return
        }

        ensureProfile().selectedPlatforms = selectedPlatforms
        setStep(.firstQuestPicker)
    }

    private func selectQuest(_ quest: QuestDefinition) {
        selectedQuest = quest
        ensureProfile().firstQuestID = quest.id
        setStep(.holdToCommit)
    }

    private func commitSelectedQuest() {
        guard let selectedQuest else {
            return
        }

        let profile = ensureProfile()
        profile.firstQuestID = selectedQuest.id
        profile.selectedPlatforms = selectedPlatforms
        profile.hasCompletedOnboarding = true
        profile.onboardingCompletedAt = .now
        profile.onboardingStep = .dayOneCelebration

        let completion = QuestCompletion(questID: selectedQuest.id, platform: selectedQuest.platform)
        modelContext.insert(completion)

        step = .dayOneCelebration
    }

    private func finishCelebration() {
        setStep(.complete)
    }
}

#Preview {
    OnboardingFlowView(existingProfile: nil)
        .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
}

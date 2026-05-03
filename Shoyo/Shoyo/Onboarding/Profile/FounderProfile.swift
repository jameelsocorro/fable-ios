import Foundation
import SwiftData

@Model
final class FounderProfile {
    var projectName: String?
    var selectedPlatformIDs: [String]
    var hasCompletedOnboarding: Bool
    var onboardingCompletedAt: Date?
    var onboardingStepRawValue: String

    init(
        projectName: String? = nil,
        selectedPlatformIDs: [String] = [],
        hasCompletedOnboarding: Bool = false,
        onboardingCompletedAt: Date? = nil,
        onboardingStep: OnboardingStep = .welcome
    ) {
        self.projectName = projectName
        self.selectedPlatformIDs = selectedPlatformIDs
        self.hasCompletedOnboarding = hasCompletedOnboarding
        self.onboardingCompletedAt = onboardingCompletedAt
        self.onboardingStepRawValue = onboardingStep.rawValue
    }

    var onboardingStep: OnboardingStep {
        get { OnboardingStep(rawValue: onboardingStepRawValue) ?? .welcome }
        set { onboardingStepRawValue = newValue.rawValue }
    }

    var selectedPlatforms: Set<SocialPlatform> {
        get { Set(selectedPlatformIDs.compactMap(SocialPlatform.init(id:))) }
        set {
            selectedPlatformIDs = newValue
                .sorted { $0.sortIndex < $1.sortIndex }
                .map(\.id)
        }
    }

    var displayProjectName: String {
        guard let projectName else {
            return "your project"
        }

        let trimmedName = projectName.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedName.isEmpty ? "your project" : trimmedName
    }
}

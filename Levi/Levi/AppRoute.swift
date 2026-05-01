import Foundation
import SwiftData

@MainActor
enum AppRoute: Equatable {
    case onboarding
    case today

    static func preferredProfile(from profiles: [FounderProfile]) -> FounderProfile? {
        profiles.sorted(by: isHigherPriority).first
    }

    static func route(for profile: FounderProfile?) -> AppRoute {
        guard let profile else {
            return .onboarding
        }

        if profile.hasCompletedOnboarding && profile.onboardingStep == .complete {
            return .today
        }

        return .onboarding
    }

    private static func isHigherPriority(_ lhs: FounderProfile, _ rhs: FounderProfile) -> Bool {
        let lhsPriority = priorityKey(for: lhs)
        let rhsPriority = priorityKey(for: rhs)

        if lhsPriority != rhsPriority {
            return lhsPriority > rhsPriority
        }

        return String(describing: lhs.persistentModelID) < String(describing: rhs.persistentModelID)
    }

    private static func priorityKey(for profile: FounderProfile) -> (Int, Int, Date, String) {
        let completedFlag = profile.hasCompletedOnboarding ? 1 : 0
        let completedAt = profile.onboardingCompletedAt ?? .distantPast
        let normalizedName = profile.displayProjectName.lowercased()

        return (
            completedFlag,
            stepRank(profile.onboardingStep),
            completedAt,
            normalizedName
        )
    }

    private static func stepRank(_ step: OnboardingStep) -> Int {
        switch step {
        case .welcome:        0
        case .platformPicker: 1
        case .complete:       2
        }
    }
}

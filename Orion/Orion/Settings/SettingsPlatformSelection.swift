nonisolated enum SettingsPlatformSelectionResult: Equatable {
    case updated(Set<SocialPlatform>)
    case requiresPro
}

nonisolated enum SettingsPlatformSelection {
    static func toggled(
        _ platform: SocialPlatform,
        in selectedPlatforms: Set<SocialPlatform>,
        hasOrionPro: Bool
    ) -> SettingsPlatformSelectionResult {
        var updatedPlatforms = selectedPlatforms

        if updatedPlatforms.contains(platform) {
            guard updatedPlatforms.count > 1 else {
                return .updated(updatedPlatforms)
            }

            updatedPlatforms.remove(platform)
            return .updated(updatedPlatforms)
        }

        guard ProAccess.canSelect(platform, selectedPlatforms: updatedPlatforms, hasOrionPro: hasOrionPro) else {
            return .requiresPro
        }

        updatedPlatforms.insert(platform)
        return .updated(updatedPlatforms)
    }

    static func canSave(_ selectedPlatforms: Set<SocialPlatform>) -> Bool {
        !selectedPlatforms.isEmpty
    }
}

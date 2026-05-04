nonisolated enum SettingsPlatformSelection {
    static func toggled(
        _ platform: SocialPlatform,
        in selectedPlatforms: Set<SocialPlatform>
    ) -> Set<SocialPlatform> {
        var updatedPlatforms = selectedPlatforms

        if updatedPlatforms.contains(platform) {
            guard updatedPlatforms.count > 1 else {
                return updatedPlatforms
            }

            updatedPlatforms.remove(platform)
        } else {
            updatedPlatforms.insert(platform)
        }

        return updatedPlatforms
    }

    static func canSave(_ selectedPlatforms: Set<SocialPlatform>) -> Bool {
        !selectedPlatforms.isEmpty
    }
}

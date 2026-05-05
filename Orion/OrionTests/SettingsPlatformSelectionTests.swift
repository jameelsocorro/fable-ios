import Testing
@testable import Orion

struct SettingsPlatformSelectionTests {
    @Test
    func togglingUnselectedPlatformAddsItWhenWithinFreeLimit() {
        let selected: Set<SocialPlatform> = [.threads]
        let result = SettingsPlatformSelection.toggled(.instagram, in: selected, hasOrionPro: false)

        #expect(result == .updated([.threads, .instagram]))
    }

    @Test
    func togglingThirdPlatformRequiresProForFreeUsers() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]
        let result = SettingsPlatformSelection.toggled(.youtube, in: selected, hasOrionPro: false)

        #expect(result == .requiresPro)
    }

    @Test
    func togglingThirdPlatformAddsItForProUsers() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]
        let result = SettingsPlatformSelection.toggled(.youtube, in: selected, hasOrionPro: true)

        #expect(result == .updated([.threads, .instagram, .youtube]))
    }

    @Test
    func togglingSelectedPlatformRemovesItWhenMoreThanOneRemains() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]
        let result = SettingsPlatformSelection.toggled(.instagram, in: selected, hasOrionPro: false)

        #expect(result == .updated([.threads]))
    }

    @Test
    func togglingLastSelectedPlatformKeepsOneSelected() {
        let selected: Set<SocialPlatform> = [.threads]
        let result = SettingsPlatformSelection.toggled(.threads, in: selected, hasOrionPro: false)

        #expect(result == .updated([.threads]))
    }

    @Test
    func emptySelectionCannotSave() {
        #expect(!SettingsPlatformSelection.canSave([]))
        #expect(SettingsPlatformSelection.canSave([.threads]))
    }
}

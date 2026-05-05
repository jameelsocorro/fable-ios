import Testing
@testable import Orion

struct SettingsPlatformSelectionTests {
    @Test
    func togglingUnselectedPlatformAddsIt() {
        let selected: Set<SocialPlatform> = [.threads]
        let result = SettingsPlatformSelection.toggled(.instagram, in: selected)

        #expect(result == [.threads, .instagram])
    }

    @Test
    func togglingSelectedPlatformRemovesItWhenMoreThanOneRemains() {
        let selected: Set<SocialPlatform> = [.threads, .instagram]
        let result = SettingsPlatformSelection.toggled(.instagram, in: selected)

        #expect(result == [.threads])
    }

    @Test
    func togglingLastSelectedPlatformKeepsOneSelected() {
        let selected: Set<SocialPlatform> = [.threads]
        let result = SettingsPlatformSelection.toggled(.threads, in: selected)

        #expect(result == [.threads])
    }

    @Test
    func emptySelectionCannotSave() {
        #expect(!SettingsPlatformSelection.canSave([]))
        #expect(SettingsPlatformSelection.canSave([.threads]))
    }
}

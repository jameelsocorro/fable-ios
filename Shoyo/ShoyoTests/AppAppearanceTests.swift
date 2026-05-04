import SwiftUI
import Testing
@testable import Shoyo

struct AppAppearanceTests {
    @Test
    func storedValueFallsBackToSystem() {
        #expect(AppAppearance(storedValue: "unknown") == .system)
    }

    @Test
    func colorSchemeMappingMatchesSelection() {
        #expect(AppAppearance.system.colorScheme == nil)
        #expect(AppAppearance.light.colorScheme == .light)
        #expect(AppAppearance.dark.colorScheme == .dark)
    }

    @Test
    func displayNamesMatchSettingsRows() {
        #expect(AppAppearance.system.displayName == "System")
        #expect(AppAppearance.light.displayName == "Light")
        #expect(AppAppearance.dark.displayName == "Dark")
    }
}

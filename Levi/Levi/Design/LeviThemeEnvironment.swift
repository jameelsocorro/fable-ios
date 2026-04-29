import SwiftUI

private struct LeviThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: any LeviThemeToken = LeviAppTheme(selection: .system)
}

extension EnvironmentValues {
    var theme: any LeviThemeToken {
        get { self[LeviThemeEnvironmentKey.self] }
        set { self[LeviThemeEnvironmentKey.self] = newValue }
    }
}

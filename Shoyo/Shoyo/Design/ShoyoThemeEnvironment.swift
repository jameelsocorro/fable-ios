import SwiftUI

private struct ShoyoThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: any ShoyoThemeToken = ShoyoAppTheme(selection: .system)
}

extension EnvironmentValues {
    var theme: any ShoyoThemeToken {
        get { self[ShoyoThemeEnvironmentKey.self] }
        set { self[ShoyoThemeEnvironmentKey.self] = newValue }
    }
}

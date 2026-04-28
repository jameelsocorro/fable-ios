import SwiftUI

private struct FableThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: any FableThemeToken = FableAppTheme(selection: .system)
}

extension EnvironmentValues {
    var theme: any FableThemeToken {
        get { self[FableThemeEnvironmentKey.self] }
        set { self[FableThemeEnvironmentKey.self] = newValue }
    }
}

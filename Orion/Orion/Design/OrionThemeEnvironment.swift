import SwiftUI

private struct OrionThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: any OrionThemeToken = OrionAppTheme(selection: .system)
}

extension EnvironmentValues {
    var theme: any OrionThemeToken {
        get { self[OrionThemeEnvironmentKey.self] }
        set { self[OrionThemeEnvironmentKey.self] = newValue }
    }
}

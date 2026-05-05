import SwiftUI

struct OrionSecondaryButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.theme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(theme.colors.textSecondary)
            .frame(maxWidth: .infinity, minHeight: 48)
            .opacity(configuration.isPressed ? 0.68 : 1)
            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.85), value: configuration.isPressed)
    }
}

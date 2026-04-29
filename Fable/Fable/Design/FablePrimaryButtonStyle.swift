import SwiftUI

struct FablePrimaryButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.theme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(theme.colors.primaryForeground)
            .frame(maxWidth: .infinity, minHeight: 54)
            .padding(.horizontal, theme.spacing.lg)
            .background(backgroundColor(isPressed: configuration.isPressed), in: Capsule())
            .overlay {
                Capsule()
                    .stroke(theme.colors.primaryForeground.opacity(isEnabled ? 0.16 : 0.08), lineWidth: 1)
            }
            .scaleEffect(reduceMotion ? 1 : (configuration.isPressed ? 0.97 : 1))
            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.80), value: configuration.isPressed)
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        guard isEnabled else {
            return theme.colors.primary.opacity(0.34)
        }

        return theme.colors.primary.opacity(isPressed ? 0.88 : 1)
    }
}

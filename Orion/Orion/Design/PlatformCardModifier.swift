import SwiftUI

struct PlatformCardModifier: ViewModifier {
    @Environment(\.theme) private var theme
    let accentColor: Color
    let isSelected: Bool
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        content
            .background {
                shape.fill(isSelected ? accentColor.opacity(0.12) : theme.colors.surfacePrimary)
            }
            .overlay {
                shape.strokeBorder(
                    isSelected ? accentColor : theme.colors.border,
                    lineWidth: isSelected ? 1.5 : 1
                )
            }
    }
}

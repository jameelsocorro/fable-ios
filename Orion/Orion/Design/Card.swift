import SwiftUI

extension View {
    func card(cornerRadius: CGFloat = OrionRadius.sm) -> some View {
        modifier(CardModifier(cornerRadius: cornerRadius))
    }

    func platformCard(
        accentColor: Color,
        isSelected: Bool,
        cornerRadius: CGFloat = OrionRadius.sm
    ) -> some View {
        modifier(PlatformCardModifier(accentColor: accentColor, isSelected: isSelected, cornerRadius: cornerRadius))
    }
}

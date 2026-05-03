import SwiftUI

extension View {
    func card(cornerRadius: CGFloat = ShoyoRadius.sm) -> some View {
        modifier(CardModifier(cornerRadius: cornerRadius))
    }

    func platformCard(
        accentColor: Color,
        isSelected: Bool,
        cornerRadius: CGFloat = ShoyoRadius.sm
    ) -> some View {
        modifier(PlatformCardModifier(accentColor: accentColor, isSelected: isSelected, cornerRadius: cornerRadius))
    }
}

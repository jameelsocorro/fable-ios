import SwiftUI

extension View {
    func card(cornerRadius: CGFloat = LeviRadius.sm) -> some View {
        modifier(CardModifier(cornerRadius: cornerRadius))
    }

    func platformCard(
        accentColor: Color,
        isSelected: Bool,
        cornerRadius: CGFloat = LeviRadius.sm
    ) -> some View {
        modifier(PlatformCardModifier(accentColor: accentColor, isSelected: isSelected, cornerRadius: cornerRadius))
    }
}

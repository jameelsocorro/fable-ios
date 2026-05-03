import SwiftUI

struct CardModifier: ViewModifier {
    @Environment(\.theme) private var theme
    let cornerRadius: CGFloat

    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(theme.colors.surfacePrimary)
            }
    }
}

import SwiftUI

/// A decorative radial gradient overlay used as a page-level background accent.
/// Place inside a `ZStack` or as a `.background` layer. The gradient center position
/// is configurable so each screen can feel visually distinct.
struct PageGradientBackground: View {
    var center: UnitPoint = UnitPoint(x: 0.30, y: 0.65)
    var startRadius: CGFloat = 10
    var endRadius: CGFloat = 300

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        RadialGradient(
            colors: [
                theme.colors.primary.opacity(colorScheme == .dark ? 0.20 : 0.12),
                Color.clear
            ],
            center: center,
            startRadius: startRadius,
            endRadius: endRadius
        )
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

#Preview {
    ZStack {
        Color(.systemBackground).ignoresSafeArea()
        PageGradientBackground(center: UnitPoint(x: 0.30, y: 0.65))
    }
}

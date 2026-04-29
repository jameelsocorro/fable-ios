import SwiftUI

extension View {
    func glassCard(cornerRadius: CGFloat = FableRadius.sm) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius))
    }

    func glassPlatformCard(
        accentColor: Color,
        isSelected: Bool,
        cornerRadius: CGFloat = FableRadius.sm
    ) -> some View {
        modifier(GlassPlatformCardModifier(accentColor: accentColor, isSelected: isSelected, cornerRadius: cornerRadius))
    }
}

struct GlassCardModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    let cornerRadius: CGFloat

    private var backgroundFill: AnyShapeStyle {
        if reduceTransparency {
            AnyShapeStyle(Color(uiColor: UIColor.secondarySystemGroupedBackground))
        } else {
            AnyShapeStyle(.regularMaterial)
        }
    }

    private var gradientOverlay: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(colorScheme == .dark ? 0.08 : 0.55),
                Color.white.opacity(colorScheme == .dark ? 0.03 : 0.22)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var borderGradient: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(colorScheme == .dark ? 0.18 : 0.65),
                Color.white.opacity(colorScheme == .dark ? 0.04 : 0.18)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        return content
            .background {
                shape
                    .fill(backgroundFill)
                    .overlay { shape.fill(gradientOverlay) }
                    .overlay { shape.strokeBorder(borderGradient, lineWidth: 1) }
            }
            .shadow(
                color: Color.black.opacity(colorScheme == .dark ? 0.28 : 0.07),
                radius: 14,
                x: 0,
                y: 5
            )
    }
}

struct GlassPlatformCardModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    let accentColor: Color
    let isSelected: Bool
    let cornerRadius: CGFloat

    private var backgroundFill: AnyShapeStyle {
        if reduceTransparency {
            AnyShapeStyle(Color(uiColor: UIColor.secondarySystemGroupedBackground))
        } else {
            AnyShapeStyle(.regularMaterial)
        }
    }

    private var tintGradient: LinearGradient {
        let colors: [Color] = isSelected
            ? [accentColor.opacity(0.18), accentColor.opacity(0.06)]
            : [
                Color.white.opacity(colorScheme == .dark ? 0.07 : 0.50),
                Color.white.opacity(colorScheme == .dark ? 0.02 : 0.18)
            ]
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    private var borderGradient: LinearGradient {
        let colors: [Color] = isSelected
            ? [accentColor.opacity(0.70), accentColor.opacity(0.25)]
            : [
                Color.white.opacity(colorScheme == .dark ? 0.14 : 0.55),
                Color.white.opacity(colorScheme == .dark ? 0.04 : 0.15)
            ]
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    private var shadowColor: Color {
        isSelected
            ? accentColor.opacity(colorScheme == .dark ? 0.22 : 0.12)
            : Color.black.opacity(colorScheme == .dark ? 0.25 : 0.06)
    }

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

        return content
            .background {
                shape
                    .fill(backgroundFill)
                    .overlay { shape.fill(tintGradient) }
                    .overlay { shape.strokeBorder(borderGradient, lineWidth: isSelected ? 1.5 : 1) }
            }
            .shadow(
                color: shadowColor,
                radius: isSelected ? 16 : 10,
                x: 0,
                y: isSelected ? 6 : 3
            )
    }
}

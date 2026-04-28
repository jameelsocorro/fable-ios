import SwiftUI
import ColorTokensKit

struct FablePalette {
    let selection: FableTheme

    private var palette: ProColor {
        selection.palette
    }

    private var usesSystemColors: Bool {
        selection == .system
    }

    var foregroundPrimary: Color {
        usesSystemColors ? Color(uiColor: .label) : palette.fableForegroundPrimary
    }

    var foregroundSecondary: Color {
        usesSystemColors ? Color(uiColor: .secondaryLabel) : palette.fableForegroundSecondary
    }

    var foregroundTertiary: Color {
        usesSystemColors ? Color(uiColor: .tertiaryLabel) : palette.fableForegroundTertiary
    }

    var invertedForegroundPrimary: Color {
        usesSystemColors ? Color(uiColor: .systemBackground) : palette.fableInvertedForegroundPrimary
    }

    var invertedForegroundSecondary: Color {
        usesSystemColors ? Color(uiColor: .secondarySystemBackground) : palette.fableInvertedForegroundSecondary
    }

    var backgroundPrimary: Color {
        usesSystemColors ? Color(uiColor: .systemGroupedBackground) : palette.fableBackgroundPrimary
    }

    var backgroundSecondary: Color {
        usesSystemColors ? Color(uiColor: .secondarySystemGroupedBackground) : palette.fableBackgroundSecondary
    }

    var backgroundTertiary: Color {
        usesSystemColors ? Color(uiColor: .tertiarySystemGroupedBackground) : palette.fableBackgroundTertiary
    }

    var surfacePrimary: Color {
        usesSystemColors ? Color(uiColor: .secondarySystemGroupedBackground) : palette.fableSurfacePrimary
    }

    var surfaceSecondary: Color {
        usesSystemColors ? Color(uiColor: .tertiarySystemGroupedBackground) : palette.fableSurfaceSecondary
    }

    var surfaceTertiary: Color {
        usesSystemColors ? Color(uiColor: .systemFill) : palette.fableSurfaceTertiary
    }

    var outlinePrimary: Color {
        usesSystemColors ? Color(uiColor: .separator) : palette.fableOutlinePrimary
    }

    var outlineSecondary: Color {
        usesSystemColors ? Color(uiColor: .opaqueSeparator) : palette.fableOutlineSecondary
    }

    var outlineTertiary: Color {
        usesSystemColors ? Color(uiColor: .quaternaryLabel) : palette.fableOutlineTertiary
    }

    var actionPrimaryBackground: Color {
        palette.fableActionPrimaryBackground
    }

    var actionPrimaryForeground: Color {
        palette.fableActionPrimaryForeground
    }

    var actionSecondaryBackground: Color {
        usesSystemColors ? Color(uiColor: .secondarySystemFill) : palette.fableSurfaceSecondary
    }

    var actionSecondaryForeground: Color {
        foregroundSecondary
    }

    var warning: Color {
        Color.proGold.fableAccent
    }

    var primary: Color { actionPrimaryBackground }
    var primaryForeground: Color { actionPrimaryForeground }
    var secondaryBackground: Color { actionSecondaryBackground }
    var secondaryForeground: Color { actionSecondaryForeground }
    var background: Color { backgroundPrimary }
    var surface: Color { surfacePrimary }
    var surfaceOverlay: Color { surfaceTertiary }
    var surfaceRaised: Color { backgroundSecondary }
    var textPrimary: Color { foregroundPrimary }
    var textSecondary: Color { foregroundSecondary }
    var textTertiary: Color { foregroundTertiary }
    var textInverse: Color { invertedForegroundPrimary }
    var border: Color { outlinePrimary }
    var borderStrong: Color { outlineSecondary }
}

extension ProColor {
    var fableAccent: Color {
        Color(light: _600.toColor(), dark: _350.toColor())
    }

    var fableActionPrimaryBackground: Color {
        Color(light: _650.toColor(), dark: _300.toColor())
    }

    var fableActionPrimaryForeground: Color {
        Color(light: _50.toColor(), dark: _1000.toColor())
    }

    var fableForegroundPrimary: Color {
        Color(light: _1000.toColor(), dark: _50.toColor())
    }

    var fableForegroundSecondary: Color {
        Color(light: _800.toColor(), dark: _200.toColor())
    }

    var fableForegroundTertiary: Color {
        Color(light: _700.toColor(), dark: _300.toColor())
    }

    var fableInvertedForegroundPrimary: Color {
        Color(light: _50.toColor(), dark: _1000.toColor())
    }

    var fableInvertedForegroundSecondary: Color {
        Color(light: _150.toColor(), dark: _800.toColor())
    }

    var fableBackgroundPrimary: Color {
        Color(light: _50.toColor(), dark: _1000.toColor())
    }

    var fableBackgroundSecondary: Color {
        Color(light: _100.toColor(), dark: _850.toColor())
    }

    var fableBackgroundTertiary: Color {
        Color(light: _200.toColor(), dark: _750.toColor())
    }

    var fableSurfacePrimary: Color {
        Color(light: _200.toColor(), dark: _700.toColor()).opacity(0.48)
    }

    var fableSurfaceSecondary: Color {
        Color(light: _200.toColor(), dark: _700.toColor()).opacity(0.28)
    }

    var fableSurfaceTertiary: Color {
        Color(light: _300.toColor(), dark: _600.toColor()).opacity(0.16)
    }

    var fableOutlinePrimary: Color {
        Color(light: _300.toColor(), dark: _700.toColor())
    }

    var fableOutlineSecondary: Color {
        Color(light: _400.toColor(), dark: _600.toColor())
    }

    var fableOutlineTertiary: Color {
        Color(light: _200.toColor(), dark: _800.toColor())
    }
}

import SwiftUI

struct LeviPalette {
    let selection: LeviTheme

    var foregroundPrimary: Color {
        .primary
    }

    var foregroundSecondary: Color {
        .secondary
    }

    var foregroundTertiary: Color {
        Color(uiColor: .tertiaryLabel)
    }

    var invertedForegroundPrimary: Color {
        Color(uiColor: .systemBackground)
    }

    var invertedForegroundSecondary: Color {
        Color(uiColor: .secondarySystemBackground)
    }

    var backgroundPrimary: Color {
        Color(uiColor: .systemGroupedBackground)
    }

    var backgroundSecondary: Color {
        Color(uiColor: .secondarySystemGroupedBackground)
    }

    var backgroundTertiary: Color {
        Color(uiColor: .tertiarySystemGroupedBackground)
    }

    var surfacePrimary: Color {
        Color(uiColor: .secondarySystemGroupedBackground)
    }

    var surfaceSecondary: Color {
        Color(uiColor: .tertiarySystemGroupedBackground)
    }

    var surfaceTertiary: Color {
        Color(uiColor: .systemFill)
    }

    var outlinePrimary: Color {
        Color(uiColor: .separator)
    }

    var outlineSecondary: Color {
        Color(uiColor: .opaqueSeparator)
    }

    var outlineTertiary: Color {
        Color(uiColor: .quaternaryLabel)
    }

    var actionPrimaryBackground: Color {
        selection.accentColor
    }

    var actionPrimaryForeground: Color {
        .white
    }

    var actionSecondaryBackground: Color {
        Color(uiColor: .secondarySystemFill)
    }

    var actionSecondaryForeground: Color {
        foregroundSecondary
    }

    var warning: Color {
        .orange
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

import SwiftUI

struct LeviPalette {
    let selection: LeviTheme

    // MARK: - Foreground

    var foregroundPrimary: Color {
        .adaptive(light: "#1A1210", dark: "#FFFFFF")
    }

    var foregroundSecondary: Color {
        .adaptive(light: "#6B5244", dark: "#A09080")
    }

    var foregroundTertiary: Color {
        .adaptive(light: "#9B8B7E", dark: "#5C4E44")
    }

    var invertedForegroundPrimary: Color {
        .adaptive(light: "#FFFFFF", dark: "#1A1210")
    }

    var invertedForegroundSecondary: Color {
        .adaptive(light: "#F5EDE2", dark: "#252118")
    }

    // MARK: - Background

    var backgroundPrimary: Color {
        .adaptive(light: "#F9F4EE", dark: "#111110")
    }

    var backgroundSecondary: Color {
        .adaptive(light: "#F0E8DC", dark: "#1A1614")
    }

    var backgroundTertiary: Color {
        .adaptive(light: "#E8DDD0", dark: "#221E1B")
    }

    // MARK: - Surface

    var surfacePrimary: Color {
        .adaptive(light: "#FFFFFF", dark: "#1E1A17")
    }

    var surfaceSecondary: Color {
        .adaptive(light: "#F5EDE2", dark: "#252118")
    }

    var surfaceTertiary: Color {
        .adaptive(light: "#EDE2D4", dark: "#2C2620")
    }

    // MARK: - Outline

    var outlinePrimary: Color {
        .adaptive(light: "#E2D4C4", dark: "#302A24")
    }

    var outlineSecondary: Color {
        .adaptive(light: "#C8B5A4", dark: "#3D3530")
    }

    var outlineTertiary: Color {
        .adaptive(light: "#D4C4B4", dark: "#2A2420")
    }

    // MARK: - Actions

    var actionPrimaryBackground: Color {
        selection.accentColor
    }

    var actionPrimaryForeground: Color {
        .white
    }

    var actionSecondaryBackground: Color {
        .adaptive(light: "#EDE2D4", dark: "#2A2420")
    }

    var actionSecondaryForeground: Color {
        .adaptive(light: "#3D2A1E", dark: "#FFFFFF")
    }

    // MARK: - Semantic

    var warning: Color {
        .adaptive(light: "#D96010", dark: "#F07820")
    }

    // MARK: - Aliases

    var primary: Color           { actionPrimaryBackground }
    var primaryForeground: Color { actionPrimaryForeground }
    var secondaryBackground: Color { actionSecondaryBackground }
    var secondaryForeground: Color { actionSecondaryForeground }
    var background: Color        { backgroundPrimary }
    var surface: Color           { surfacePrimary }
    var surfaceOverlay: Color    { surfaceTertiary }
    var surfaceRaised: Color     { backgroundSecondary }
    var textPrimary: Color       { foregroundPrimary }
    var textSecondary: Color     { foregroundSecondary }
    var textTertiary: Color      { foregroundTertiary }
    var textInverse: Color       { invertedForegroundPrimary }
    var border: Color            { outlinePrimary }
    var borderStrong: Color      { outlineSecondary }
}

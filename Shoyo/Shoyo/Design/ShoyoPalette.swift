import SwiftUI

struct ShoyoPalette {
    let selection: ShoyoTheme

    // MARK: - Foreground

    var foregroundPrimary: Color {
        .adaptive(light: "#1C1C1E", dark: "#FFFFFF")
    }

    var foregroundSecondary: Color {
        .adaptive(light: "#6C6C70", dark: "#8E8E93")
    }

    var foregroundTertiary: Color {
        .adaptive(light: "#8E8E93", dark: "#636366")
    }

    var invertedForegroundPrimary: Color {
        .adaptive(light: "#FFFFFF", dark: "#1C1C1E")
    }

    var invertedForegroundSecondary: Color {
        .adaptive(light: "#F2F2F7", dark: "#111111")
    }

    // MARK: - Background

    var backgroundPrimary: Color {
        .adaptive(light: "#F2F2F7", dark: "#000000")
    }

    var backgroundSecondary: Color {
        .adaptive(light: "#EBEBF0", dark: "#1C1C1E")
    }

    var backgroundTertiary: Color {
        .adaptive(light: "#E5E5EA", dark: "#2C2C2E")
    }

    // MARK: - Surface

    var surfacePrimary: Color {
        .adaptive(light: "#FFFFFF", dark: "#1C1C1E")
    }

    var surfaceSecondary: Color {
        .adaptive(light: "#F2F2F7", dark: "#2C2C2E")
    }

    var surfaceTertiary: Color {
        .adaptive(light: "#E9E9EF", dark: "#3A3A3C")
    }

    // MARK: - Outline

    var outlinePrimary: Color {
        .adaptive(light: "#E5E5EA", dark: "#2C2C2E")
    }

    var outlineSecondary: Color {
        .adaptive(light: "#C7C7CC", dark: "#3A3A3C")
    }

    var outlineTertiary: Color {
        .adaptive(light: "#D1D1D6", dark: "#242426")
    }

    // MARK: - Actions

    var actionPrimaryBackground: Color {
        selection.accentColor
    }

    var actionPrimaryForeground: Color {
        .adaptive(light: "#FFFFFF", dark: "#000000")
    }

    var actionSecondaryBackground: Color {
        .adaptive(light: "#EBEBF0", dark: "#2C2C2E")
    }

    var actionSecondaryForeground: Color {
        .adaptive(light: "#1C1C1E", dark: "#FFFFFF")
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

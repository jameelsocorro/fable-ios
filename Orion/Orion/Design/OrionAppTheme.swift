struct OrionAppTheme: OrionThemeToken {
    let selection: OrionTheme
    let spacing = OrionSpacingTokens()

    var colors: OrionPalette {
        OrionPalette(selection: selection)
    }
}

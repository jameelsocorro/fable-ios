struct FableAppTheme: FableThemeToken {
    let selection: FableTheme
    let spacing = FableSpacingTokens()

    var colors: FablePalette {
        FablePalette(selection: selection)
    }
}

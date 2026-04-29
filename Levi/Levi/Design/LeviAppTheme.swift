struct LeviAppTheme: LeviThemeToken {
    let selection: LeviTheme
    let spacing = LeviSpacingTokens()

    var colors: LeviPalette {
        LeviPalette(selection: selection)
    }
}

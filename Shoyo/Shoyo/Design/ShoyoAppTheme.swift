struct ShoyoAppTheme: ShoyoThemeToken {
    let selection: ShoyoTheme
    let spacing = ShoyoSpacingTokens()

    var colors: ShoyoPalette {
        ShoyoPalette(selection: selection)
    }
}

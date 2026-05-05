import SwiftUI

struct TabPlaceholderView: View {
    let tab: AppTab
    let description: LocalizedStringKey

    @Environment(\.theme) private var theme

    var body: some View {
        ZStack {
            theme.colors.background
                .ignoresSafeArea()

            PageGradientBackground(center: UnitPoint(x: 0.70, y: 0.18))

            ContentUnavailableView(
                tab.title,
                systemImage: tab.symbolName,
                description: Text(description)
            )
            .foregroundStyle(theme.colors.textSecondary)
            .padding(.horizontal, theme.spacing.xl)
        }
    }
}

#Preview {
    TabPlaceholderView(
        tab: .streaks,
        description: "Your streak heatmap and history will live here."
    )
    .environment(\.theme, OrionAppTheme(selection: .system))
}

import SwiftUI

struct TodayFloatingTabBar: View {
    @Binding var selectedTab: TodayTab
    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: theme.spacing.sm) {
            ForEach(TodayTab.allCases) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: theme.spacing.xs) {
                        Image(systemName: tab.symbolName)
                            .font(.headline)
                            .accessibilityHidden(true)

                        Text(tab.title)
                            .font(.caption.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, theme.spacing.sm)
                    .foregroundStyle(selectedTab == tab ? theme.colors.textPrimary : theme.colors.textSecondary)
                    .background {
                        if selectedTab == tab {
                            Capsule()
                                .fill(theme.colors.surfaceOverlay)
                        }
                    }
                }
                .buttonStyle(.plain)
                .disabled(tab != .home)
                .accessibilityLabel(tab.title)
                .accessibilityValue(selectedTab == tab ? "Selected" : "")
                .accessibilityHint(tab == .home ? "" : "Coming soon")
            }
        }
        .padding(theme.spacing.xs)
        .background {
            Capsule()
                .fill(theme.colors.surface)
                .overlay {
                    Capsule()
                        .strokeBorder(theme.colors.border.opacity(0.75), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.14), radius: 18, x: 0, y: 8)
        }
        .padding(.horizontal, theme.spacing.xl)
    }
}

#Preview {
    TodayFloatingTabBar(selectedTab: .constant(.home))
        .padding()
        .environment(\.theme, LeviAppTheme(selection: .system))
}

import SwiftUI

struct OrionScreenTitle: View {
    let title: String
    let scrollOffset: CGFloat

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.theme) private var theme

    init(
        _ title: String,
        scrollOffset: CGFloat = 0
    ) {
        self.title = title
        self.scrollOffset = scrollOffset
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.system(.largeTitle, design: .serif, weight: .bold))
                .foregroundStyle(theme.colors.textPrimary)
                .scaleEffect(titleScale, anchor: .leading)
                .accessibilityAddTraits(.isHeader)

            Spacer()
        }
        .padding(.horizontal, theme.spacing.xl)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            theme.colors.background
                .ignoresSafeArea(edges: .top)
        }
        .animation(reduceMotion ? nil : .spring(response: 0.22, dampingFraction: 0.86), value: isCollapsed)
    }

    private var progress: CGFloat {
        min(max(scrollOffset / 56, 0), 1)
    }

    private var isCollapsed: Bool {
        progress > 0.5
    }

    private var titleScale: CGFloat {
        1 - (0.22 * progress)
    }

    private var topPadding: CGFloat {
        theme.spacing.lg - (theme.spacing.sm * progress)
    }

    private var bottomPadding: CGFloat {
        theme.spacing.sm - (theme.spacing.xs * progress)
    }
}

#Preview {
    VStack(spacing: 0) {
        OrionScreenTitle("Settings", scrollOffset: 0)
        OrionScreenTitle("Settings", scrollOffset: 56)
    }
    .environment(\.theme, OrionAppTheme(selection: .system))
}

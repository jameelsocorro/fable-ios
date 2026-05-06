import SwiftUI

struct NotificationHeroText: View {
    let contentVisible: Bool

    @Environment(\.theme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            Text("Never miss a day.")
                .font(.system(.largeTitle, design: .serif).weight(.bold))
                .foregroundStyle(theme.colors.textPrimary)
                .lineSpacing(2)

            Text("Get a nudge at 8 PM on days you haven't posted yet.")
                .font(.body)
                .foregroundStyle(theme.colors.textSecondary)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, theme.spacing.xl)
        .opacity(contentVisible ? 1 : 0)
        .offset(y: contentVisible ? 0 : 20)
    }
}

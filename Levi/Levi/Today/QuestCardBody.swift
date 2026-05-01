import SwiftUI

struct QuestCardBody: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let differentiateWithoutColor: Bool

    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing.xl) {
            Capsule()
                .fill(theme.colors.surfaceOverlay.opacity(0.8))
                .frame(width: 72, height: 44)
                .overlay {
                    Image(systemName: quest.platform.symbolName)
                        .font(.headline)
                        .foregroundStyle(theme.colors.textPrimary)
                }
                .accessibilityHidden(true)

            VStack(spacing: theme.spacing.md) {
                Text(quest.title)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .strikethrough(isCompleted, color: theme.colors.textPrimary)
                    .foregroundStyle(theme.colors.textPrimary)
                    .minimumScaleFactor(0.75)

                Text(quest.platform.displayName)
                    .font(.title3)
                    .foregroundStyle(theme.colors.textSecondary)
            }
            .padding(.horizontal, theme.spacing.xl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, theme.spacing.xxl)
        .overlay {
            if differentiateWithoutColor && isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56))
                    .foregroundStyle(theme.colors.textPrimary)
                    .accessibilityHidden(true)
            }
        }
    }
}

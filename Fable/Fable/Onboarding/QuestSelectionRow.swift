import SwiftUI

struct QuestSelectionRow: View {
    let quest: QuestDefinition
    let select: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        Button(action: select) {
            HStack(spacing: theme.spacing.md) {
                Image(systemName: quest.platform.symbolName)
                    .font(.title3)
                    .foregroundStyle(quest.platform.accentColor)
                    .frame(width: 44, height: 44)
                    .background(quest.platform.accentColor.opacity(0.12), in: Circle())
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: theme.spacing.xs) {
                    Text(quest.title)
                        .font(.headline)
                        .foregroundStyle(theme.colors.textPrimary)
                        .multilineTextAlignment(.leading)

                    Text(quest.platform.displayName)
                        .font(.subheadline)
                        .foregroundStyle(quest.platform.accentColor)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.callout.bold())
                    .foregroundStyle(theme.colors.textTertiary)
                    .accessibilityHidden(true)
            }
            .padding(theme.spacing.lg)
            .background(theme.colors.surfaceRaised, in: RoundedRectangle(cornerRadius: FableRadius.sm))
            .overlay {
                RoundedRectangle(cornerRadius: FableRadius.sm)
                    .stroke(theme.colors.border, lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(quest.title), \(quest.platform.displayName)")
    }
}

#Preview {
    QuestSelectionRow(quest: QuestCatalog.all[3], select: {})
        .padding()
        .background(FableAppTheme(selection: .system).colors.background)
}

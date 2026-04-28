import SwiftUI

struct HoldToCommitStepView: View {
    let quest: QuestDefinition
    let commitAction: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing.xl) {
            Spacer()

            VStack(spacing: theme.spacing.sm) {
                Text("Hold to start Day 1.")
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(theme.colors.textPrimary)

                Text("Commit to showing up today. Your streak starts here.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(theme.colors.textSecondary)
            }

            HStack(spacing: theme.spacing.md) {
                Image(systemName: quest.platform.symbolName)
                    .font(.body)
                    .foregroundStyle(quest.platform.accentColor)
                    .frame(width: 32, height: 32)
                    .background(quest.platform.accentColor.opacity(0.12), in: Circle())
                    .accessibilityHidden(true)

                Text(quest.title)
                    .font(.subheadline)
                    .foregroundStyle(theme.colors.textPrimary)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding(theme.spacing.md)
            .background(theme.colors.surfaceRaised, in: RoundedRectangle(cornerRadius: FableRadius.sm))
            .overlay {
                RoundedRectangle(cornerRadius: FableRadius.sm)
                    .stroke(quest.platform.accentColor.opacity(0.3), lineWidth: 1)
            }

            QuestHoldButton(quest: quest, completion: commitAction)

            Spacer()
        }
        .padding(theme.spacing.xl)
        .frame(maxWidth: .infinity)
        .background(theme.colors.background)
    }
}

#Preview {
    HoldToCommitStepView(quest: QuestCatalog.all[0], commitAction: {})
}

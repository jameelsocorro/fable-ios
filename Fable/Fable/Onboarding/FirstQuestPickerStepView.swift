import SwiftUI

struct FirstQuestPickerStepView: View {
    let quests: [QuestDefinition]
    let selectQuest: (QuestDefinition) -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                VStack(alignment: .leading, spacing: theme.spacing.sm) {
                    Text("Pick today's first quest.")
                        .font(.largeTitle.bold())
                        .foregroundStyle(theme.colors.textPrimary)

                    Text("You only need one to start Day 1.")
                        .font(.body)
                        .foregroundStyle(theme.colors.textSecondary)
                }

                VStack(spacing: theme.spacing.md) {
                    ForEach(quests) { quest in
                        QuestSelectionRow(quest: quest) {
                            selectQuest(quest)
                        }
                    }
                }
            }
            .padding(theme.spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(theme.colors.background)
    }
}

#Preview {
    FirstQuestPickerStepView(quests: QuestCatalog.firstSessionRecommendations(for: [.threads, .instagram, .youtube]), selectQuest: { _ in })
}

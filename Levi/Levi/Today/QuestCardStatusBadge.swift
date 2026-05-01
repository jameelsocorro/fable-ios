import SwiftUI

struct QuestCardStatusBadge: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let streakCount: Int

    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: theme.spacing.xs) {
            Image(systemName: quest.platform.symbolName)
                .font(.headline.bold())
                .accessibilityHidden(true)

            Text("\(max(streakCount, isCompleted ? 1 : 0))")
                .font(.headline.bold())
        }
        .foregroundStyle(isCompleted ? theme.colors.textInverse : theme.colors.textPrimary)
        .frame(width: 72, height: 72)
        .background {
            RoundedRectangle(cornerRadius: LeviRadius.md)
                .fill(isCompleted ? quest.platform.accentColor : theme.colors.surface)
                .shadow(color: quest.platform.accentColor.opacity(isCompleted ? 0.22 : 0.08), radius: 18, x: 0, y: 8)
        }
        .overlay {
            RoundedRectangle(cornerRadius: LeviRadius.md)
                .strokeBorder(theme.colors.border.opacity(isCompleted ? 0 : 0.5), lineWidth: 1)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Current streak \(max(streakCount, isCompleted ? 1 : 0))")
    }
}

import SwiftUI

struct TodayQuestRow: View {
    let quest: QuestDefinition
    let isCommitted: Bool
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: theme.spacing.md) {
            // Platform icon with concentric ring depth
            ZStack {
                Circle()
                    .fill(quest.platform.accentColor.opacity(0.06))
                    .frame(width: 52, height: 52)

                Circle()
                    .fill(quest.platform.accentColor.opacity(isCommitted ? 0.22 : 0.12))
                    .frame(width: 44, height: 44)
                    .animation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.75), value: isCommitted)

                Image(systemName: quest.platform.symbolName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(quest.platform.accentColor)
                    .scaleEffect(isCommitted ? 1.1 : 1.0)
                    .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.7), value: isCommitted)
            }
            .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(quest.title)
                    .font(.headline)
                    .foregroundStyle(theme.colors.textPrimary)

                Text(isCommitted ? "Done" : quest.platform.displayName)
                    .font(.subheadline)
                    .foregroundStyle(isCommitted ? quest.platform.accentColor : theme.colors.textSecondary)
                    .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8), value: isCommitted)
            }

            Spacer()

            if isCommitted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(quest.platform.accentColor)
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 0.5).combined(with: .opacity),
                            removal: .scale(scale: 0.5).combined(with: .opacity)
                        )
                    )
                    .accessibilityHidden(true)
            }
        }
        .padding(theme.spacing.lg)
        .glassPlatformCard(accentColor: quest.platform.accentColor, isSelected: isCommitted)
        .animation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.75), value: isCommitted)
        .accessibilityElement(children: .combine)
        .accessibilityValue(isCommitted ? "Completed" : "Tap and hold to complete")
    }
}

#Preview {
    VStack(spacing: 12) {
        TodayQuestRow(quest: QuestCatalog.all[0], isCommitted: false)
        TodayQuestRow(quest: QuestCatalog.all[0], isCommitted: true)
    }
    .padding()
    .background(LeviAppTheme(selection: .system).colors.background)
}

import SwiftUI

struct TodayQuestRow: View {
    let quest: QuestDefinition
    let isCommitted: Bool
    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: theme.spacing.md) {
            Image(systemName: committedIconName)
                .foregroundStyle(iconForeground)
                .frame(width: 44, height: 44)
                .background(iconBackground, in: Circle())
                .animation(.spring(duration: 0.3), value: isCommitted)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text(quest.title)
                    .font(.headline)
                    .foregroundStyle(theme.colors.textPrimary)

                Text(isCommitted ? "Done" : quest.platform.displayName)
                    .font(.subheadline)
                    .foregroundStyle(isCommitted ? theme.colors.primary : theme.colors.textSecondary)
            }

            Spacer()

            if isCommitted {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title3)
                    .foregroundStyle(theme.colors.primary)
                    .transition(.scale.combined(with: .opacity))
                    .accessibilityHidden(true)
            }
        }
        .padding(theme.spacing.lg)
        .background(rowBackground, in: RoundedRectangle(cornerRadius: FableRadius.sm))
        .overlay {
            RoundedRectangle(cornerRadius: FableRadius.sm)
                .stroke(isCommitted ? theme.colors.primary.opacity(0.25) : theme.colors.border, lineWidth: 1)
        }
        .animation(.spring(duration: 0.3), value: isCommitted)
        .accessibilityElement(children: .combine)
        .accessibilityValue(isCommitted ? "Completed" : "Tap and hold to complete")
    }

    // What SF Symbol should show in the icon circle once committed?
    // Option A: quest.platform.symbolName — keeps platform identity
    // Option B: "checkmark" — shows completion clearly
    // Option C: "checkmark.circle.fill" — strongest "done" signal
    private var committedIconName: String {
        quest.platform.symbolName
    }

    // What color should the icon be when committed?
    // Option A: quest.platform.accentColor — keeps brand color (current)
    // Option B: theme.colors.textInverse — white icon on solid circle
    // Option C: theme.colors.primary — uses app primary
    private var iconForeground: Color {
        quest.platform.accentColor
    }

    // What background color should the icon circle have when committed?
    // Option A: quest.platform.accentColor.opacity(0.12) — same as uncommitted
    // Option B: quest.platform.accentColor — solid fill, strong signal
    // Option C: theme.colors.primary.opacity(0.12) — use app primary color
    private var iconBackground: Color {
        quest.platform.accentColor.opacity(0.12)
    }

    private var rowBackground: Color {
        isCommitted ? theme.colors.primary.opacity(0.06) : theme.colors.surfaceRaised
    }
}

#Preview {
    VStack(spacing: 12) {
        TodayQuestRow(quest: QuestCatalog.all[0], isCommitted: false)
        TodayQuestRow(quest: QuestCatalog.all[0], isCommitted: true)
    }
    .padding()
    .background(FableAppTheme(selection: .system).colors.background)
}

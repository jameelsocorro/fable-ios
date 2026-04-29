import SwiftUI

struct QuestSelectionRow: View {
    let quest: QuestDefinition
    let select: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isPressed = false
    @State private var tapTick = 0

    var body: some View {
        Button(action: {
            tapTick += 1
            select()
        }) {
            HStack(spacing: theme.spacing.md) {
                // Platform icon with ring glow
                ZStack {
                    Circle()
                        .fill(quest.platform.accentColor.opacity(0.06))
                        .frame(width: 52, height: 52)

                    Circle()
                        .fill(quest.platform.accentColor.opacity(0.12))
                        .frame(width: 44, height: 44)

                    Image(systemName: quest.platform.symbolName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(quest.platform.accentColor)
                }
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

                // Chevron in a badge circle
                ZStack {
                    Circle()
                        .fill(theme.colors.textPrimary.opacity(0.06))
                        .frame(width: 28, height: 28)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(theme.colors.textTertiary)
                }
                .accessibilityHidden(true)
            }
            .padding(theme.spacing.lg)
            .glassPlatformCard(accentColor: quest.platform.accentColor, isSelected: false)
            .scaleEffect(isPressed ? 0.97 : 1)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .light), trigger: tapTick)
        .onLongPressGesture(minimumDuration: 0.01, perform: {}, onPressingChanged: { pressing in
            withAnimation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.85)) {
                isPressed = pressing
            }
        })
        .accessibilityLabel("\(quest.title), \(quest.platform.displayName)")
    }
}

#Preview {
    QuestSelectionRow(quest: QuestCatalog.all[3], select: {})
        .padding()
        .background(FableAppTheme(selection: .system).colors.background)
}

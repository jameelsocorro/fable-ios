import SwiftUI

struct HoldToCommitStepView: View {
    let quest: QuestDefinition
    let commitAction: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Atmospheric glow from quest platform color
            quest.platform.accentColor
                .opacity(colorScheme == .dark ? 0.08 : 0.06)
                .blur(radius: 90)
                .frame(width: 300, height: 300)
                .offset(x: 0, y: -60)
                .allowsHitTesting(false)

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
                        .lineSpacing(2)
                }
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 10)
                .animation(reduceMotion ? nil : .spring(response: 0.55, dampingFraction: 0.8), value: appeared)

                // Glass quest preview card
                HStack(spacing: theme.spacing.md) {
                    ZStack {
                        Circle()
                            .fill(quest.platform.accentColor.opacity(0.07))
                            .frame(width: 48, height: 48)

                        Circle()
                            .fill(quest.platform.accentColor.opacity(0.14))
                            .frame(width: 38, height: 38)

                        Image(systemName: quest.platform.symbolName)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(quest.platform.accentColor)
                    }
                    .accessibilityHidden(true)

                    Text(quest.title)
                        .font(.subheadline)
                        .foregroundStyle(theme.colors.textPrimary)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
                .padding(theme.spacing.md)
                .glassPlatformCard(accentColor: quest.platform.accentColor, isSelected: false, cornerRadius: LeviRadius.sm)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 12)
                .animation(reduceMotion ? nil : .spring(response: 0.55, dampingFraction: 0.8).delay(0.10), value: appeared)

                QuestHoldButton(quest: quest, completion: commitAction)
                    .opacity(appeared ? 1 : 0)
                    .scaleEffect(appeared ? 1 : 0.88)
                    .animation(reduceMotion ? nil : .spring(response: 0.60, dampingFraction: 0.72).delay(0.18), value: appeared)

                Spacer()
            }
            .padding(theme.spacing.xl)
            .frame(maxWidth: .infinity)
        }
        .background(theme.colors.background)
        .onAppear { appeared = true }
    }
}

#Preview {
    HoldToCommitStepView(quest: QuestCatalog.all[0], commitAction: {})
}

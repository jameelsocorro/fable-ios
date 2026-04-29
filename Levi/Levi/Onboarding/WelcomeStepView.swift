import SwiftUI

struct WelcomeStepView: View {
    let start: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Atmospheric glow in top corner
            theme.colors.primary.opacity(0.12)
                .blur(radius: 80)
                .frame(width: 320, height: 320)
                .offset(x: 80, y: -120)
                .allowsHitTesting(false)

            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                Spacer()

                // Flame hero: 4-ring glow stack
                ZStack {
                    Circle()
                        .fill(theme.colors.primary.opacity(0.05))
                        .frame(width: 160, height: 160)
                        .scaleEffect(appeared ? 1 : 0.7)

                    Circle()
                        .fill(theme.colors.primary.opacity(0.09))
                        .frame(width: 120, height: 120)
                        .scaleEffect(appeared ? 1 : 0.7)

                    Circle()
                        .fill(theme.colors.primary.opacity(0.14))
                        .frame(width: 88, height: 88)
                        .scaleEffect(appeared ? 1 : 0.7)

                    // Glass backing for icon
                    Circle()
                        .fill(.regularMaterial)
                        .overlay {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(colorScheme == .dark ? 0.14 : 0.65),
                                            Color.white.opacity(colorScheme == .dark ? 0.04 : 0.25)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        .overlay {
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(colorScheme == .dark ? 0.25 : 0.80),
                                            Color.white.opacity(colorScheme == .dark ? 0.06 : 0.25)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        }
                        .frame(width: 72, height: 72)
                        .shadow(
                            color: theme.colors.primary.opacity(0.20),
                            radius: 16,
                            x: 0,
                            y: 6
                        )
                        .scaleEffect(appeared ? 1 : 0.6)

                    Image(systemName: "flame.fill")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(theme.colors.primary)
                        .scaleEffect(appeared ? 1 : 0.5)
                        .accessibilityHidden(true)
                }
                .animation(reduceMotion ? nil : .spring(response: 0.6, dampingFraction: 0.72), value: appeared)

                VStack(alignment: .leading, spacing: theme.spacing.md) {
                    Text("Stop launching\nin silence.")
                        .font(.largeTitle.bold())
                        .foregroundStyle(theme.colors.textPrimary)
                        .lineSpacing(2)

                    Text("Pick where you want to show up. Levi gives you daily quests so your build becomes visible before launch.")
                        .font(.body)
                        .foregroundStyle(theme.colors.textSecondary)
                        .lineSpacing(2)
                }
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 12)
                .animation(reduceMotion ? nil : .spring(response: 0.6, dampingFraction: 0.8).delay(0.15), value: appeared)

                Spacer()

                Button("Start", action: start)
                    .buttonStyle(LeviPrimaryButtonStyle())
                    .accessibilityIdentifier("onboarding.start")
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)
                    .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.8).delay(0.25), value: appeared)
            }
            .padding(theme.spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(theme.colors.background)
        .onAppear { appeared = true }
    }
}

#Preview {
    WelcomeStepView(start: {})
}

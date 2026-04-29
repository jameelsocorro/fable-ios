import SwiftUI

struct DayOneCelebrationView: View {
    let viewToday: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false

    var body: some View {
        ZStack {
            // Celebration atmosphere — warm glow from top
            RadialGradient(
                colors: [theme.colors.primary.opacity(0.18), .clear],
                center: .init(x: 0.2, y: 0.0),
                startRadius: 0,
                endRadius: 400
            )
            .ignoresSafeArea()
            .allowsHitTesting(false)

            VStack(alignment: .leading, spacing: theme.spacing.xl) {
                Spacer()

                // Celebration flame icon with concentric glow rings
                ZStack {
                    Circle()
                        .fill(theme.colors.primary.opacity(0.04))
                        .frame(width: 200, height: 200)

                    Circle()
                        .fill(theme.colors.primary.opacity(0.07))
                        .frame(width: 152, height: 152)
                        .scaleEffect(appeared ? 1 : 0.7)

                    Circle()
                        .fill(theme.colors.primary.opacity(0.12))
                        .frame(width: 112, height: 112)
                        .scaleEffect(appeared ? 1 : 0.7)

                    // Glass icon housing
                    Circle()
                        .fill(.regularMaterial)
                        .overlay {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [
                                            Color.white.opacity(colorScheme == .dark ? 0.15 : 0.70),
                                            Color.white.opacity(colorScheme == .dark ? 0.05 : 0.28)
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
                                            Color.white.opacity(colorScheme == .dark ? 0.30 : 0.85),
                                            Color.white.opacity(colorScheme == .dark ? 0.06 : 0.28)
                                        ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1.5
                                )
                        }
                        .frame(width: 80, height: 80)
                        .shadow(
                            color: theme.colors.primary.opacity(0.28),
                            radius: 24,
                            x: 0,
                            y: 8
                        )
                        .scaleEffect(appeared ? 1 : 0.5)

                    Image(systemName: "flame.fill")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(theme.colors.primary)
                        .scaleEffect(appeared ? 1 : 0.4)
                        .symbolEffect(.bounce, options: .nonRepeating, value: appeared)
                        .accessibilityHidden(true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .animation(reduceMotion ? nil : .spring(response: 0.65, dampingFraction: 0.70), value: appeared)

                VStack(alignment: .leading, spacing: theme.spacing.md) {
                    Text("Day 1 started.")
                        .font(.largeTitle.bold())
                        .foregroundStyle(theme.colors.textPrimary)

                    Text("Come back tomorrow. Don't miss twice.")
                        .font(.body)
                        .foregroundStyle(theme.colors.textSecondary)
                        .lineSpacing(2)
                }
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 14)
                .animation(reduceMotion ? nil : .spring(response: 0.6, dampingFraction: 0.8).delay(0.18), value: appeared)

                Spacer()

                Button("View today", action: viewToday)
                    .buttonStyle(LeviPrimaryButtonStyle())
                    .accessibilityIdentifier("onboarding.viewToday")
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 16)
                    .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.8).delay(0.30), value: appeared)
            }
            .padding(theme.spacing.xl)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(theme.colors.background)
        .onAppear { appeared = true }
    }
}

#Preview {
    DayOneCelebrationView(viewToday: {})
}

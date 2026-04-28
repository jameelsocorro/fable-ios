import SwiftUI

struct WelcomeStepView: View {
    let start: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xl) {
            Spacer()

            ZStack {
                Circle()
                    .fill(theme.colors.primary.opacity(0.07))
                    .frame(width: 120, height: 120)
                Circle()
                    .fill(theme.colors.primary.opacity(0.12))
                    .frame(width: 88, height: 88)
                Image(systemName: "flame.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(theme.colors.primary)
                    .accessibilityHidden(true)
            }

            VStack(alignment: .leading, spacing: theme.spacing.md) {
                Text("Stop launching in silence.")
                    .font(.largeTitle.bold())
                    .foregroundStyle(theme.colors.textPrimary)

                Text("Pick where you want to show up. Fable gives you daily quests so your build becomes visible before launch.")
                    .font(.body)
                    .foregroundStyle(theme.colors.textSecondary)
            }

            Spacer()

            Button("Start", action: start)
                .buttonStyle(FablePrimaryButtonStyle())
                .accessibilityIdentifier("onboarding.start")
        }
        .padding(theme.spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.background)
    }
}

#Preview {
    WelcomeStepView(start: {})
}

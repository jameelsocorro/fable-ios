import SwiftUI

struct DayOneCelebrationView: View {
    let viewToday: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xl) {
            Spacer()

            ZStack {
                Circle()
                    .fill(theme.colors.primary.opacity(0.07))
                    .frame(width: 128, height: 128)
                Circle()
                    .fill(theme.colors.primary.opacity(0.12))
                    .frame(width: 96, height: 96)
                Image(systemName: "flame.fill")
                    .font(.system(size: 44))
                    .foregroundStyle(theme.colors.primary)
                    .accessibilityHidden(true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: theme.spacing.md) {
                Text("Day 1 started.")
                    .font(.largeTitle.bold())
                    .foregroundStyle(theme.colors.textPrimary)

                Text("Come back tomorrow. Don't miss twice.")
                    .font(.body)
                    .foregroundStyle(theme.colors.textSecondary)
            }

            Spacer()

            Button("View today", action: viewToday)
                .buttonStyle(FablePrimaryButtonStyle())
                .accessibilityIdentifier("onboarding.viewToday")
        }
        .padding(theme.spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.background)
    }
}

#Preview {
    DayOneCelebrationView(viewToday: {})
}

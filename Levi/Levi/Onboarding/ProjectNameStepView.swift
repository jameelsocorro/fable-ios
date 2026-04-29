import SwiftUI

struct ProjectNameStepView: View {
    @Binding var projectName: String
    let continueAction: () -> Void
    let skipAction: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xxl) {
            VStack(alignment: .leading, spacing: theme.spacing.md) {
                Text("What are you building?")
                    .font(.largeTitle.bold())
                    .foregroundStyle(theme.colors.textPrimary)

                Text("Used to make your quests feel personal.")
                    .font(.body)
                    .foregroundStyle(theme.colors.textSecondary)
            }

            TextField(text: $projectName, axis: .vertical) {
                Text("Levi, DevHabit, LaunchKit...")
                    .foregroundStyle(theme.colors.textSecondary)
            }
            .font(.body)
            .foregroundStyle(theme.colors.textPrimary)
            .textFieldStyle(.plain)
            .textInputAutocapitalization(.words)
            .submitLabel(.done)
            .lineLimit(1...2)
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.md)
            .frame(minHeight: 58, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: LeviRadius.sm, style: .continuous)
                    .fill(.thinMaterial)
                    .overlay {
                        RoundedRectangle(cornerRadius: LeviRadius.sm, style: .continuous)
                            .strokeBorder(theme.colors.border.opacity(0.6), lineWidth: 1)
                    }
            }
            .tint(theme.colors.primary)
            .accessibilityIdentifier("onboarding.projectName")

            Spacer()

            VStack(spacing: theme.spacing.sm) {
                Button("Continue", action: continueAction)
                    .buttonStyle(LeviPrimaryButtonStyle())

                Button("Skip for now", action: skipAction)
                    .buttonStyle(LeviSecondaryButtonStyle())
            }
            .frame(maxWidth: .infinity)
        }
        .padding(theme.spacing.xl)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.background)
    }
}

#Preview {
    ProjectNameStepView(projectName: .constant(""), continueAction: {}, skipAction: {})
}

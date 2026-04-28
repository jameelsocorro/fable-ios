import SwiftUI

struct PlatformSelectionCard: View {
    let platform: SocialPlatform
    let isSelected: Bool
    let toggle: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        Button(action: toggle) {
            VStack(alignment: .leading, spacing: theme.spacing.sm) {
                HStack(alignment: .top) {
                    Image(systemName: platform.symbolName)
                        .font(.title3)
                        .foregroundStyle(platform.accentColor)
                        .frame(width: 40, height: 40)
                        .background(platform.accentColor.opacity(0.14), in: Circle())

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundStyle(platform.accentColor)
                            .transition(.scale.combined(with: .opacity))
                    }
                }

                Text(platform.displayName)
                    .font(.subheadline.bold())
                    .foregroundStyle(theme.colors.textPrimary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, minHeight: 96, alignment: .leading)
            .padding(theme.spacing.lg)
            .background(cardBackground, in: RoundedRectangle(cornerRadius: FableRadius.sm))
            .overlay {
                RoundedRectangle(cornerRadius: FableRadius.sm)
                    .stroke(isSelected ? platform.accentColor : theme.colors.border, lineWidth: isSelected ? 2 : 1)
            }
            .animation(.spring(duration: 0.25), value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(platform.displayName)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
    }

    private var cardBackground: Color {
        isSelected ? platform.accentColor.opacity(0.10) : theme.colors.surfaceRaised
    }
}

#Preview {
    VStack {
        PlatformSelectionCard(platform: .threads, isSelected: false, toggle: {})
        PlatformSelectionCard(platform: .instagram, isSelected: true, toggle: {})
    }
    .padding()
    .background(FableAppTheme(selection: .system).colors.background)
}

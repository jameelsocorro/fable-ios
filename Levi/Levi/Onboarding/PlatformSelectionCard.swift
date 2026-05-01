import SwiftUI

struct PlatformSelectionCard: View {
    let platform: SocialPlatform
    let isSelected: Bool
    let toggle: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var isPressed = false
    @State private var tapTick = 0

    var body: some View {
        Button(action: {
            tapTick += 1
            toggle()
        }) {
            VStack(alignment: .leading, spacing: theme.spacing.sm) {
                HStack(alignment: .top) {
                    // Platform icon with concentric ring glow
                    ZStack {
                        Circle()
                            .fill(platform.accentColor.opacity(0.06))
                            .frame(width: 52, height: 52)

                        Circle()
                            .fill(platform.accentColor.opacity(isSelected ? 0.18 : 0.11))
                            .frame(width: 44, height: 44)
                            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.8), value: isSelected)

                        if let customImage = platform.customImageName {
                            Image(customImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .scaleEffect(isSelected ? 1.08 : 1.0)
                                .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.7), value: isSelected)
                        } else {
                            Image(systemName: platform.symbolName)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(platform.accentColor)
                                .scaleEffect(isSelected ? 1.08 : 1.0)
                                .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.7), value: isSelected)
                        }
                    }
                    .accessibilityHidden(true)

                    Spacer()

                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(platform.accentColor)
                            .transition(
                                .asymmetric(
                                    insertion: .scale(scale: 0.5).combined(with: .opacity),
                                    removal: .scale(scale: 0.5).combined(with: .opacity)
                                )
                            )
                    }
                }

                Text(platform.displayName)
                    .font(.subheadline.bold())
                    .foregroundStyle(theme.colors.textPrimary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
            .padding(theme.spacing.lg)
            .glassPlatformCard(accentColor: platform.accentColor, isSelected: isSelected)
            .scaleEffect(isPressed ? 0.97 : 1)
            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.75), value: isSelected)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .light), trigger: tapTick)
        .onLongPressGesture(minimumDuration: 0.01, perform: {}, onPressingChanged: { pressing in
            withAnimation(reduceMotion ? nil : .spring(response: 0.3, dampingFraction: 0.85)) {
                isPressed = pressing
            }
        })
        .accessibilityLabel(platform.displayName)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityValue(isSelected ? "Selected" : "Not selected")
    }
}

#Preview {
    VStack(spacing: 12) {
        PlatformSelectionCard(platform: .threads, isSelected: false, toggle: {})
        PlatformSelectionCard(platform: .instagram, isSelected: true, toggle: {})
    }
    .padding()
    .background(LeviAppTheme(selection: .system).colors.background)
}

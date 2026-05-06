import SwiftUI

struct PlatformSelectionTray: View {
    let orbPlatforms: [SocialPlatform]
    let selectedPlatforms: Set<SocialPlatform>
    let hasOrionPro: Bool
    let onDeselect: (SocialPlatform) -> Void

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private var selectedOrdered: [SocialPlatform] {
        orbPlatforms.filter { selectedPlatforms.contains($0) }
    }

    private var trayLabel: String {
        if hasOrionPro {
            switch selectedOrdered.count {
            case 0: return "Tap a platform above to choose"
            case 1: return "1 platform selected"
            default: return "\(selectedOrdered.count) platforms selected"
            }
        }

        switch selectedOrdered.count {
        case 0:
            return "Start focused with up to 2 platforms"
        case 1:
            return "1 platform selected · add one more"
        default:
            return "2 platforms selected · Pro unlocks every platform"
        }
    }

    var body: some View {
        VStack(spacing: theme.spacing.lg) {
            Text(trayLabel)
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .animation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.85), value: selectedOrdered.count)

            if selectedOrdered.isEmpty {
                HStack(spacing: theme.spacing.lg) {
                    ForEach(0..<2, id: \.self) { _ in
                        Circle()
                            .strokeBorder(
                                .secondary.opacity(0.20),
                                style: StrokeStyle(lineWidth: 1.5, dash: [5, 4])
                            )
                            .frame(width: 58, height: 58)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 74)
                .transition(.opacity)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: theme.spacing.lg) {
                        ForEach(selectedOrdered) { platform in
                            Button(action: { onDeselect(platform) }) {
                                PlatformOrb(platform: platform, size: 58)
                                    .overlay(alignment: .topTrailing) {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.subheadline.weight(.semibold))
                                            .foregroundStyle(.secondary)
                                            .offset(x: 5, y: -5)
                                    }
                                    .contentShape(Circle())
                            }
                            .buttonStyle(.plain)
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.2).combined(with: .opacity),
                                removal: .scale(scale: 0.2).combined(with: .opacity)
                            ))
                            .accessibilityLabel(platform.displayName)
                            .accessibilityHint("Tap to remove")
                            .accessibilityAddTraits(.isSelected)
                        }
                    }
                    .padding(.vertical, theme.spacing.xs)
                    .containerRelativeFrame(.horizontal, alignment: .center)
                }
                .scrollIndicators(.hidden)
                .frame(height: 74)
                .transition(.opacity)
            }
        }
        .padding(.horizontal, theme.spacing.lg)
        .padding(.vertical, theme.spacing.lg)
        .frame(maxWidth: .infinity)
        .background {
            let shape = RoundedRectangle(cornerRadius: 28, style: .continuous)
            shape
                .fill(reduceTransparency || colorScheme == .light
                      ? AnyShapeStyle(Color.white)
                      : AnyShapeStyle(.regularMaterial))
                .overlay {
                    shape.fill(LinearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.08 : 0.70),
                            .white.opacity(colorScheme == .dark ? 0.03 : 0.35)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                }
                .overlay {
                    shape.strokeBorder(
                        LinearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.18 : 0.80),
                                .white.opacity(colorScheme == .dark ? 0.04 : 0.30)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                }
        }
        .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.72), value: selectedPlatforms)
    }
}

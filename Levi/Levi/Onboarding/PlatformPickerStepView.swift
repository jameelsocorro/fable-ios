import SwiftUI

// MARK: - Shared orb visual

private struct PlatformOrb: View {
    let platform: SocialPlatform
    let size: CGFloat

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private var backgroundFill: AnyShapeStyle {
        reduceTransparency
            ? AnyShapeStyle(Color(.secondarySystemBackground))
            : AnyShapeStyle(.regularMaterial)
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundFill)
                .overlay {
                    Circle().strokeBorder(
                        LinearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.32 : 0.82),
                                .white.opacity(colorScheme == .dark ? 0.04 : 0.12)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1.5
                    )
                }

            if let customImage = platform.customImageName {
                Image(customImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.54, height: size * 0.54)
                    .accessibilityHidden(true)
            } else {
                Image(systemName: platform.symbolName)
                    .font(.system(size: size * 0.36, weight: .semibold))
                    .foregroundStyle(platform.accentColor)
                    .accessibilityHidden(true)
            }
        }
        .frame(width: size, height: size)
    }
}

// MARK: - Floating unselected orb (in hero zone)

private struct FloatingOrb: View {
    let platform: SocialPlatform
    let amplitude: CGFloat
    let appearDelay: Double
    let floatDuration: Double
    let action: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var visible = false
    @State private var floatY: CGFloat = 0

    var body: some View {
        Button(action: action) {
            PlatformOrb(platform: platform, size: 50)
        }
        .buttonStyle(FloatingOrbButtonStyle(isVisible: visible, reduceMotion: reduceMotion))
        .opacity(visible ? 1 : 0)
        .offset(y: floatY)
        .contentShape(Circle())
        .accessibilityLabel(platform.displayName)
        .accessibilityHint("Tap to select")
        .task {
            if appearDelay > 0 {
                try? await Task.sleep(for: .milliseconds(Int(appearDelay * 1_000)))
            }

            guard !Task.isCancelled else { return }

            withAnimation(reduceMotion ? .linear(duration: 0.15) : .spring(response: 0.55, dampingFraction: 0.68)) {
                visible = true
            }

            guard !reduceMotion else { return }

            withAnimation(.easeInOut(duration: floatDuration).repeatForever(autoreverses: true).delay(0.35)) {
                floatY = -amplitude
            }
        }
    }
}

private struct FloatingOrbButtonStyle: ButtonStyle {
    let isVisible: Bool
    let reduceMotion: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.88 : (isVisible ? 1 : 0.2))
            .animation(reduceMotion ? nil : .spring(response: 0.22, dampingFraction: 0.75), value: configuration.isPressed)
            .animation(reduceMotion ? nil : .spring(response: 0.55, dampingFraction: 0.68), value: isVisible)
    }
}

// MARK: - Platform picker step

struct PlatformPickerStepView: View {
    @Binding var selectedPlatforms: Set<SocialPlatform>
    let continueAction: () -> Void

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private let orbPlatforms: [SocialPlatform] = [
        .instagram, .threads, .x, .linkedin, .reddit,
        .youtube, .tiktok, .bluesky, .facebook
    ]

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            heroZone

            selectionTray
                .padding(.horizontal, theme.spacing.xl)
                .padding(.top, theme.spacing.lg)

            Spacer(minLength: 0)
        }
        .background {
            Color(.secondarySystemGroupedBackground)
                .ignoresSafeArea()
        }
        .safeAreaInset(edge: .bottom) {
            if !selectedPlatforms.isEmpty {
                Button("Continue", action: continueAction)
                    .buttonStyle(LeviPrimaryButtonStyle())
                    .padding(.horizontal, theme.spacing.xl)
                    .padding(.bottom, theme.spacing.lg)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.8), value: selectedPlatforms.isEmpty)
        .sensoryFeedback(.success, trigger: selectedPlatforms.count) { old, new in new > old }
        .sensoryFeedback(.impact(weight: .light), trigger: selectedPlatforms.count) { old, new in new < old }
    }

    // MARK: – Hero zone

    private var heroZone: some View {
        ZStack {
            CompanionBubbleView(
                imageName: "OreoCurious",
                message: "Where do you want to grow?",
                animateTyping: true,
                showSpeechBubble: false,
                floatDelay: 0.15,
                bubbleDelay: 0.35
            )

            ForEach(orbPlatforms) { platform in
                if !selectedPlatforms.contains(platform) {
                    let cfg = floatConfig(platform)
                    FloatingOrb(
                        platform: platform,
                        amplitude: cfg.amplitude,
                        appearDelay: cfg.delay,
                        floatDuration: cfg.duration,
                        action: { select(platform) }
                    )
                    .offset(orbOffset(platform))
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.3).combined(with: .opacity),
                        removal: .scale(scale: 1.25).combined(with: .opacity)
                    ))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.75), value: selectedPlatforms)
    }

    // MARK: – Selection tray (always-visible glass container)

    private var selectedOrdered: [SocialPlatform] {
        orbPlatforms.filter { selectedPlatforms.contains($0) }
    }

    private var trayLabel: String {
        switch selectedOrdered.count {
        case 0:      return "Tap a platform above to choose"
        case 1:      return "1 platform · tap more to add"
        case 2, 3:   return "\(selectedOrdered.count) platforms · looking good"
        default:     return "\(selectedOrdered.count) selected · 1–3 is easier to stay consistent"
        }
    }

    private var selectionTray: some View {
        VStack(spacing: 14) {
            Text(trayLabel)
                .font(.caption.weight(.medium))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .animation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.85), value: selectedOrdered.count)

            if selectedOrdered.isEmpty {
                HStack(spacing: 16) {
                    ForEach(0..<3, id: \.self) { _ in
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
                    HStack(spacing: 14) {
                        ForEach(selectedOrdered) { platform in
                            Button(action: { deselect(platform) }) {
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
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                }
                .scrollIndicators(.hidden)
                .frame(height: 74)
                .transition(.opacity)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 18)
        .frame(maxWidth: .infinity)
        .background {
            let shape = RoundedRectangle(cornerRadius: 28, style: .continuous)
            shape
                .fill(reduceTransparency
                      ? AnyShapeStyle(Color(.secondarySystemGroupedBackground))
                      : AnyShapeStyle(.regularMaterial))
                .overlay {
                    shape.fill(LinearGradient(
                        colors: [
                            .white.opacity(colorScheme == .dark ? 0.08 : 0.55),
                            .white.opacity(colorScheme == .dark ? 0.03 : 0.22)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                }
                .overlay {
                    shape.strokeBorder(
                        LinearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.18 : 0.60),
                                .white.opacity(colorScheme == .dark ? 0.04 : 0.14)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                }
        }
        .shadow(color: .black.opacity(colorScheme == .dark ? 0.24 : 0.10), radius: 18, x: 0, y: 7)
        .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.72), value: selectedPlatforms)
    }

    // MARK: – Helpers

    private func orbOffset(_ platform: SocialPlatform) -> CGSize {
        switch platform {
        case .threads:   CGSize(width:    0, height: -116)
        case .linkedin:  CGSize(width:  -80, height:  -96)
        case .x:         CGSize(width:   80, height:  -96)
        case .reddit:    CGSize(width: -145, height:  -48)
        case .youtube:   CGSize(width:  145, height:  -48)
        case .tiktok:    CGSize(width: -148, height:   16)
        case .bluesky:   CGSize(width:  148, height:   16)
        case .facebook:  CGSize(width:  112, height:   76)
        case .instagram: CGSize(width:  -40, height:  102)
        default:         .zero
        }
    }

    private func floatConfig(_ platform: SocialPlatform) -> (amplitude: CGFloat, delay: Double, duration: Double) {
        switch platform {
        case .instagram: (7,  0.40, 2.1)
        case .x:         (10, 0.50, 2.4)
        case .tiktok:    (8,  0.60, 1.9)
        case .youtube:   (9,  0.70, 2.7)
        case .linkedin:  (6,  0.45, 2.2)
        case .threads:   (8,  0.55, 2.5)
        case .bluesky:   (9,  0.75, 1.8)
        case .facebook:  (6,  0.80, 2.3)
        case .reddit:    (7,  0.65, 2.6)
        default:         (8,  0.50, 2.2)
        }
    }

    private func select(_ platform: SocialPlatform) {
        withAnimation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.72)) {
            _ = selectedPlatforms.insert(platform)
        }
    }

    private func deselect(_ platform: SocialPlatform) {
        withAnimation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.72)) {
            _ = selectedPlatforms.remove(platform)
        }
    }
}

#Preview {
    PlatformPickerStepView(selectedPlatforms: .constant([.instagram]), continueAction: {})
}

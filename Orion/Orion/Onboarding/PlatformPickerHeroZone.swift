import SwiftUI

struct PlatformPickerHeroZone: View {
    let orbPlatforms: [SocialPlatform]
    let selectedPlatforms: Set<SocialPlatform>
    let onSelect: (SocialPlatform) -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            CompanionBubbleView(
                imageName: "OreoCurious",
                message: "Where do you want to build audience?",
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
                        action: { onSelect(platform) }
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

    private func orbOffset(_ platform: SocialPlatform) -> CGSize {
        switch platform {
        case .instagram: CGSize(width: -108, height:   60)
        case .tiktok:    CGSize(width: -148, height:  -14)
        case .threads:   CGSize(width:    0, height: -146)
        case .youtube:   CGSize(width:  145, height:  -78)
        case .facebook:  CGSize(width:  112, height:   46)
        case .linkedin:  CGSize(width:  -80, height: -126)
        case .x:         CGSize(width:   80, height: -126)
        case .bluesky:   CGSize(width:  148, height:  -14)
        case .reddit:    CGSize(width: -145, height:  -78)
        }
    }

    private func floatConfig(_ platform: SocialPlatform) -> (amplitude: CGFloat, delay: Double, duration: Double) {
        switch platform {
        case .instagram: (7,  0.40, 2.1)
        case .tiktok:    (8,  0.60, 1.9)
        case .threads:   (8,  0.55, 2.5)
        case .youtube:   (9,  0.70, 2.7)
        case .facebook:  (6,  0.80, 2.3)
        case .linkedin:  (6,  0.45, 2.2)
        case .x:         (10, 0.50, 2.4)
        case .bluesky:   (9,  0.75, 1.8)
        case .reddit:    (7,  0.65, 2.6)
        }
    }
}

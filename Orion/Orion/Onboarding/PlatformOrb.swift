import SwiftUI

struct PlatformOrb: View {
    let platform: SocialPlatform
    let size: CGFloat

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    private var backgroundFill: AnyShapeStyle {
        if reduceTransparency || colorScheme == .light {
            return AnyShapeStyle(Color.white)
        }
        return AnyShapeStyle(.regularMaterial)
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundFill)
                .overlay {
                    Circle().strokeBorder(
                        LinearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.32 : 0.90),
                                .white.opacity(colorScheme == .dark ? 0.04 : 0.30)
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
                    .foregroundStyle(platform.accentFillStyle)
                    .accessibilityHidden(true)
            }
        }
        .frame(width: size, height: size)
    }
}

import SwiftUI

struct TodayQuestFillBackground: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let fillProgress: CGFloat

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var bloomOpacity: CGFloat = 0

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: LeviRadius.lg)

        shape
            .fill(baseFill)
            .overlay(alignment: .leading) {
                fillLayer(shape: shape)
            }
            // Completion bloom — brief white flash that celebrates the fill landing
            .overlay {
                shape
                    .fill(Color.white.opacity(bloomOpacity))
                    .allowsHitTesting(false)
                    .accessibilityHidden(true)
            }
            // Border fades out as fill advances so it never fights the color
            .overlay {
                shape.strokeBorder(borderStyle, lineWidth: 1)
                    .opacity(max(0, 1 - fillProgress * 1.5))
            }
            .shadow(
                color: shadowColor,
                radius: isCompleted ? 10 : 6,
                x: 0,
                y: isCompleted ? 5 : 3
            )
            .onChange(of: isCompleted) { _, newValue in
                guard newValue, !reduceMotion else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.40) {
                    triggerCompletionBloom()
                }
            }
    }

    @ViewBuilder
    private func fillLayer(shape: RoundedRectangle) -> some View {
        ZStack(alignment: .trailing) {
            // Base fill — rich center, tapers toward edges like a liquid body
            LinearGradient(
                stops: [
                    .init(color: quest.platform.accentColor.opacity(0.65), location: 0),
                    .init(color: quest.platform.accentColor, location: 0.55),
                    .init(color: quest.platform.accentColor.opacity(0.88), location: 1)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )

            // Top-lit glass specular — simulates overhead light hitting a curved surface
            if !reduceTransparency {
                LinearGradient(
                    stops: [
                        .init(color: Color.white.opacity(0.28), location: 0),
                        .init(color: Color.white.opacity(0.06), location: 0.45),
                        .init(color: Color.white.opacity(0), location: 0.72)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }

            // Wave front — bright meniscus at the leading edge while actively filling
            if fillProgress > 0, fillProgress < 1, !reduceMotion {
                LinearGradient(
                    stops: [
                        .init(color: Color.white.opacity(0), location: 0),
                        .init(color: Color.white.opacity(0.42), location: 0.65),
                        .init(color: Color.white.opacity(0.62), location: 1)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(width: 44)
            }
        }
        .containerRelativeFrame(.horizontal) { length, _ in length * fillProgress }
        .frame(maxHeight: .infinity)
        .opacity(isCompleted || fillProgress > 0 ? 1 : 0)
        .clipShape(shape)
    }

    // Quick flash-in, slow decay — like a spark landing then cooling
    private func triggerCompletionBloom() {
        withAnimation(.easeIn(duration: 0.07)) {
            bloomOpacity = 0.30
        } completion: {
            withAnimation(.easeOut(duration: 0.55)) {
                bloomOpacity = 0
            }
        }
    }

    private var baseFill: AnyShapeStyle {
        if colorScheme == .light || reduceTransparency {
            AnyShapeStyle(Color.white)
        } else {
            AnyShapeStyle(.regularMaterial)
        }
    }

    private var borderStyle: LinearGradient {
        LinearGradient(
            colors: [
                Color.white.opacity(colorScheme == .dark ? 0.16 : 0.78),
                Color.white.opacity(colorScheme == .dark ? 0.04 : 0.24)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var shadowColor: Color {
        if isCompleted {
            quest.platform.accentColor.opacity(colorScheme == .dark ? 0.28 : 0.20)
        } else {
            Color.black.opacity(colorScheme == .dark ? 0.26 : 0.08)
        }
    }
}

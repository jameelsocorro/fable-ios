import SwiftUI

struct TodayQuestFillBackground: View {
    let quest: QuestDefinition
    let isCompleted: Bool
    let fillProgress: CGFloat

    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: LeviRadius.lg)

        shape
            .fill(baseFill)
            .overlay(alignment: .leading) {
                LinearGradient(
                    colors: [
                        quest.platform.accentColor.opacity(0.72),
                        quest.platform.accentColor
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .containerRelativeFrame(.horizontal) { length, _ in length * fillProgress }
                .frame(maxHeight: .infinity)
                .opacity(isCompleted || fillProgress > 0 ? 1 : 0)
                .clipShape(shape)
            }
            .overlay {
                shape.strokeBorder(borderStyle, lineWidth: isCompleted ? 0 : 1)
            }
            .shadow(
                color: shadowColor,
                radius: isCompleted ? 8 : 6,
                x: 0,
                y: isCompleted ? 4 : 3
            )
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
            quest.platform.accentColor.opacity(colorScheme == .dark ? 0.24 : 0.16)
        } else {
            Color.black.opacity(colorScheme == .dark ? 0.26 : 0.08)
        }
    }
}

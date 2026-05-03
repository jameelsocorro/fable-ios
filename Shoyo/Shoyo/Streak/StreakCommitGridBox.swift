import SwiftUI

struct StreakCommitGridBox: View {
    static let defaultSize: CGFloat = 10
    static let defaultSpacing: CGFloat = 3

    let intensity: Int
    var size: CGFloat = Self.defaultSize
    var activeFillStyle: AnyShapeStyle?

    @Environment(\.theme) private var theme

    var body: some View {
        RoundedRectangle(cornerRadius: Self.cornerRadius)
            .fill(fillStyle)
            .frame(width: size, height: size)
    }

    private var fillStyle: AnyShapeStyle {
        guard normalizedIntensity > 0 else {
            return AnyShapeStyle(theme.colors.surfaceTertiary)
        }

        return activeFillStyle ?? AnyShapeStyle(theme.colors.primary.opacity(opacity))
    }

    private var normalizedIntensity: Int {
        min(max(intensity, 0), Self.maximumIntensity)
    }

    private var opacity: Double {
        switch normalizedIntensity {
        case 1:
            return 0.3
        case 2:
            return 0.6
        default:
            return 1.0
        }
    }

    private static let cornerRadius: CGFloat = 2
    private static let maximumIntensity = 3
}

#Preview {
    HStack(spacing: StreakCommitGridBox.defaultSpacing) {
        ForEach(0..<4, id: \.self) { intensity in
            StreakCommitGridBox(intensity: intensity)
        }
    }
    .padding()
    .environment(\.theme, ShoyoAppTheme(selection: .system))
}

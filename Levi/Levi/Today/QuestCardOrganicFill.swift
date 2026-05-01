import SwiftUI

struct QuestCardOrganicFill: View {
    let progress: CGFloat
    let origin: CGPoint?
    let color: Color
    let reduceMotion: Bool

    var body: some View {
        Canvas { context, size in
            guard progress > 0 else { return }

            let fillOrigin = origin ?? CGPoint(x: size.width / 2, y: size.height / 2)
            let maxDimension = max(size.width, size.height)
            let diameter = maxDimension * 2.4 * max(progress, 0.001)
            let rect = CGRect(
                x: fillOrigin.x - diameter / 2,
                y: fillOrigin.y - diameter / 2,
                width: diameter,
                height: diameter
            )

            context.fill(
                Path(ellipseIn: rect),
                with: .linearGradient(
                    Gradient(colors: [color.opacity(0.82), color]),
                    startPoint: CGPoint(x: rect.minX, y: rect.minY),
                    endPoint: CGPoint(x: rect.maxX, y: rect.maxY)
                )
            )
        }
        .blur(radius: reduceMotion ? 0 : 10)
        .opacity(progress > 0 ? 1 : 0)
        .allowsHitTesting(false)
    }
}

#Preview {
    RoundedRectangle(cornerRadius: LeviRadius.xl)
        .fill(.white)
        .overlay {
            QuestCardOrganicFill(
                progress: 0.55,
                origin: CGPoint(x: 160, y: 110),
                color: .pink,
                reduceMotion: false
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: LeviRadius.xl))
        .frame(height: 260)
        .padding()
        .background(.black.opacity(0.08))
}

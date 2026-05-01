import SwiftUI

struct CelebrationDottedBackdrop: View {
    let accentColor: Color

    var body: some View {
        Canvas { context, size in
            let spacing: CGFloat = 18
            let radius: CGFloat = 2.4

            for x in stride(from: spacing, through: size.width, by: spacing) {
                for y in stride(from: spacing, through: size.height, by: spacing) {
                    let rect = CGRect(x: x, y: y, width: radius * 2, height: radius * 2)
                    context.fill(
                        Path(ellipseIn: rect),
                        with: .color(accentColor.opacity(0.12))
                    )
                }
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
}

import SwiftUI

struct FloatingOrb: View {
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

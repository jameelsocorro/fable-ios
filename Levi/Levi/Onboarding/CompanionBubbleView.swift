import SwiftUI

struct CompanionBubbleView: View {
    let imageName: String
    let message: String
    var animateTyping: Bool = false
    var showSpeechBubble: Bool = true
    var floatDelay: Double = 0.1
    var bubbleDelay: Double = 0.3
    var accessibilityDescription: String = "Oreo, your quest companion"

    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var floatOffset: CGFloat = 0
    @State private var bubbleFloatOffset: CGFloat = 0
    @State private var bubbleVisible = false
    @State private var typedText = ""
    @State private var typingDone = false

    private var displayText: String {
        animateTyping ? typedText + (typingDone ? "" : "▌") : message
    }

    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 230)
                .accessibilityLabel(accessibilityDescription)
                .accessibilityHidden(true)

            if showSpeechBubble {
                Image("ChatBubble")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 100)
                    .opacity(bubbleVisible ? 1 : 0)
                    .offset(x: 55, y: -60)
                    .offset(y: bubbleFloatOffset + (bubbleVisible ? 0 : 12))
                    .accessibilityHidden(true)
            }

            VStack(spacing: 0) {
                Spacer()
                Text(displayText)
                    .font(.subheadline)
                    .foregroundStyle(theme.colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, theme.spacing.lg)
                    .padding(.vertical, theme.spacing.md)
                    .glassCard(cornerRadius: LeviRadius.md)
                    .opacity(bubbleVisible ? 1 : 0)
                    .offset(y: bubbleVisible ? 0 : 12)
            }
            .padding(.horizontal, theme.spacing.lg)
            .offset(y: -5)
        }
        .frame(width: 320, height: 280)
        .offset(y: floatOffset)
        .onAppear { beginAnimation() }
    }

    private func beginAnimation() {
        guard !reduceMotion else {
            bubbleVisible = true
            typedText = message
            typingDone = true
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + floatDelay) {
            withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                floatOffset = -10
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + bubbleDelay) {
            withAnimation(.spring(response: 0.44, dampingFraction: 0.76)) {
                bubbleVisible = true
            }
            withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                bubbleFloatOffset = -8
            }
            if animateTyping {
                startTyping(after: 0.14)
            }
        }
    }

    private func startTyping(after delay: Double) {
        var index = 0
        let chars = Array(message)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            Timer.scheduledTimer(withTimeInterval: 0.042, repeats: true) { timer in
                guard index < chars.count else {
                    timer.invalidate()
                    typingDone = true
                    return
                }
                typedText.append(chars[index])
                index += 1
            }
        }
    }
}

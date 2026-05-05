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
    @State private var bubbleVisible = false
    @State private var typedText = ""
    @State private var typingStarted = false
    @State private var typingDone = false

    private var displayText: String {
        animateTyping ? typedText + (typingDone ? "" : "▌") : message
    }

    var body: some View {
        VStack(spacing: 6) {
            // Dog + optional comic speech bubble — same ZStack so ChatBubble floats with dog
            ZStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 210)
                    .accessibilityLabel(accessibilityDescription)
                    .accessibilityHidden(true)

                if showSpeechBubble {
                    Image("ChatBubble")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 100)
                        .opacity(bubbleVisible ? 1 : 0)
                        .offset(x: 55, y: bubbleVisible ? -60 : -48)
                        .animation(.spring(response: 0.44, dampingFraction: 0.76), value: bubbleVisible)
                        .accessibilityHidden(true)
                }
            }

            // Text card in VStack so it physically follows the dog when floatOffset changes
            if !animateTyping || typingStarted {
                Text(displayText)
                    .font(.system(.subheadline, design: .monospaced))
                    .foregroundStyle(theme.colors.textPrimary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, theme.spacing.lg)
                    .padding(.vertical, theme.spacing.md)
                    .glassCard(cornerRadius: OrionRadius.md)
                    .padding(.horizontal, theme.spacing.lg)
                    .transition(.opacity.combined(with: .offset(y: 8)))
            }
        }
        .frame(width: 320)
        .offset(y: floatOffset)
        // Float — independent task, cancelled when view disappears
        .task {
            guard !reduceMotion else { return }
            try? await Task.sleep(for: .seconds(floatDelay))
            guard !Task.isCancelled else { return }
            withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                floatOffset = -10
            }
        }
        // Bubble reveal + typing — independent task, cancelled when view disappears
        .task {
            guard !reduceMotion else {
                bubbleVisible = true
                if animateTyping {
                    typedText = message
                    typingStarted = true
                    typingDone = true
                }
                return
            }

            try? await Task.sleep(for: .seconds(bubbleDelay))
            guard !Task.isCancelled else { return }

            // Set directly — ChatBubble picks this up via .animation(value: bubbleVisible)
            bubbleVisible = true

            guard animateTyping else { return }

            try? await Task.sleep(for: .milliseconds(250))
            guard !Task.isCancelled else { return }

            // withAnimation triggers the .transition on the text card
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                typingStarted = true
            }

            for char in message {
                guard !Task.isCancelled else { return }
                typedText.append(char)
                try? await Task.sleep(for: .milliseconds(42))
            }
            typingDone = true
        }
    }
}

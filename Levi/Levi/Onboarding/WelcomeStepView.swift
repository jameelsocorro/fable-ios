import SwiftUI

struct WelcomeStepView: View {
    let start: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var heroPhase = false
    @State private var bubbleVisible = false
    @State private var contentVisible = false
    @State private var floatOffset: CGFloat = 0
    @State private var bubbleFloatOffset: CGFloat = 0
    @State private var typedText = ""
    @State private var typingDone = false

    private let companionText = "I'll be your companion on \nyour journey!"
    private let oreoCompositionWidth: CGFloat = 320

    private let launchScale: CGFloat = 1.25
    private let launchOffsetY: CGFloat = 130

    var body: some View {
        ZStack {
            theme.colors.background.ignoresSafeArea()

            RadialGradient(
                colors: [
                    theme.colors.primary.opacity(colorScheme == .dark ? 0.20 : 0.12),
                    Color.clear
                ],
                center: UnitPoint(x: 0.30, y: 0.65),
                startRadius: 10,
                endRadius: 300
            )
            .ignoresSafeArea()
            .allowsHitTesting(false)

            VStack(spacing: 0) {
                Spacer()

                companionStage

                Spacer().frame(height: 40)

                heroText

                Spacer()

                startButton

                Spacer().frame(height: theme.spacing.xl)
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear { beginSequence() }
    }

    // MARK: – Companion stage

    private var companionStage: some View {
        oreoComposition
            .scaleEffect(heroPhase ? 1.0 : launchScale, anchor: .center)
            .offset(y: heroPhase ? floatOffset : launchOffsetY)
            .frame(maxWidth: .infinity)
    }

    // Oreo + speech bubble + glass text pill, all composed in one unit
    private var oreoComposition: some View {
        ZStack {
            oreoImage

            speechBubble
                .opacity(bubbleVisible ? 1 : 0)
                .offset(x: 55, y: -60)
                .offset(y: bubbleFloatOffset + (bubbleVisible ? 0 : 12))

            // Glass text overlays the body of Oreo
            VStack(spacing: 0) {
                Spacer()
                glassTextContainer
                    .opacity(bubbleVisible ? 1 : 0)
                    .offset(y: bubbleVisible ? 0 : 12)
            }
            .padding(.horizontal, theme.spacing.lg)
            .offset(y: -5)
        }
        .frame(width: oreoCompositionWidth, height: 280)
    }

    private var oreoImage: some View {
        Image("OreoWaving")
            .resizable()
            .scaledToFit()
            .frame(height: 230)
            .accessibilityLabel("Oreo, your quest companion")
    }

    // MARK: – Speech bubble

    private var speechBubble: some View {
        Image("ChatBubble")
            .resizable()
            .scaledToFit()
            .frame(width: 170, height: 100)
    }

    // MARK: – Glass text container

    private var glassTextContainer: some View {
        Text(typedText + (typingDone ? "" : "▌"))
            .font(.subheadline)
            .foregroundStyle(theme.colors.textPrimary)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.md)
            .glassCard(cornerRadius: LeviRadius.md)
    }

    // MARK: – Hero text

    private var heroText: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            Text("Stop launching\nin silence.")
                .font(.system(.largeTitle, design: .serif).weight(.bold))
                .foregroundStyle(theme.colors.textPrimary)
                .lineSpacing(2)

            Text("Build in public before you launch, \none daily quest at a time.")
                .font(.body)
                .foregroundStyle(theme.colors.textSecondary)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, theme.spacing.xl)
        .opacity(contentVisible ? 1 : 0)
        .offset(y: contentVisible ? 0 : 20)
    }

    // MARK: – Start button

    private var startButton: some View {
        Button("Start", action: start)
            .buttonStyle(LeviPrimaryButtonStyle())
            .padding(.horizontal, theme.spacing.xl)
            .accessibilityIdentifier("onboarding.start")
            .opacity(contentVisible ? 1 : 0)
            .offset(y: contentVisible ? 0 : 16)
    }

    // MARK: – Sequence

    private func beginSequence() {
        guard !reduceMotion else {
            heroPhase = true
            bubbleVisible = true
            contentVisible = true
            typedText = companionText
            typingDone = true
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {

            withAnimation(.spring(response: 0.52, dampingFraction: 0.82)) {
                heroPhase = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                    floatOffset = -10
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.80) {
                withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                    bubbleFloatOffset = -8
                }
            }

            withAnimation(.spring(response: 0.44, dampingFraction: 0.76).delay(0.32)) {
                bubbleVisible = true
            }
            startTyping(after: 0.46)

            withAnimation(.spring(response: 0.60, dampingFraction: 0.82).delay(0.54)) {
                contentVisible = true
            }
        }
    }

    private func startTyping(after delay: Double) {
        var index = 0
        let chars = Array(companionText)
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

#Preview {
    WelcomeStepView(start: {})
}

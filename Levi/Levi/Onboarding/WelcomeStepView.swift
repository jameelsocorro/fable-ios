import SwiftUI

struct WelcomeStepView: View {
    let start: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // hero transition: false = launch-screen state, true = settled
    @State private var heroPhase = false
    @State private var bubbleVisible = false
    @State private var contentVisible = false
    @State private var floatOffset: CGFloat = 0
    @State private var bubbleFloatOffset: CGFloat = 0
    @State private var typedText = ""
    @State private var typingDone = false

    private let companionText = "I'll keep you on your quests. 🐾"

    // Launch screen has Oreo at 200pt; welcome screen renders it at 160pt → scale 1.25.
    // Y offset places Oreo at the same screen position as the launch screen centerY+40.
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
        VStack(alignment: .leading, spacing: 20) {
            oreoComposition
                .scaleEffect(heroPhase ? 1.0 : launchScale, anchor: .center)
                .offset(y: heroPhase ? floatOffset : launchOffsetY)

            glassTextContainer
                .opacity(bubbleVisible ? 1 : 0)
                .offset(y: bubbleVisible ? 0 : 12)
        }
        .padding(.leading, theme.spacing.xl)
    }

    // Oreo + speech bubble composed together, bubble upper-right of dog
    private var oreoComposition: some View {
        ZStack {
            oreoImage
                .offset(x: -10, y: 30)

            speechBubble
                .opacity(bubbleVisible ? 1 : 0)
                .offset(x: 55, y: -30)
                .offset(y: bubbleFloatOffset + (bubbleVisible ? 0 : 12))
        }
        .frame(width: 290, height: 220, alignment: .center)
    }

    private var oreoImage: some View {
        Image("OreoWaving")
            .resizable()
            .scaledToFit()
            .frame(height: 160)
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
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, theme.spacing.lg)
            .padding(.vertical, theme.spacing.md)
            .glassCard(cornerRadius: LeviRadius.md)
    }

    // MARK: – Hero text

    private var heroText: some View {
        VStack(alignment: .leading, spacing: theme.spacing.md) {
            Text("Stop launching\nin silence.")
                .font(.largeTitle.bold())
                .foregroundStyle(theme.colors.textPrimary)
                .lineSpacing(2)

            Text("Pick where you want to show up. Levi gives you daily quests so your build becomes visible before launch.")
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

        // Small delay so the initial layout is settled before any animation fires
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {

            // 1. Oreo shrinks from launch-screen size and rises to its layout position
            withAnimation(.spring(response: 0.52, dampingFraction: 0.82)) {
                heroPhase = true
            }

            // 2. Floating starts once Oreo is settled (~85% of spring at 0.45s)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                withAnimation(.easeInOut(duration: 2.4).repeatForever(autoreverses: true)) {
                    floatOffset = -10
                }
            }

            // 2b. Bubble float starts after it appears; slightly longer period → natural desync
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.80) {
                withAnimation(.easeInOut(duration: 3.0).repeatForever(autoreverses: true)) {
                    bubbleFloatOffset = -8
                }
            }

            // 3. Speech bubble rises in while Oreo is landing
            withAnimation(.spring(response: 0.44, dampingFraction: 0.76).delay(0.32)) {
                bubbleVisible = true
            }
            startTyping(after: 0.46)

            // 4. Hero text + button after Oreo and bubble are in place
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

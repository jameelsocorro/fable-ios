import SwiftUI

struct WelcomeStepView: View {
    let start: () -> Void
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var heroPhase = false
    @State private var contentVisible = false

    private let companionText = "I'll be your companion on \nyour journey!"
    private let launchScale: CGFloat = 1.25
    private let launchOffsetY: CGFloat = 130

    var body: some View {
        ZStack {
            theme.colors.background.ignoresSafeArea()

            PageGradientBackground(center: UnitPoint(x: 0.30, y: 0.65))

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
        CompanionBubbleView(
            imageName: "OreoWaving",
            message: companionText,
            animateTyping: true,
            floatDelay: 0.45,
            bubbleDelay: 0.37
        )
        .scaleEffect(heroPhase ? 1.0 : launchScale, anchor: .center)
        .offset(y: heroPhase ? 0 : launchOffsetY)
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
            contentVisible = true
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.spring(response: 0.52, dampingFraction: 0.82)) {
                heroPhase = true
            }
            withAnimation(.spring(response: 0.60, dampingFraction: 0.82).delay(0.54)) {
                contentVisible = true
            }
        }
    }
}

#Preview {
    WelcomeStepView(start: {})
}

import SwiftUI

struct QuestHoldButton: View {
    let quest: QuestDefinition
    let completion: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.colorScheme) private var colorScheme
    @State private var progress = 0.0
    @State private var didComplete = false
    @State private var isPressed = false

    var body: some View {
        ZStack {
            // Outer atmospheric glow ring (non-interactive)
            Circle()
                .fill(quest.platform.accentColor.opacity(0.06))
                .frame(width: 212, height: 212)

            // Glass backing disc
            Circle()
                .fill(.regularMaterial)
                .overlay {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    quest.platform.accentColor.opacity(isPressed ? 0.18 : 0.08),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 70
                            )
                        )
                }
                .overlay {
                    Circle()
                        .strokeBorder(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(colorScheme == .dark ? 0.18 : 0.65),
                                    Color.white.opacity(colorScheme == .dark ? 0.05 : 0.22)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
                .frame(width: 172, height: 172)
                .shadow(
                    color: quest.platform.accentColor.opacity(isPressed ? 0.22 : 0.10),
                    radius: isPressed ? 24 : 14,
                    x: 0,
                    y: isPressed ? 8 : 4
                )
                .animation(.spring(response: 0.35, dampingFraction: 0.8), value: isPressed)

            // Progress ring track
            Circle()
                .stroke(quest.platform.accentColor.opacity(0.15), lineWidth: 8)
                .frame(width: 172, height: 172)

            // Progress ring fill
            Circle()
                .trim(from: 0, to: progress)
                .stroke(quest.platform.accentColor, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .frame(width: 172, height: 172)
                .rotationEffect(.degrees(-90))

            // Inner fill that grows with progress
            Circle()
                .fill(quest.platform.accentColor.opacity(0.10 + (0.08 * progress)))
                .frame(width: 100 + CGFloat(44 * progress), height: 100 + CGFloat(44 * progress))

            Image(systemName: quest.platform.symbolName)
                .font(.system(size: 44, weight: .semibold))
                .foregroundStyle(quest.platform.accentColor)
                .scaleEffect(isPressed ? 1.08 : 1.0)
                .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isPressed)
                .accessibilityHidden(true)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Hold to commit \(quest.title)")
        .accessibilityHint("Keep holding until the circle fills.")
        .accessibilityAddTraits(.isButton)
        .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 32) {
            complete()
        } onPressingChanged: { isPressing in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.85)) {
                isPressed = isPressing
            }
            updateProgress(isPressing: isPressing)
        }
        .sensoryFeedback(.success, trigger: didComplete)
    }

    private func updateProgress(isPressing: Bool) {
        guard !didComplete else { return }

        if isPressing {
            withAnimation(.linear(duration: reduceMotion ? 0.01 : 1.0)) {
                progress = 1
            }
        } else {
            withAnimation(.spring(response: 0.30, dampingFraction: 0.80)) {
                progress = 0
            }
        }
    }

    private func complete() {
        guard !didComplete else { return }
        didComplete = true
        progress = 1
        completion()
    }
}

#Preview {
    QuestHoldButton(quest: QuestCatalog.all[0], completion: {})
}

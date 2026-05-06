import SwiftUI

struct FloatingOrbButtonStyle: ButtonStyle {
    let isVisible: Bool
    let reduceMotion: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.88 : (isVisible ? 1 : 0.2))
            .animation(reduceMotion ? nil : .spring(response: 0.22, dampingFraction: 0.75), value: configuration.isPressed)
            .animation(reduceMotion ? nil : .spring(response: 0.55, dampingFraction: 0.68), value: isVisible)
    }
}

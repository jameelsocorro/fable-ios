import SwiftUI

struct QuestActionButton: View {
    let systemImage: String
    let accessibilityLabel: String
    let accessibilityHint: String
    let action: () -> Void

    @Environment(\.theme) private var theme

    var body: some View {
        Button(accessibilityLabel, systemImage: systemImage, action: action)
            .labelStyle(.iconOnly)
            .font(.system(.body, weight: .semibold))
            .foregroundStyle(theme.colors.textPrimary)
            .frame(width: 44, height: 44)
            .background {
                Circle()
                    .fill(theme.colors.surface.opacity(0.9))
            }
            .buttonStyle(.plain)
            .accessibilityHint(accessibilityHint)
    }
}

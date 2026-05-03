import SwiftUI

struct TodayQuestStreakBadge: View {
    let quest: QuestDefinition
    let streakCount: Int
    let isCompleted: Bool
    let shouldBump: Bool

    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    @State private var countVersion: Int = 0

    var body: some View {
        VStack(spacing: theme.spacing.xs) {
            Image(systemName: "flame.fill")
                .font(.system(.title3, weight: .bold))
                .accessibilityHidden(true)

            Text("\(streakCount)")
                .font(ShoyoFont.subwayTickerGrid(size: 14, relativeTo: .callout))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .id(countVersion)
                .transition(reduceMotion ? .opacity : .asymmetric(
                    insertion: .offset(y: isCompleted ? 10 : -10).combined(with: .opacity),
                    removal: .offset(y: isCompleted ? -10 : 10).combined(with: .opacity)
                ))
        }
        .foregroundStyle(foregroundColor)
        .frame(width: 72, height: 72)
        .clipped()
        .background(backgroundStyle, in: .rect(cornerRadius: ShoyoRadius.md))
        .scaleEffect(shouldBump ? 1.12 : 1)
        .accessibilityHidden(true)
        .onChange(of: shouldBump) { _, newValue in
            guard newValue else { return }
            withAnimation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.65)) {
                countVersion += 1
            }
        }
        .onChange(of: isCompleted) { _, newValue in
            guard !newValue else { return }
            withAnimation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.75)) {
                countVersion += 1
            }
        }
    }

    private var backgroundStyle: AnyShapeStyle {
        if isCompleted {
            return AnyShapeStyle(theme.colors.surface.opacity(0.96))
        }

        return AnyShapeStyle(quest.platform.accentGradient)
    }

    private var foregroundColor: Color {
        if isCompleted {
            return quest.platform == .tiktok ? .white : theme.colors.textPrimary
        }
        return switch quest.platform {
        case .threads, .x: colorScheme == .dark ? theme.colors.textInverse : .white
        case .linkedin, .youtube, .facebook, .tiktok: .white
        case .instagram: .black
        case .reddit, .bluesky: theme.colors.textInverse
        }
    }
}

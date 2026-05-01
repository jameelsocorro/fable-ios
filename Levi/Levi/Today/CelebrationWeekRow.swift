import SwiftUI

struct CelebrationWeekRow: View {
    let recentDays: [StreakDayState]

    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: theme.spacing.md) {
            ForEach(recentDays) { day in
                VStack(spacing: theme.spacing.sm) {
                    Circle()
                        .fill(day.isCompleted ? theme.colors.textPrimary : .clear)
                        .overlay {
                            Circle()
                                .strokeBorder(theme.colors.textPrimary.opacity(0.85), lineWidth: 2)
                        }
                        .frame(width: 42, height: 42)
                        .overlay {
                            if day.completionCount > 0 {
                                Text("\(day.completionCount)")
                                    .font(.subheadline.bold())
                                    .foregroundStyle(day.isCompleted ? theme.colors.textInverse : theme.colors.textPrimary)
                            }
                        }

                    Text(day.isToday ? "Today" : day.dayStart.formatted(.dateTime.weekday(.abbreviated)))
                        .font(.caption.bold())
                        .foregroundStyle(theme.colors.textSecondary)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, theme.spacing.xl)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Recent completion history")
    }
}

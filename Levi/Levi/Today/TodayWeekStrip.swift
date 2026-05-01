import SwiftUI

struct TodayWeekStrip: View {
    let days: [StreakDayState]

    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: 0) {
            ForEach(days) { day in
                VStack(spacing: 2) {
                    Text(day.isToday ? "Today" : day.dayStart.formatted(.dateTime.weekday(.abbreviated)))
                        .font(.caption2.bold())
                        .foregroundStyle(day.isToday ? theme.colors.textPrimary : theme.colors.textSecondary)

                    Text(day.dayStart, format: .dateTime.day(.twoDigits))
                        .font(.callout.bold())
                        .foregroundStyle(day.isToday ? theme.colors.textInverse : theme.colors.textSecondary)
                        .frame(width: 36, height: 32)
                        .background {
                            if day.isToday {
                                Capsule()
                                    .fill(theme.colors.primary)
                            }
                        }
                }
                .frame(maxWidth: .infinity)
                .overlay(alignment: .bottom) {
                    if day.isCompleted && !day.isToday {
                        Circle()
                            .fill(theme.colors.primary)
                            .frame(width: 4, height: 4)
                            .offset(y: 6)
                    }
                }
            }
        }
        .padding(.vertical, theme.spacing.sm)
        .padding(.horizontal, theme.spacing.xs)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Recent days")
    }


}

#Preview {
    TodayWeekStrip(
        days: StreakCalculator.recentDays(
            completionDates: [.now],
            now: .now
        )
    )
    .padding()
    .environment(\.theme, LeviAppTheme(selection: .system))
}

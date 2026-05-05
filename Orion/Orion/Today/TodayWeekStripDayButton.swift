import SwiftUI

struct TodayWeekStripDayButton: View {
    let day: StreakDayState
    let isSelected: Bool
    let onSelect: () -> Void

    @Environment(\.theme) private var theme

    var body: some View {
        Button(action: onSelect) {
            VStack(spacing: 2) {
                Text(day.isToday ? "Today" : day.dayStart.formatted(.dateTime.weekday(.abbreviated)))
                    .font(.caption2.bold())
                    .foregroundStyle(titleForeground)

                Text(day.dayStart, format: .dateTime.day(.twoDigits))
                    .font(.callout.bold())
                    .foregroundStyle(dayForeground)
                    .frame(width: 36, height: 32)
                    .background {
                        if day.isToday {
                            Capsule()
                                .fill(theme.colors.primary)
                        } else if isSelected {
                            Capsule()
                                .fill(theme.colors.surfaceOverlay)
                                .overlay {
                                    Capsule()
                                        .stroke(theme.colors.borderStrong, lineWidth: 1)
                                }
                        }
                    }
            }
            .frame(maxWidth: .infinity, minHeight: 44)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .bottom) {
            if day.isCompleted && !day.isToday {
                Circle()
                    .fill(theme.colors.primary)
                    .frame(width: 4, height: 4)
                    .offset(y: 6)
            }
        }
        .accessibilityLabel(accessibilityLabel)
        .accessibilityValue(accessibilityValue)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }

    private var titleForeground: Color {
        if day.isToday || isSelected {
            return theme.colors.textPrimary
        }

        return theme.colors.textSecondary
    }

    private var dayForeground: Color {
        if day.isToday {
            return theme.colors.primaryForeground
        }

        if isSelected {
            return theme.colors.textPrimary
        }

        return theme.colors.textSecondary
    }

    private var accessibilityLabel: String {
        if day.isToday {
            return "Today, \(day.dayStart.formatted(.dateTime.month(.wide).day()))"
        }

        return day.dayStart.formatted(.dateTime.weekday(.wide).month(.wide).day())
    }

    private var accessibilityValue: String {
        var values = [day.isCompleted ? "Completed" : "Not completed"]

        if isSelected {
            values.insert("Selected", at: 0)
        }

        return values.joined(separator: ", ")
    }
}

#Preview {
    TodayWeekStripDayButton(
        day: StreakCalculator.recentDays(completionDates: [.now], now: .now)[3],
        isSelected: true,
        onSelect: {}
    )
    .padding()
    .environment(\.theme, OrionAppTheme(selection: .system))
}

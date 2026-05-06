import SwiftUI

struct StreakRecentHistoryCard: View {
    let days: [StreakDayState]

    @Environment(\.theme) private var theme

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: theme.spacing.sm), count: 7)
    }

    private var completedDayCount: Int {
        days.filter(\.isCompleted).count
    }

    private var totalCompletionCount: Int {
        days.reduce(0) { $0 + $1.completionCount }
    }

    private var today: StreakDayState? {
        days.first(where: \.isToday)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.lg) {
            header

            LazyVGrid(columns: columns, alignment: .center, spacing: theme.spacing.md) {
                ForEach(days) { day in
                    dayCell(day)
                }
            }

            Divider()
                .overlay(theme.colors.border)

            footer
        }
        .padding(theme.spacing.lg)
        .card()
        .accessibilityElement(children: .contain)
    }

    private var header: some View {
        HStack(alignment: .top, spacing: theme.spacing.md) {
            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                Text("Last \(days.count) days")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(theme.colors.textPrimary)

                Text(summaryText)
                    .font(.footnote)
                    .foregroundStyle(theme.colors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer(minLength: theme.spacing.md)

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(completedDayCount)/\(days.count)")
                    .font(OrionFont.subwayTickerGrid(size: 20, relativeTo: .body))
                    .foregroundStyle(theme.colors.textPrimary)
                    .monospacedDigit()

                Text("days")
                    .font(.system(.caption2, design: .monospaced, weight: .semibold))
                    .foregroundStyle(theme.colors.textSecondary)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(completedDayCount) of \(days.count) days completed")
        }
    }

    private var footer: some View {
        HStack(spacing: theme.spacing.sm) {
            Image(systemName: today?.isCompleted == true ? "checkmark.circle.fill" : "plus.circle")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(theme.colors.primary)
                .accessibilityHidden(true)

            Text(statusText)
                .font(.footnote.weight(.semibold))
                .foregroundStyle(theme.colors.textPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: theme.spacing.sm)

            Text("\(totalCompletionCount) \(totalCompletionCount == 1 ? "quest" : "quests")")
                .font(.caption)
                .foregroundStyle(theme.colors.textSecondary)
                .monospacedDigit()
        }
    }

    private func dayCell(_ day: StreakDayState) -> some View {
        VStack(spacing: theme.spacing.xs) {
            Text(weekdayText(for: day.dayStart))
                .font(.system(.caption2, design: .monospaced, weight: .semibold))
                .foregroundStyle(day.isToday ? theme.colors.textPrimary : theme.colors.textTertiary)

            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(fillStyle(for: day))
                .frame(height: 22)
                .overlay {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .stroke(
                            day.isToday ? theme.colors.textPrimary : theme.colors.border,
                            lineWidth: day.isToday ? 1.5 : 0.5
                        )
                }

            Text(dayNumberText(for: day.dayStart))
                .font(.system(.caption2, design: .monospaced, weight: day.isToday ? .bold : .regular))
                .foregroundStyle(day.isToday ? theme.colors.textPrimary : theme.colors.textSecondary)
                .monospacedDigit()
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel(for: day))
    }

    private var summaryText: String {
        if completedDayCount == 0 {
            return "Complete one quest to start filling this history."
        }

        if completedDayCount == days.count {
            return "Every recent day has at least one quest."
        }

        return "\(completedDayCount) recent \(completedDayCount == 1 ? "day" : "days") with at least one quest."
    }

    private var statusText: String {
        if today?.isCompleted == true {
            return "Today is on the board."
        }

        return "One quest today keeps the path moving."
    }

    private func fillStyle(for day: StreakDayState) -> Color {
        guard day.isCompleted else {
            return theme.colors.surfaceTertiary
        }

        switch min(day.completionCount, 3) {
        case 1:
            return theme.colors.primary.opacity(0.35)
        case 2:
            return theme.colors.primary.opacity(0.65)
        default:
            return theme.colors.primary
        }
    }

    private func weekdayText(for date: Date) -> String {
        switch Calendar.current.component(.weekday, from: date) {
        case 1:
            return "SU"
        case 2:
            return "M"
        case 3:
            return "T"
        case 4:
            return "W"
        case 5:
            return "TH"
        case 6:
            return "F"
        case 7:
            return "SA"
        default:
            return ""
        }
    }

    private func dayNumberText(for date: Date) -> String {
        date.formatted(.dateTime.day())
    }

    private func accessibilityLabel(for day: StreakDayState) -> String {
        let date = day.dayStart.formatted(.dateTime.weekday(.wide).month(.abbreviated).day())

        if day.completionCount == 0 {
            return day.isToday ? "Today, no quests completed yet" : "\(date), no quests completed"
        }

        let questCount = "\(day.completionCount) \(day.completionCount == 1 ? "quest" : "quests") completed"
        return day.isToday ? "Today, \(questCount)" : "\(date), \(questCount)"
    }
}

#Preview {
    let calendar = Calendar.current
    let today = calendar.startOfDay(for: .now)
    let completionDates = [
        today,
        today,
        calendar.date(byAdding: .day, value: -1, to: today),
        calendar.date(byAdding: .day, value: -3, to: today),
        calendar.date(byAdding: .day, value: -5, to: today),
        calendar.date(byAdding: .day, value: -5, to: today),
        calendar.date(byAdding: .day, value: -8, to: today),
        calendar.date(byAdding: .day, value: -12, to: today)
    ].compactMap { $0 }

    StreakRecentHistoryCard(
        days: StreakCalculator.recentDays(
            count: ProAccess.freeRecentHistoryDayLimit,
            completionDates: completionDates
        )
    )
    .padding()
    .environment(\.theme, OrionAppTheme(selection: .system))
}

import SwiftUI

struct StreakCommitBoard: View {
    let grid: [[StreakGridCell?]]  // [weekRow][dayCol], weeks oldest→newest, days Mon(0)→Sun(6)

    @Environment(\.theme) private var theme

    private let cellSize = StreakCommitGridBox.defaultSize
    private let cellSpacing = StreakCommitGridBox.defaultSpacing

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: cellSpacing) {
                        ForEach(Array(grid.enumerated()), id: \.offset) { weekIndex, week in
                            VStack(spacing: cellSpacing) {
                                ForEach(Array(week.enumerated()), id: \.offset) { _, cell in
                                    if let cell = cell {
                                        StreakCommitGridBox(intensity: cell.intensity)
                                    } else {
                                        Color.clear.frame(width: cellSize, height: cellSize)
                                    }
                                }
                            }
                            .id(weekIndex)
                        }
                    }
                    .padding(.leading, theme.spacing.lg)
                    .padding(.vertical, theme.spacing.lg)
                }
                .contentMargins(.trailing, theme.spacing.lg, for: .scrollContent)
                .onAppear {
                    proxy.scrollTo(grid.indices.last, anchor: .trailing)
                }
            }

            HStack(spacing: theme.spacing.sm) {
                Spacer()
                Text("Less")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(theme.colors.textTertiary)
                HStack(spacing: cellSpacing) {
                    ForEach(0..<4, id: \.self) { level in
                        StreakCommitGridBox(intensity: level)
                    }
                }
                Text("More")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundStyle(theme.colors.textTertiary)
            }
            .padding(.horizontal, theme.spacing.lg)
            .padding(.bottom, theme.spacing.md)
        }
        .card()
    }
}

#Preview {
    let cal = Calendar.current
    let end = cal.date(byAdding: .day, value: 1, to: cal.startOfDay(for: .now))!
    let start = cal.date(byAdding: .month, value: -12, to: cal.startOfDay(for: .now))!
    let sampleDates: [Date] = (0..<100).compactMap {
        cal.date(byAdding: .day, value: -($0 * 3), to: .now)
    } + Array(repeating: .now, count: 3)
    let grid = StreakCalculator.grid(for: DateInterval(start: start, end: end), completionDates: sampleDates)

    VStack(spacing: 24) {
        StreakCommitBoard(grid: grid)

        HStack(spacing: StreakCommitGridBox.defaultSpacing) {
            ForEach(0..<4, id: \.self) { intensity in
                StreakCommitGridBox(intensity: intensity)
            }
        }
    }
    .padding()
    .environment(\.theme, OrionAppTheme(selection: .system))
}

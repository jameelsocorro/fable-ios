import SwiftUI

struct StreakCommitBoard: View {
    let grid: [[StreakGridCell?]]  // [weekRow][dayCol], weeks oldest→newest, days Mon(0)→Sun(6)

    @Environment(\.theme) private var theme

    private let cellSize: CGFloat = 10
    private let cellSpacing: CGFloat = 3

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: cellSpacing) {
                        ForEach(Array(grid.enumerated()), id: \.offset) { weekIndex, week in
                            VStack(spacing: cellSpacing) {
                                ForEach(Array(week.enumerated()), id: \.offset) { _, cell in
                                    if let cell = cell {
                                        gridCell(intensity: cell.intensity)
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
                HStack(spacing: theme.spacing.xs) {
                    ForEach(0..<4, id: \.self) { level in
                        legendCell(intensity: level)
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

    // MARK: - Helpers

    private func cellOpacity(for intensity: Int) -> Double {
        switch intensity {
        case 1: return 0.3
        case 2: return 0.6
        default: return 1.0
        }
    }

    @ViewBuilder
    private func gridCell(intensity: Int) -> some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(intensity > 0 ? theme.colors.primary.opacity(cellOpacity(for: intensity)) : theme.colors.surfaceTertiary)
            .frame(width: cellSize, height: cellSize)
    }

    private func legendCell(intensity: Int) -> some View {
        RoundedRectangle(cornerRadius: 2, style: .continuous)
            .fill(intensity > 0 ? theme.colors.primary.opacity(cellOpacity(for: intensity)) : theme.colors.surfaceTertiary)
            .frame(width: cellSize, height: cellSize)
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

    StreakCommitBoard(grid: grid)
        .padding()
        .environment(\.theme, ShoyoAppTheme(selection: .system))
}

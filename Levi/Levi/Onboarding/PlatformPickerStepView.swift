import SwiftUI

struct PlatformPickerStepView: View {
    @Binding var selectedPlatforms: Set<SocialPlatform>
    let continueAction: () -> Void
    @Environment(\.theme) private var theme

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: theme.spacing.xl) {
                    VStack(alignment: .leading, spacing: theme.spacing.sm) {
                        Text("Where do you want to grow?")
                            .font(.largeTitle.bold())
                            .foregroundStyle(theme.colors.textPrimary)

                        Text("Choose at least one. One to three is best for staying consistent.")
                            .font(.body)
                            .foregroundStyle(theme.colors.textSecondary)
                    }

                    if selectedPlatforms.count > 3 {
                        Text("A few platforms are easier to keep alive.")
                            .font(.callout)
                            .foregroundStyle(theme.colors.warning)
                    }

                    ForEach(SocialPlatformGroup.allCases) { group in
                        VStack(alignment: .leading, spacing: theme.spacing.md) {
                            Text(group.title)
                                .font(.headline)
                                .foregroundStyle(theme.colors.textPrimary)

                            LazyVGrid(columns: columns, spacing: theme.spacing.md) {
                                ForEach(platforms(in: group)) { platform in
                                    PlatformSelectionCard(platform: platform, isSelected: selectedPlatforms.contains(platform)) {
                                        toggle(platform)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(theme.spacing.xl)
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            Button("Show my quests", action: continueAction)
                .buttonStyle(LeviPrimaryButtonStyle())
                .disabled(selectedPlatforms.isEmpty)
                .padding(theme.spacing.xl)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
        }
        .background(theme.colors.background)
    }

    private var columns: [GridItem] {
        [
            GridItem(.adaptive(minimum: 144), spacing: theme.spacing.md)
        ]
    }

    private func platforms(in group: SocialPlatformGroup) -> [SocialPlatform] {
        SocialPlatform.allCases.filter { $0.group == group }
    }

    private func toggle(_ platform: SocialPlatform) {
        if selectedPlatforms.contains(platform) {
            selectedPlatforms.remove(platform)
        } else {
            selectedPlatforms.insert(platform)
        }
    }
}

#Preview {
    PlatformPickerStepView(selectedPlatforms: .constant([.threads, .instagram]), continueAction: {})
}

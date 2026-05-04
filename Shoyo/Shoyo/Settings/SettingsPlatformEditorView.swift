import SwiftUI
import SwiftData

struct SettingsPlatformEditorView: View {
    let profile: FounderProfile

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.theme) private var theme
    @State private var draftPlatforms: Set<SocialPlatform>
    @State private var isShowingSaveError = false

    init(profile: FounderProfile) {
        self.profile = profile
        _draftPlatforms = State(initialValue: profile.selectedPlatforms)
    }

    var body: some View {
        List {
            Section {
                ForEach(SocialPlatform.allCases) { platform in
                    Button {
                        toggle(platform)
                    } label: {
                        HStack(spacing: theme.spacing.md) {
                            Label(platform.displayName, systemImage: platform.symbolName)

                            Spacer()

                            if draftPlatforms.contains(platform) {
                                Image(systemName: "checkmark")
                                    .bold()
                                    .foregroundStyle(theme.colors.primary)
                                    .accessibilityHidden(true)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityValue(draftPlatforms.contains(platform) ? "Selected" : "Not Selected")
                    .accessibilityAddTraits(accessibilityTraits(for: platform))
                }
            } footer: {
                Text("Keep at least one platform selected so Shoyo can keep your quest list focused.")
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Platforms")
        .toolbar(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", action: save)
                    .disabled(!canSave)
            }
        }
        .alert("Unable to Save Platforms", isPresented: $isShowingSaveError) {
        } message: {
            Text("Your platform changes could not be saved. Please try again.")
        }
    }

    private var canSave: Bool {
        SettingsPlatformSelection.canSave(draftPlatforms) && draftPlatforms != profile.selectedPlatforms
    }

    private func toggle(_ platform: SocialPlatform) {
        draftPlatforms = SettingsPlatformSelection.toggled(platform, in: draftPlatforms)
    }

    private func accessibilityTraits(for platform: SocialPlatform) -> AccessibilityTraits {
        draftPlatforms.contains(platform) ? .isSelected : AccessibilityTraits()
    }

    private func save() {
        let previousPlatforms = profile.selectedPlatforms
        profile.selectedPlatforms = draftPlatforms

        do {
            try modelContext.save()
            dismiss()
        } catch {
            modelContext.rollback()
            profile.selectedPlatforms = previousPlatforms
            isShowingSaveError = true
        }
    }
}

#Preview {
    NavigationStack {
        SettingsPlatformEditorView(
            profile: FounderProfile(
                projectName: "Shoyo",
                selectedPlatformIDs: ["threads", "instagram"],
                hasCompletedOnboarding: true,
                onboardingStep: .complete
            )
        )
    }
    .modelContainer(for: [FounderProfile.self, QuestCompletion.self], inMemory: true)
    .environment(\.theme, ShoyoAppTheme(selection: .system))
}

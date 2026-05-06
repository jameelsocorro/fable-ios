import SwiftUI

struct PlatformPickerStepView: View {
    @Binding var selectedPlatforms: Set<SocialPlatform>
    let hasOrionPro: Bool
    let continueAction: () -> Void

    @Environment(SubscriptionManager.self) private var subscriptionManager
    @Environment(\.theme) private var theme
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var activePaywallTrigger: OrionPaywallTrigger?
    @State private var pendingPlatformAfterPurchase: SocialPlatform?

    private let orbPlatforms: [SocialPlatform] = [
        .instagram, .tiktok, .threads, .youtube, .facebook,
        .linkedin, .x, .bluesky, .reddit
    ]

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 0)

            PlatformPickerHeroZone(
                orbPlatforms: orbPlatforms,
                selectedPlatforms: selectedPlatforms,
                onSelect: select
            )

            PlatformSelectionTray(
                orbPlatforms: orbPlatforms,
                selectedPlatforms: selectedPlatforms,
                hasOrionPro: hasOrionPro,
                onDeselect: deselect
            )
            .padding(.horizontal, theme.spacing.xl)
            .padding(.top, theme.spacing.lg)

            Spacer(minLength: 0)
        }
        .background {
            ZStack {
                theme.colors.background
                    .ignoresSafeArea()
                PageGradientBackground(center: UnitPoint(x: 0.5, y: 0.0))
            }
        }
        .safeAreaInset(edge: .bottom) {
            if !selectedPlatforms.isEmpty {
                Button("Continue", action: continueAction)
                    .buttonStyle(OrionPrimaryButtonStyle())
                    .padding(.horizontal, theme.spacing.xl)
                    .padding(.bottom, theme.spacing.lg)
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom).combined(with: .opacity),
                        removal: .opacity
                    ))
            }
        }
        .animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.8), value: selectedPlatforms.isEmpty)
        .sensoryFeedback(.success, trigger: selectedPlatforms.count) { old, new in new > old }
        .sensoryFeedback(.impact(weight: .light), trigger: selectedPlatforms.count) { old, new in new < old }
        .sheet(item: $activePaywallTrigger) { trigger in
            OrionPaywallSheet(trigger: trigger) {
                applyPendingPlatformIfPro()
            }
        }
    }

    private func select(_ platform: SocialPlatform) {
        guard ProAccess.canSelect(
            platform,
            selectedPlatforms: selectedPlatforms,
            hasOrionPro: hasOrionPro
        ) else {
            pendingPlatformAfterPurchase = platform
            activePaywallTrigger = .platformLimit
            return
        }

        insert(platform)
    }

    private func insert(_ platform: SocialPlatform) {
        withAnimation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.72)) {
            _ = selectedPlatforms.insert(platform)
        }
    }

    private func deselect(_ platform: SocialPlatform) {
        withAnimation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.72)) {
            _ = selectedPlatforms.remove(platform)
        }
    }

    private func applyPendingPlatformIfPro() {
        guard subscriptionManager.hasOrionPro, let pendingPlatformAfterPurchase else { return }

        insert(pendingPlatformAfterPurchase)
        self.pendingPlatformAfterPurchase = nil
    }
}

#Preview {
    PlatformPickerStepView(
        selectedPlatforms: .constant([.instagram]),
        hasOrionPro: false,
        continueAction: {}
    )
    .environment(SubscriptionManager())
}

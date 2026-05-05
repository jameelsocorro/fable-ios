import SwiftUI
import RevenueCat
import RevenueCatUI

struct OrionPaywallSheet: View {
    let trigger: OrionPaywallTrigger
    let purchaseCompleted: () -> Void

    @Environment(SubscriptionManager.self) private var subscriptionManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        PaywallView(displayCloseButton: true)
            .id(trigger.id)
            .onPurchaseCompleted { _, customerInfo in
                completeIfOrionPro(customerInfo)
            }
            .onRestoreCompleted { customerInfo in
                completeIfOrionPro(customerInfo)
            }
            .onPurchaseCancelled {
                Task {
                    await subscriptionManager.refreshCustomerInfo()
                }
            }
            .onPurchaseFailure { error in
                subscriptionManager.report(error)
            }
            .onRestoreFailure { error in
                subscriptionManager.report(error)
            }
            .onRequestedDismissal {
                Task {
                    await subscriptionManager.refreshCustomerInfo()
                }
                dismiss()
            }
    }

    private func completeIfOrionPro(_ customerInfo: CustomerInfo) {
        subscriptionManager.updateCustomerInfo(customerInfo)

        guard SubscriptionManager.hasOrionPro(customerInfo) else {
            subscriptionManager.reportNoActiveOrionProPurchase()
            return
        }

        purchaseCompleted()
        dismiss()
    }
}

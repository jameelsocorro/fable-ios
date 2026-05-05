import Foundation
import Observation
import RevenueCat

@MainActor
@Observable
final class SubscriptionManager {
    private(set) var customerInfo: CustomerInfo?
    private(set) var offerings: Offerings?
    private(set) var isRefreshing = false
    private(set) var errorMessage: String?

    @ObservationIgnored private var customerInfoTask: Task<Void, Never>?

    var hasOrionPro: Bool {
        customerInfo.map(Self.hasOrionPro) == true
    }

    var hasCurrentOffering: Bool {
        offerings?.current != nil
    }

    func start() async {
        await refreshCustomerInfo()
        await refreshOfferings()
        listenForCustomerInfoUpdates()
    }

    func refreshCustomerInfo() async {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            customerInfo = try await Purchases.shared.customerInfo()
        } catch {
            record(error)
        }
    }

    func refreshOfferings() async {
        do {
            offerings = try await Purchases.shared.offerings()

            if offerings?.current == nil {
                errorMessage = "Orion Pro is not available right now. Please try again later."
            }
        } catch {
            record(error)
        }
    }

    func updateCustomerInfo(_ customerInfo: CustomerInfo) {
        self.customerInfo = customerInfo
        errorMessage = nil
    }

    func restorePurchases() async {
        isRefreshing = true
        defer { isRefreshing = false }

        do {
            let restoredInfo = try await Purchases.shared.restorePurchases()
            customerInfo = restoredInfo

            if Self.hasOrionPro(restoredInfo) {
                errorMessage = nil
            } else {
                reportNoActiveOrionProPurchase()
            }
        } catch {
            record(error)
        }
    }

    func clearError() {
        errorMessage = nil
    }

    func report(_ error: Error) {
        record(error)
    }

    func report(_ message: String) {
        errorMessage = message
    }

    func reportNoActiveOrionProPurchase() {
        errorMessage = "No active Orion Pro purchase was found for this Apple ID."
    }

    static func hasOrionPro(_ customerInfo: CustomerInfo) -> Bool {
        customerInfo.entitlements.all[SubscriptionEntitlement.orionPro]?.isActive == true
    }

    private func listenForCustomerInfoUpdates() {
        guard customerInfoTask == nil else { return }

        customerInfoTask = Task { [weak self] in
            for await customerInfo in Purchases.shared.customerInfoStream {
                self?.updateCustomerInfo(customerInfo)
            }
        }
    }

    private func record(_ error: Error) {
        errorMessage = error.localizedDescription
    }
}

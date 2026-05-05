import Foundation
import RevenueCat

enum RevenueCatConfigurationError: LocalizedError {
    case missingAPIKey
    case testKeyInRelease

    var errorDescription: String? {
        switch self {
        case .missingAPIKey:
            "RevenueCat API key is missing. Add REVENUECAT_API_KEY to Secrets.xcconfig."
        case .testKeyInRelease:
            "RevenueCat Test Store keys must not be used in Release builds."
        }
    }
}

enum RevenueCatConfig {
    static let apiKeyInfoDictionaryKey = "REVENUECAT_API_KEY"
    static let debugAppUserIDInfoDictionaryKey = "REVENUECAT_DEBUG_APP_USER_ID"

    static func apiKey(bundle: Bundle = .main) throws -> String {
        guard let rawValue = bundle.object(forInfoDictionaryKey: apiKeyInfoDictionaryKey) as? String else {
            throw RevenueCatConfigurationError.missingAPIKey
        }

        let key = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty, !key.hasPrefix("$(") else {
            throw RevenueCatConfigurationError.missingAPIKey
        }

        #if !DEBUG
        guard !key.hasPrefix("test_") else {
            throw RevenueCatConfigurationError.testKeyInRelease
        }
        #endif

        return key
    }

    @MainActor
    static func configure(bundle: Bundle = .main) throws {
        guard !Purchases.isConfigured else { return }

        let key = try apiKey(bundle: bundle)

        #if DEBUG
        Purchases.logLevel = .debug
        #else
        Purchases.logLevel = .warn
        #endif

        #if DEBUG
        if let debugAppUserID = debugAppUserID(bundle: bundle) {
            Purchases.configure(withAPIKey: key, appUserID: debugAppUserID)
        } else {
            Purchases.configure(withAPIKey: key)
        }
        #else
        Purchases.configure(withAPIKey: key)
        #endif
    }

    static func debugAppUserID(bundle: Bundle = .main) -> String? {
        #if DEBUG
        guard let rawValue = bundle.object(forInfoDictionaryKey: debugAppUserIDInfoDictionaryKey) as? String else {
            return nil
        }

        let appUserID = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !appUserID.isEmpty, !appUserID.hasPrefix("$(") else {
            return nil
        }

        return appUserID
        #else
        nil
        #endif
    }
}

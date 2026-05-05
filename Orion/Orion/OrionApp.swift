//
//  OrionApp.swift
//  Orion
//
//  Created by Jameel Socorro on 4/28/26.
//

import SwiftUI
import SwiftData

@main
struct OrionApp: App {
    @AppStorage(AppAppearance.storageKey) private var selectedAppearanceRawValue = AppAppearance.system.rawValue
    @State private var subscriptionManager = SubscriptionManager()
    private let isRevenueCatConfigured: Bool
    private let revenueCatConfigurationMessage: String?

    init() {
        do {
            try RevenueCatConfig.configure()
            isRevenueCatConfigured = true
            revenueCatConfigurationMessage = nil
        } catch {
            #if DEBUG
            debugPrint("RevenueCat configuration skipped: \(error.localizedDescription)")
            isRevenueCatConfigured = false
            revenueCatConfigurationMessage = error.localizedDescription
            #else
            fatalError(error.localizedDescription)
            #endif
        }
    }

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FounderProfile.self,
            QuestCompletion.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(subscriptionManager)
                .environment(\.theme, OrionAppTheme(selection: .system))
                .preferredColorScheme(selectedAppearance.colorScheme)
                .task {
                    guard isRevenueCatConfigured else {
                        if let revenueCatConfigurationMessage {
                            subscriptionManager.report(revenueCatConfigurationMessage)
                        }
                        return
                    }

                    await subscriptionManager.start()
                }
        }
        .modelContainer(sharedModelContainer)
    }

    private var selectedAppearance: AppAppearance {
        AppAppearance(storedValue: selectedAppearanceRawValue)
    }
}

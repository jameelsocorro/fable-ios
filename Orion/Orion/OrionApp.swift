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
                .environment(\.theme, OrionAppTheme(selection: .system))
                .preferredColorScheme(selectedAppearance.colorScheme)
        }
        .modelContainer(sharedModelContainer)
    }

    private var selectedAppearance: AppAppearance {
        AppAppearance(storedValue: selectedAppearanceRawValue)
    }
}

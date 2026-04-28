//
//  FableApp.swift
//  Fable
//
//  Created by Jameel Socorro on 4/28/26.
//

import SwiftUI
import SwiftData

@main
struct FableApp: App {
    @AppStorage(FableTheme.storageKey) private var selectedThemeRawValue = FableTheme.system.rawValue

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
                .environment(\.theme, FableAppTheme(selection: selectedTheme))
        }
        .modelContainer(sharedModelContainer)
    }

    private var selectedTheme: FableTheme {
        FableTheme(storedValue: selectedThemeRawValue)
    }
}

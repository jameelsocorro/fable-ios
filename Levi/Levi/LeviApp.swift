//
//  LeviApp.swift
//  Levi
//
//  Created by Jameel Socorro on 4/28/26.
//

import SwiftUI
import SwiftData

@main
struct LeviApp: App {
    @AppStorage(LeviTheme.storageKey) private var selectedThemeRawValue = LeviTheme.system.rawValue

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
                .environment(\.theme, LeviAppTheme(selection: selectedTheme))
        }
        .modelContainer(sharedModelContainer)
    }

    private var selectedTheme: LeviTheme {
        LeviTheme(storedValue: selectedThemeRawValue)
    }
}

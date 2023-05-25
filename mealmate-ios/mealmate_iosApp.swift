//
//  mealmate_iosApp.swift
//  mealmate-ios
//
//  Created by Maximilian Kaiser on 25.05.23.
//

import SwiftUI

@main
struct mealmate_iosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

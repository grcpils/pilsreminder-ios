//
//  MyRemindersApp.swift
//  MyReminders
//
//  Created by Pierrick Gouerec on 05/02/2022.
//

import SwiftUI

@main
struct MyRemindersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

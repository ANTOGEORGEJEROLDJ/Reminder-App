//
//  ReminderAppApp.swift
//  ReminderApp
//
//  Created by Paranjothi iOS MacBook Pro on 18/06/25.
//

import SwiftUI
//import Firebase

@main
struct DeveloperReminderAppApp: App {
    let persistenceController = PersistenceController.shared
//
//    init() {
//        FirebaseApp.configure()
//    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

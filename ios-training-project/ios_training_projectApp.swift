//
//  ios_training_projectApp.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 25/11/24.
//

import SwiftUI

@main
struct ios_training_projectApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}

//
//  PersistenceController.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 12/12/24.
//

import Foundation
import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    
    //=----------------------------------------------------------------------------------------
    
    // Preview container
    static var preview: PersistenceController = {
        
        let controller = PersistenceController(inMemory: true)
        
        // Add some mock data for the preview
        let context = controller.container.viewContext
        
        let user1 = User(context: context)
        user1.email = "abc@email.com"
        user1.password = "abc123"
        user1.username = "ABC"
        
        let data1 = TimeOff(context: context)
        data1.id = UUID()
        data1.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
        data1.holidayName = "\(user1.username!) - TF\(Int.random(in: 10...99))"
        data1.startDate = Date()
        data1.endDate = Date().addingTimeInterval(60*60*24)
        data1.isHalfDay = Bool.random()
        data1.creationDate = Date().addingTimeInterval(-60*60*24)
        data1.user = user1
        
        let data2 = TimeOff(context: context)
        data2.id = UUID()
        data2.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
        data2.holidayName = "\(user1.username!) - TF\(Int.random(in: 10...99))"
        data2.startDate = Date()
        data2.endDate = Date().addingTimeInterval(60*60*24)
        data2.isHalfDay = Bool.random()
        data2.creationDate = Date().addingTimeInterval(-60*60*24)
        data2.user = user1
        
        
        // Save the context to persist the mock data
        do {
            try context.save()
        } catch {
            fatalError("Unresolved error \(error), \(error.localizedDescription)")
        }
        
        return controller
    }()
    
    //=----------------------------------------------------------------------------------------
    
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "UserDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        //Print SQLite file path
        printSQLiteFilePath()
    }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Successfully saved context!") // Debug log to confirm save
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
            print("No changes to save.")
        }
    }
    
    var viewContext:NSManagedObjectContext{
        return container.viewContext
    }
    
    //=----------------------------------------------------------------------------------------
    
    
    func printSQLiteFilePath() {
        // Access the persistent container's store URL
        let storeURL = container.persistentStoreCoordinator.persistentStores.first?.url
        if let storeURL = storeURL {
            print("SQLite file path: \(storeURL.path)")
        } else {
            print("SQLite file not found")
        }
    }
    
    //=----------------------------------------------------------------------------------------
    
    
}

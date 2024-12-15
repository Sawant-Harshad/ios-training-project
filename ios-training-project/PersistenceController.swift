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
        
        // Call this function to add dummy data if Core Data is empty
        addDummyDataIfNeeded()
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
    
    //=----------------------------------------------------------------------------------------
    
    func addDummyDataIfNeeded() {
        
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        printSQLiteFilePath()
        
        do{
            let users = try context.fetch(fetchRequest)
            print("Existing users in Core Data: ") // Debug log to see users
            users.forEach{user in
                print("\(user.email!) - \(user.password!)")
            }
            
            
            if let user1 = users.first(where: { $0.email == "harshad.sawant@example.com" }) {
                // If user1 exists, add dummy DataItems
                print("Found existing \(user1.email!)")
                //                addDummyDataItems(for: user1)
                //                save()
                let dataList = fetchData(for: user1)
                
            } else {
                // Create new user and add dummy data if it doesn't exist
                let user1 = User(context: context)
                user1.email = "harshad.sawant@example.com"
                user1.password = "harshad"
                user1.username = "Harshad Sawant"
                print("Created new user: \(user1.email ?? "abc@email.com")") // Log the creation
                
                let user2 = User(context: context)
                user2.email = "ankit.kishor@example.com"
                user2.password = "ankit"
                user2.username = "Ankit Kishore"
                print("Created new user: \(user2.email ?? "abc@email.com")") // Log the creation
                
                // Create dummy DataItems for users
                addDummyDataItems(for: user1)
                addDummyDataItems(for: user2)
                save()
            }
            
        }catch{
            print("Failed to fetch users: \(error.localizedDescription)")
        }
        
    }
    
    func addDummyDataItems(for user: User) {
        
        let context = container.viewContext
        
        // Create dummy DataItems
        let data1 = TimeOff(context: context)
        data1.id = UUID()
        data1.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
        data1.holidayName = "\(user.username ?? "User") - TF\(Int.random(in: 10...99))"
        data1.startDate = Date()
        data1.endDate = Date().addingTimeInterval(60*60*24)
        data1.isHalfDay = Bool.random()
        data1.creationDate = Date().addingTimeInterval(-60*60*24)
        data1.user = user
        
        print("Data 1: \(data1.id ?? UUID()) - \(data1.holidayName ?? "Holiday Name")")
        
        let data2 = TimeOff(context: context)
        data2.id = UUID()
        data2.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
        data2.holidayName = "\(user.username ?? "User") - TF\(Int.random(in: 10...99))"
        data2.startDate = Date()
        data2.endDate = Date().addingTimeInterval(60*60*24)
        data2.isHalfDay = Bool.random()
        data2.creationDate = Date().addingTimeInterval(-60*60*24)
        data2.user = user
        
        print("Data 2: \(data2.id ?? UUID()) - \(data2.holidayName ?? "Holiday Name")")
        
        do {
            try context.save()
            print("Successfully added data.") // Debug log to confirm save
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    //=----------------------------------------------------------------------------------------
    
    // Add fetchUsers method
    func fetchUsers() -> [User] {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
    
    func fetchData(for user: User) -> [TimeOff] {
        let context = container.viewContext
        let request: NSFetchRequest<TimeOff> = TimeOff.fetchRequest()
        request.predicate = NSPredicate(format: "user.email == %@", user.email!)
        
        do {
            let dataItems = try context.fetch(request)
            print("Fetched \(dataItems.count) data items for user \(user.email ?? "abc@email.com") .") // Log fetched data
            dataItems.forEach{ timeOff in
                print("\(timeOff.id?.uuidString) - Attachments: \(timeOff.attachments!.count)")
            }
            return dataItems
        } catch {
            print("Failed to fetch data items: \(error)")
            return []
        }
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

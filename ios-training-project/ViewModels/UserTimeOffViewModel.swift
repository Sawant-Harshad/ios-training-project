//
//  UserTimeOffViewModel.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 03/02/25.
//

import Foundation
import CoreData
import SwiftUI

class UserTimeOffViewModel: ObservableObject {
    private var viewContext:NSManagedObjectContext
    @Published var userData: UserSession? = nil
    
    //=----------------------------------------------------------------------------------------
    
    init(context: NSManagedObjectContext){
        self.viewContext = context
        addDummyDataIfNeeded()
    }
    
    //=----------------------------------------------------------------------------------------
    
    // Add fetchUsers method
    func fetchUsers() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            return users
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
    
    func fetchData(for user: User) -> [TimeOff] {
        let request: NSFetchRequest<TimeOff> = TimeOff.fetchRequest()
        request.predicate = NSPredicate(format: "user.email == %@", user.email!)
        
        do {
            let dataItems = try viewContext.fetch(request)
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
    
    func fetchUser(_ email: String) -> User? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let users = try viewContext.fetch(fetchRequest)
            
            if let existingUser = users.first {
                return existingUser
            }
            else{
                print("Error: User not found !!")
                return nil
            }
            
        } catch {
            print("Failed to fetch users: \(error)")
            return nil
        }
    }
    
    //=----------------------------------------------------------------------------------------
    
    func addDummyDataIfNeeded() {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do{
            let users = try viewContext.fetch(fetchRequest)
            print("Existing users in Core Data: ") // Debug log to see users
            users.forEach{user in
                print("\(user.email!) - \(user.password!)")
            }
            
            
            if let user1 = users.first(where: { $0.email == "harshad.sawant@example.com" }) {
                // If user1 exists, add dummy DataItems
                print("Found existing \(user1.email!)")
                let dataList = fetchData(for: user1)
                
            } else {
                // Create new user and add dummy data if it doesn't exist
                let user1 = User(context: viewContext)
                user1.email = "harshad.sawant@example.com"
                user1.password = "harshad"
                user1.username = "Harshad Sawant"
                print("Created new user: \(user1.email ?? "abc@email.com")") // Log the creation
                
                let user2 = User(context: viewContext)
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
        
        // Create dummy DataItems
        let data1 = TimeOff(context: viewContext)
        data1.id = UUID()
        data1.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
        data1.holidayName = "\(user.username ?? "User") - TF\(Int.random(in: 10...99))"
        data1.startDate = Date()
        data1.endDate = Date().addingTimeInterval(60*60*24)
        data1.isHalfDay = Bool.random()
        data1.creationDate = Date().addingTimeInterval(-60*60*24)
        user.addToUserTimeOffList(data1)
        
        print("Data 1: \(data1.id ?? UUID()) - \(data1.holidayName ?? "Holiday Name")")
        
        let data2 = TimeOff(context: viewContext)
        data2.id = UUID()
        data2.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
        data2.holidayName = "\(user.username ?? "User") - TF\(Int.random(in: 10...99))"
        data2.startDate = Date()
        data2.endDate = Date().addingTimeInterval(60*60*24)
        data2.isHalfDay = Bool.random()
        data2.creationDate = Date().addingTimeInterval(-60*60*24)
        user.addToUserTimeOffList(data2)
        
        print("Data 2: \(data2.id ?? UUID()) - \(data2.holidayName ?? "Holiday Name")")
        
        do {
            try viewContext.save()
            print("Successfully added data.") // Debug log to confirm save
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    //=----------------------------------------------------------------------------------------
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                print("Successfully saved context!") // Debug log to confirm save
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
            print("No changes to save.")
        }
    }
    
}

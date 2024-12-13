//
//  UserSession.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 13/12/24.
//

import Foundation

struct UserSession {
    var userEmail: String
    var userPassword: String
    var userUserName : String
    
    // You can define a method to save UserData to UserDefaults
    static func saveToDefaults(userData: UserSession) {
        UserDefaults.standard.set(userData.userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userData.userPassword, forKey: "userPassword")
        UserDefaults.standard.set(userData.userUserName, forKey: "userUserName")
        print("Logged in user : \(userData.userEmail) - \(userData.userUserName)")
    }
    
    // And also a method to load UserData from UserDefaults
    static func loadFromDefaults() -> UserSession? {
        guard let userEmail = UserDefaults.standard.string(forKey: "userEmail"),
              let userPassword = UserDefaults.standard.string(forKey: "userPassword"),
              let userUserName = UserDefaults.standard.string(forKey: "userUserName")else {
            return nil
        }
        print("Session user : \(userEmail) - \(userUserName)")
        return UserSession(userEmail: userEmail, userPassword: userPassword , userUserName: userUserName)
    }
    
    // Method to clear user data (for logout)
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userPassword")
        UserDefaults.standard.removeObject(forKey: "userUsername")
        
    }
}

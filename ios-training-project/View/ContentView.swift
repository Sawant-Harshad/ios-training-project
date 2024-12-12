//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn: Bool = false
    @State private var currentUser: User? = nil // Store the current logged-in user
    
    var body: some View {
        
        NavigationStack {
            if isLoggedIn, let user = currentUser {
                // HomeView is displayed when logged in
                HomeView(user: user, isLoggedIn: $isLoggedIn)
            } else {
                // LoginView is displayed when not logged in
                LoginView(isLoggedIn: $isLoggedIn, currentUser: $currentUser)
            }
        }

        
    }
}

#Preview {
    ContentView()
}

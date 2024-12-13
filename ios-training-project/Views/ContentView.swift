//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var isOnLoginView = false
    
    var body: some View {
        
        //        Text("isLoggedIn: \(isLoggedIn ? "true" : "false")")
        
        NavigationStack {
            if isLoggedIn{
                // HomeView is displayed when logged in
                HomeView()
            } else {
                // SSOLoginView is displayed when not logged in
                SSOLoginView(isOnLoginView: $isOnLoginView)
                    .onChange(of: isOnLoginView){ _ in
                        if isOnLoginView{
                            isLoggedIn = false
                        }
                    }
            }
        }
        
        
    }
}

#Preview {
    UserDefaults.standard.set(false, forKey: "isLoggedIn")
    return ContentView()
}

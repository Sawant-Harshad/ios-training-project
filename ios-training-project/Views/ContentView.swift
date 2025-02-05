//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var isOnLoginView = false
    
    @StateObject var viewModel = UserTimeOffViewModel(context: PersistenceController.shared.viewContext)
    
    var body: some View {
        
        NavigationStack {
            if isLoggedIn{
                // HomeView is displayed when logged in
                HomeView(viewModel: self.viewModel)
                
            } else {
                
                // SSOLoginView is displayed when not logged in
                SSOLoginView(isOnLoginView: $isOnLoginView, viewModel: self.viewModel)
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

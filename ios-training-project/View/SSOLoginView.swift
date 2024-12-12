//
//  SSOLoginView.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//

import SwiftUI

struct SSOLoginView: View {
    
    @Binding var isLoggedIn: Bool
    @Binding var currentUser: User?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // logo
                Image("logoBtsavvy")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical,32)
                
                // title
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.blue)
                
                
                
                
                Spacer()
                
                // SSO Buttons
                VStack(spacing: 15) {
                    
                    NavigationLink(
                        destination: LoginView(
                            isLoggedIn: $isLoggedIn,
                            currentUser: $currentUser
                        ).navigationBarBackButtonHidden(true),
                        isActive: $isLoggedIn
                    ){
                        EmptyView()
                        
                        SSOButton(
                            provider: {
                                isLoggedIn = true
                            },
                            color: .red,
                            logo: "Salesforcelogo",
                            text: "Sign in with Salesforce"
                        )
                    }
                    .padding(.horizontal)
                    
                }
                
                Spacer()
            }
            .padding()
            .background(.black)
            
        }
    }
}

#Preview {
    SSOLoginView(
        isLoggedIn: .constant(true),
        currentUser: .constant(PersistenceController.preview.fetchUsers().first)
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

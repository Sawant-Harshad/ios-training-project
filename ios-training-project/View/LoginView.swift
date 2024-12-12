//
//  LoginView.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//

import SwiftUI
import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool
    @Binding var currentUser: User?
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let persistenceController = PersistenceController.shared
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // Top bar with back arrow
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .overlay(
                        HStack {
                            Button(action: {
                                dismiss() // Trigger dismiss
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(.leading, 16)
                            }
                            Spacer()
                        }
                    )
                
                // Image
                Image("Salesforcelogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 32)
                
                // Input fields
                VStack(spacing: 24) {
                    InputFormView(text: $email, title: "Email", placeholder: "abc@email.com")
                    
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .foregroundColor(Color.black)
                            .fontWeight(.regular)
                            .font(.footnote)
                        SecureField("Password", text: $password)
                            .font(.system(size: 14))
                            .padding(14)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                    }
                    
                }
                
                CustomButton(
                    title: "Sign In",
                    action: {
                        signIn()
                    },
                    backgroundColor: .purple
                )
                .fontWeight(.semibold)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                .padding(.top, 24)
                .font(.system(size: 20))
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Failed"), message: Text("Invalid email or password."), dismissButton: .default(Text("OK")))
                }
                
                // // Only navigate if user is valid
                if let user = getUserForEmail(email), isLoggedIn {
                    NavigationLink(
                        destination: HomeView(user: user,isLoggedIn: $isLoggedIn),
                        isActive: $isLoggedIn,
                        label: {
                            EmptyView()
                        }
                    )
                    .isDetailLink(false)
                }
                
                
                
            }
            .padding(.horizontal)
            .padding(.bottom, 14)
            .font(.system(size: 13))
            
            Spacer()
        }
    }
    
    
    private func signIn() {
        guard let user = validateUser(email: email, password: password) else {
            alertMessage = "Invalid email or password"
            showAlert = true
            return
        }
        // If user is validated, set currentUser and isLoggedIn to true
        currentUser = user
        isLoggedIn = true
    }
    
    private func validateUser(email: String, password: String) -> User? {
        let users = persistenceController.fetchUsers()
        return users.first { $0.email == email && $0.password == password }
    }
    
    private func getUserForEmail(_ email: String) -> User? {
        return persistenceController.fetchUsers().first(where: { $0.email == email })
    }
    
    
}


#Preview {
    LoginView(
        isLoggedIn: .constant(true),
        currentUser: .constant(PersistenceController.preview.fetchUsers().first)
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

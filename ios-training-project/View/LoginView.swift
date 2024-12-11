//
//  LoginView.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//
import SwiftUI
import SwiftUI

struct LoginView: View {
    @State private var timeOffRequest = TimeOffRequest()
    @State private var username: String = ""
    @State private var password: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var isLoggedIn = false
    @State private var showAlert = false

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
                    InputFormView(text: $username, title: "Username", placeholder: "name@example.com")

                    
                    InputFormView(text: $password, title: "Password", placeholder: "Enter password")
                }
                
                // Login button
                NavigationLink(destination: TimeOffTableView(), isActive: $isLoggedIn) {
                    
                    
                    CustomButton(title: "Log In", action: {
                        if username == "Ankitkishore" && password == "12345" {
                            isLoggedIn = true
                        } else {
                            showAlert = true
                        }
                    }, backgroundColor: .purple)}
                    .fontWeight(.semibold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                    .padding(.top, 24)
                    .font(.system(size: 20))
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Login Failed"), message: Text("Invalid username or password."), dismissButton: .default(Text("OK")))
                    }
                
//                // Remember Me Toggle
//                Toggle(isOn: $timeOffRequest.isHalfDay) {
//                    Text("Remember me")
//                        .foregroundColor(.black)
//                    Spacer()
//                }
//                .toggleStyle(CheckBox())
            }
            .padding(.horizontal)
            .padding(.bottom, 14)
            .font(.system(size: 13))
            
            Spacer()
        }
    }
}


#Preview {
    LoginView()
}

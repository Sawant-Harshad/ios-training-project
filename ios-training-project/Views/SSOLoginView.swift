//
//  SSOLoginView.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//

import SwiftUI

struct SSOLoginView: View {
    
    @Binding var isOnLoginView: Bool
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel:UserTimeOffViewModel
    
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
                        destination: LoginView(viewModel: self.viewModel, isOnLoginView: $isOnLoginView).navigationBarBackButtonHidden(true),
                        isActive: $isOnLoginView
                    ){
                        //                        EmptyView()
                        
                        SSOButton(
                            provider: {
                                isOnLoginView = true
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
    let context = PersistenceController.preview.container.viewContext
    SSOLoginView(isOnLoginView: .constant(true), viewModel: UserTimeOffViewModel(context: context))
        .environment(\.managedObjectContext, context)
}

//
//  SSOLoginView.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//

import SwiftUI

struct SSOLoginView: View {
    var body: some View {
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
                
                SSOButton(provider: "Sign in with Salesforce", color: .red)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(.black)
    }
}

#Preview {
    SSOLoginView()
}

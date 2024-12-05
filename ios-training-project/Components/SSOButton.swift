//
//  SSOButton.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//

import SwiftUI

struct SSOButton: View {
    var provider: String
    var color: Color

    
    var body: some View {
        Button(action: {
            // Handle SSO login action
            print(provider)
        }) {
            HStack {
                Image("Salesforcelogo")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                
                
                Text(provider)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
        }
        .shadow(radius: 2)
    }
}


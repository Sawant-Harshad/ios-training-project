//
//  SSOButton.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 06/12/24.
//

import SwiftUI

struct SSOButton: View {
    var provider:()->Void
    var color: Color
    var logo: String
    var text: String

    
    var body: some View {
        Button(action: provider){
            HStack {
                Image(logo)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                
                
                Text(text)
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


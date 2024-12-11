//
//  CustomButton.swift
//  SalesforceDemo
//
//  Created by Ankit Kishor on 19/11/24.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    let backgroundColor: Color
    let textColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.horizontal,5)
                .padding(.vertical)
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(50)
        }
    }
}

#Preview {
    CustomButton(title: "Sample", action: {}, backgroundColor: .purple)
}

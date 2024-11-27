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
                    .padding()
                    .background(backgroundColor)
                    .foregroundColor(textColor)
                    .cornerRadius(50)
            }
        }
}

//#Preview {
//    CustomButton()
//}

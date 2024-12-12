//
//  InputFormView.swift
//  SalesforceDemo
//
//  Modified by Harshad Sawant on 13/12/24.
//

import SwiftUI


struct InputFormView: View {
    @Binding var text: String
        let title: String
        let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
                   Text(title)
                .foregroundColor(Color.black)
                .fontWeight(.regular)
                       .font(.footnote)
                   
                   TextField(placeholder, text: $text)
                       .font(.system(size: 14))
                       .padding(12)
                       .autocapitalization(.none)
                       .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color.gray, lineWidth: 1)
                       )
                   
               }
               .padding(.vertical, 4)
    }
}

#Preview {
    InputFormView(text: .constant(""), title: "Email Address",placeholder:"name@example.com")
}

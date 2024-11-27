//
//  TimeOffTypePicker.swift
//  SalesforceDemo
//
//  Created by Ankit Kishor on 18/11/24.
//

import SwiftUI

struct TimeOffTypePicker: View {
   

    let title: String
        let options: [String]
        @Binding var selectedOption: String

        var body: some View {
           
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.footnote)
                
                
                
                HStack {
                    Text(selectedOption)

                        .font(.system(size: 14))
                    Spacer()
                    Menu {
                        ForEach(options, id: \.self) { option in
                            Button(action: {
                                selectedOption = option
                            }) {
                                Text(option)
                            }
                        }
                        
                    }
                    label: {
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                }
                
                .padding(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                
                
                
            }
                
           
        }
}



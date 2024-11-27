//
//  CheckBox.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 26/11/24.
//

import SwiftUI

struct CheckBox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack{
            Rectangle()
                .fill(configuration.isOn ? Color.blue : Color.white)
                .frame(width: 20, height: 20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                                .overlay(
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .opacity(configuration.isOn ? 1 : 0)
                                )
                                .onTapGesture {
                                    configuration.isOn.toggle()
                                }
                            
                            // Label
                            configuration.label
                                .font(.system(size: 16))
                                .foregroundColor(.black)
        }
    }
}



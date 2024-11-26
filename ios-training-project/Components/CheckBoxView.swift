//
//  CheckBoxView.swift
//

import SwiftUI

struct CheckBoxView: View {
    
    @State var isChecked: Bool = false
    
    var body: some View {
        Toggle(isOn: $isChecked){
            Text("Half Day")
                .foregroundColor(.black)
        }
        .toggleStyle(CheckBoxToggleStyle())
    }
}


struct CheckBoxToggleStyle: ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack{
                configuration.label
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(configuration.isOn ? .white : .primary)
                    .background(configuration.isOn ? Color(#colorLiteral(red: 0.4945544004, green: 0.5274094939, blue: 0.9649876952, alpha: 1)) : Color.clear)
                    .cornerRadius(4)
            }
        }
        .disabled(true)
    }
}

#Preview {
    CheckBoxView(isChecked: true)
}

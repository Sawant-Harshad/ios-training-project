//
//  TableHeaderView.swift
//

import SwiftUI

struct TableHeaderView: View {
    var body: some View {
        HStack {
            HeaderTitle(title: "Time Off Id")
            HeaderTitle(title: "Period")
            HStack{
                
                HeaderTitle(title: "Details")
            }
           
        }
        .padding()
        .background(Color.clear)
    }
}


struct HeaderTitle: View{
    
    var title: String
    
    var body: some View {
        Text("\(title)")
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leadingLastTextBaseline)
//            .padding()
//            .border(.red)
    }
}

#Preview {
    TableHeaderView()
}

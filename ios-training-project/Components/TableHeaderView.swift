//
//  TableHeaderView.swift
//

import SwiftUI

struct TableHeaderView: View {
    var body: some View {
        HStack {
            HeaderTitle(title: "Time Off Id")
            HeaderTitle(title: "Period")
            HeaderTitle(title: "Details")
        }
        .padding(.horizontal)
        .background(Color.clear)
    }
}


struct HeaderTitle: View{
    
    var title: String
    
    var body: some View {
        Text("\(title)")
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.vertical,5)
//            .border(.red)
    }
}

#Preview {
    TableHeaderView()
}

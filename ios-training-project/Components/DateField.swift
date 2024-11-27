//
//  DateField.swift
//  SalesforceDemo
//
//  Created by Ankit Kishor on 25/11/24.
//

import SwiftUI

struct DateField: View {
    var label: String
       @Binding var selectedDate: Date
       
       var body: some View {
           VStack(alignment: .leading, spacing: 4) {
               Text(label)
                   .font(.footnote)
               DatePicker("", selection: $selectedDate, displayedComponents: .date)
                   .labelsHidden()
                   .padding(8)
                   .background(Color(UIColor.systemGray6))
                   .cornerRadius(8)
           }
       }
}



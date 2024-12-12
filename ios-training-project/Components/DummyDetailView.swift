//
//  DummyDetailView.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 12/12/24.
//

import SwiftUI
import CoreData

struct DummyDetailView: View {
    
    var timeOffDetail: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 9) {
                // Header
                HStack {
                    Image(systemName: "arrow.left")
                        .frame(alignment: .leading)
                        .onTapGesture {
                            dismiss()
                        }
                    
                    Text("Time Off Request Details")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal)
                
                // Form
                VStack(spacing: 20) {
                    InputFormView(text: .constant(timeOffDetail), title: "Request ID", placeholder: "")
                        .disabled(true)
                    
//                    InputFormView(text: .constant(timeOffDetail.startDate), title: "Start Date", placeholder: "")
//                        .disabled(true)
//
//                    InputFormView(text: .constant(timeOffDetail.endDate), title: "End Date", placeholder: "")
//                        .disabled(true)
//
//                    InputFormView(text: .constant(timeOffDetail.timeOffType), title: "Type", placeholder: "")
//                        .disabled(true)
//
//                    Toggle("Half Day", isOn: .constant(timeOffDetail.isHalfDay))
//                        .disabled(true)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    DummyDetailView(timeOffDetail: "Time Off Detail")
}

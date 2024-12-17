//
//  DummyDetailView.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 12/12/24.
//

import SwiftUI
import CoreData

struct DummyDetailView: View {
    
    var timeOffDetail: TimeOff
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
                    InputFormView(text: .constant(timeOffDetail.id?.uuidString ?? "UUID"), title: "Request ID", placeholder: "")
                        .disabled(true)
                    
                    InputFormView(text: .constant(formatDate(timeOffDetail.startDate!)), title: "Start Date", placeholder: "")
                        .disabled(true)
                    
                    InputFormView(text: .constant(formatDate(timeOffDetail.endDate!)), title: "End Date", placeholder: "")
                        .disabled(true)
                    
                    InputFormView(text: .constant(timeOffDetail.timeOffType!), title: "Type", placeholder: "")
                        .disabled(true)
                    
                    Toggle("Half Day", isOn: .constant(timeOffDetail.isHalfDay))
                        .disabled(true)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    if let attachmentsSet = timeOffDetail.attachments {
                        // Safely cast allObjects to [Attachment] and use it in the List
                        let attachments = attachmentsSet.allObjects as? [Attachment] ?? []
                        
                        if attachments.isEmpty {
                            Text("No attachments available")
                                .font(.caption)
                        } else {
                            ForEach(attachments) { fileData in
                                Text(fileData.fileName ?? "No file")
                                    .font(.caption)
                            }
                            
                        }
                    } else {
                        // If attachmentsSet is nil, handle the empty case
                        Text("No attachments")
                            .font(.caption)
                    }
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}

#Preview {
    
    let context = PersistenceController.shared.container.viewContext
    
    let user1 = User(context: context)
    user1.email = "abc@email.com"
    user1.password = "abc123"
    user1.username = "ABC"
    
    let data1 = TimeOff(context: context)
    data1.id = UUID()
    data1.timeOffType = TimeOffType.allCases.randomElement()?.rawValue
    data1.holidayName = "Leave-01"
    data1.startDate = Date()
    data1.endDate = Date()
    data1.isHalfDay = Bool.random()
    data1.creationDate = Date()
    data1.user = user1
    
    return DummyDetailView(timeOffDetail: data1)
}

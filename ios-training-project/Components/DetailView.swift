//
//  DummyDetailView.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 12/12/24.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    var timeOffDetail: TimeOff
    @Environment(\.dismiss) private var dismiss
    @State private var userData: UserSession? = nil
    
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
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
                VStack(spacing: 15) {
                    
                    
                    
                    InputFormView(text: .constant(userData?.userUserName ??  "User name"), title: "Person", placeholder: "")
                        .disabled(true)
                    
                    
                    
                    
                    InputFormView(text: .constant(timeOffDetail.timeOffType!), title: "TimeOffType", placeholder: "")
                        .disabled(true)
                    
                    
                    InputFormView(text: .constant(timeOffDetail.holidayName!), title: "Description", placeholder: "")
                        .disabled(true)
                    
                    HStack(spacing:15){
                        InputFormView(text: .constant(formatDate(timeOffDetail.startDate!)), title: "Start Date", placeholder: "")
                            .disabled(true)
                        
                        InputFormView(text: .constant(formatDate(timeOffDetail.endDate!)), title: "End Date", placeholder: "")
                        
                            .disabled(true)
                        
                    }
                    
                    Toggle(isOn:.constant(timeOffDetail.isHalfDay)){
                        Text("Half Day")
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .toggleStyle(CheckBox())
                    .disabled(true)
                }
                .padding()
                
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal)
                
                
                
                
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Notes & Attachments")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    if let attachmentsSet = timeOffDetail.attachments {
                        let attachments = attachmentsSet.allObjects as? [Attachment] ?? []
                        
                        if attachments.isEmpty {
                            Text("No attachments available")
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            VStack(spacing: 10) {
                                ForEach(attachments) { fileData in
                                    HStack {
                                        
                                        Text(fileData.fileName ?? "No file")
                                            .font(.body)
                                            .foregroundColor(.black)
                                        
                                        Spacer()
                                        
                                        
                                        
                                    }
                                    .padding(10)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                }
                            }
                        }
                    } else {
                        Text("No attachments")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                
                
                //                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
        .onAppear(){
            if let userData = UserSession.loadFromDefaults() {
                self.userData = userData
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
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
    
    // Adding sample attachments
    let attachment1 = Attachment(context: context)
    attachment1.fileName = "Report.pdf"
    let attachment2 = Attachment(context: context)
    attachment2.fileName = "Invoice.png"
    let attachment3 = Attachment(context: context)
    attachment3.fileName = "Document.docx"
    
    data1.attachments = [attachment1, attachment2, attachment3] // Set the attachments
    
    return DetailView(timeOffDetail: data1)
}


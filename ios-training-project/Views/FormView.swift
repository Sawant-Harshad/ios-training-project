//
//  FormView.swift
//  SalesforceDemo
//
//  Created by Ankit Kishor on 13/11/24.
//

import SwiftUI
import UniformTypeIdentifiers


struct FormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    let persistenceController = PersistenceController.shared
    
    let timeOffTypes: [String] = TimeOffType.allCases.map{ $0.rawValue }
    
    @State private var userData: UserSession? = nil
    
    @State private var timeOffType: String = TimeOffType.paid.rawValue
    @State private var holidayName: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()
    @State private var isHalfDay: Bool = false
    
    @State private var isFileImporterPresented = false
    @State private var attachments: [Attachment] = []
    
    @State private var errorMessage:String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 9) {
                // header part
                HStack {
                    
                    Image(systemName: "arrow.left")
                        .frame(alignment: .leading)
                        .onTapGesture {
                            print("Back")
                            dismiss()
                            
                        }
                    
                    Text("New Time Off Request")
                        .font(.headline)
                        .frame(maxWidth:.infinity,alignment: .center)
                    
                }
                .padding(.horizontal)
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal)
                
                
                
                // Form start here
                
                VStack( spacing: 20) {
                    // person field (non-editable have to make)
                    VStack(spacing: 15){
                        //                        InputFormView(text: user.username, title: "Person", placeholder: "User name")
                        //                            .autocapitalization(.none)
                        
                        Text(userData?.userUserName ?? "User name")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        
                        // timeOff field
                        TimeOffTypePicker(
                            title: "Time Off Type",
                            options:timeOffTypes,
                            selectedOption: $timeOffType
                        )
                        
                        // holiday field
                        InputFormView(text: $holidayName, title: "Holiday Name", placeholder: "Holiday Name")
                        
                        
                        
                        //date field
                        HStack(spacing: 16) {
                            DateField(label: "Start Date", selectedDate: $startDate)
                            Spacer()
                            DateField(label: "End Date", selectedDate: $endDate)
                        }
                        
                        // halfDay checkbox
                        Toggle(isOn:$isHalfDay){
                            Text("Half Day")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .toggleStyle(CheckBox())
                        
                    }
                }
                
                .padding()
                
                //form end here...remember
                
                //=--------------------------------------
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal)
                
                //=---- File Upload --------------------
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Notes & Attachments")
                        .font(.subheadline)
                    
                    Button(action: {
                        isFileImporterPresented.toggle()
                    }) {
                        VStack {
                            Image(systemName: "icloud.and.arrow.up")
                                .font(.system(size: 40))
                                .foregroundColor(Color.purple)
                            Text("Browse File")
                                .font(.headline)
                                .padding()
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                    }
                    
                    //                    if let selectedFile = timeOffRequest.selectedFile {
                    //                        Text("Selected File: \(selectedFile.lastPathComponent)")
                    //                            .font(.footnote)
                    //                            .foregroundColor(.gray)
                    //                    }
                    
                    ForEach(attachments, id: \.fileUrl) { fileData in
                        Text(fileData.fileName ?? "Unknown file")
                    }
                    
                }
                .padding()
                
                
                // Action Buttons
                HStack(spacing: 16) {
                    CustomButton(title: "Cancel", action: {
                        dismiss()
                    }, backgroundColor: .purple)
                    CustomButton(title: "Save & New", action: {}, backgroundColor: .purple)
                    
                    CustomButton(title: "Save", action: {
                        saveData(user: userData!)
                    }, backgroundColor: .purple)
                }
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                .padding()
                
            }
            .fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.pdf, .image]) { result in
                switch result {
                case .success(let url):
                    addAttachment(url: url)
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    showError = true
                }
                isFileImporterPresented = false
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            if let userData = UserSession.loadFromDefaults() {
                self.userData = userData
            }
        }
    }
    
    //=----------------------------------------------------------------------
    private func addAttachment(url: URL) {
        let newFileData = Attachment(context: viewContext)
        newFileData.fileUrl = url.absoluteString  // Store URL as a string
        newFileData.fileName = url.lastPathComponent
        newFileData.fileType = UTType(url.absoluteString)?.identifier ?? "Unknown type"
        newFileData.fileUploadDate = Date()
        
        
        print(newFileData)
        
        attachments.append(newFileData)
    }
    
    
    private func saveData(user: UserSession) {
        let context = viewContext
        
        let user = User(context: context)
        user.email = userData?.userEmail
        user.password = userData?.userPassword
        user.username = userData?.userUserName
        
        let newData = TimeOff(context: context)
        newData.id = UUID()
        newData.timeOffType = timeOffType
        newData.holidayName = holidayName
        newData.startDate = startDate
        newData.endDate = endDate
        newData.isHalfDay = isHalfDay
        newData.creationDate = Date()
        newData.user = user
        newData.addToAttachments(NSSet(array: attachments))
        
        
        print(newData)
        
        // Save to Core Data
        do{
            try context.save()
        }catch{
            print("Error saving data : \(error.localizedDescription)")
        }
        
        // Dismiss the AddDataView and return to the HomeView
        dismiss()
    }
    
}


#Preview {
    FormView()
}

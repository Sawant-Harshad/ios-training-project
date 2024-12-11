//
//  FormView.swift
//  SalesforceDemo
//
//  Created by Ankit Kishor on 13/11/24.
//

import SwiftUI

struct FormView: View {
    @State private var timeOffRequest = TimeOffRequest()
    let timeOffTypes = ["Paid Time Off", "Unpaid Time Off", "Sick Leave"]
    @Environment(\.dismiss) var dismiss
    
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
                        InputFormView(text: $timeOffRequest.username, title: "Person", placeholder: "Ankit Kishor")
                            .autocapitalization(.none)
                        
                        
                        // timeOff field
                        TimeOffTypePicker(
                            title: "Time Off Type",
                            options:timeOffTypes,
                            selectedOption: $timeOffRequest.selectedTimeOffType
                        )
                        
                        // holiday field
                        InputFormView(text: $timeOffRequest.holidayName, title: "Description", placeholder: "Enter Description")
                        
                        
                        
                        //date field
                        HStack(spacing: 16) {
                            DateField(label: "Start Date", selectedDate: $timeOffRequest.startDate)
                            Spacer()
                            DateField(label: "End Date", selectedDate: $timeOffRequest.endDate)
                        }
                        
                        // halfDay checkbox
                        Toggle(isOn:$timeOffRequest.isHalfDay){
                            Text("Half Day")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .toggleStyle(CheckBox())
                        
                    }
                }
                
                .padding()
                
                //form end here...remember
                
                Divider()
                    .background(Color.black)
                    .padding(.horizontal)
                //=--------------------------------------
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Notes & Attachments")
                        .font(.subheadline)
                    
                    Button(action: {
                        timeOffRequest.showFilePicker.toggle()
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
                    if let selectedFile = timeOffRequest.selectedFile {
                        Text("Selected File: \(selectedFile.lastPathComponent)")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                
                // Action Buttons
                HStack(spacing: 16) {
                    CustomButton(title: "Cancel", action: {}, backgroundColor: .purple)
                    CustomButton(title: "Save & New", action: {}, backgroundColor: .purple)
                    
                    CustomButton(title: "Save", action: {}, backgroundColor: .purple)
                }
                .minimumScaleFactor(0.8)
                .lineLimit(1)
                .padding()
                
            }
            .fileImporter(isPresented: $timeOffRequest.showFilePicker, allowedContentTypes: [.pdf, .image]) { result in
                switch result {
                case .success(let url):
                    timeOffRequest.selectedFile = url
                case .failure(let error):
                    timeOffRequest.errorMessage = error.localizedDescription
                    timeOffRequest.showError = true
                }
            }
            .alert(isPresented: $timeOffRequest.showError) {
                Alert(title: Text("Error"), message: Text(timeOffRequest.errorMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    FormView()
}

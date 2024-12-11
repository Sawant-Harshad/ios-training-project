// DetailView.swift

import SwiftUI

//struct DummyDetailView: View {
//    
//    @State var timeOffDetail: TimeOffData
//    
//    var body: some View {
//        VStack {
//            Text("Time Off Details")
//                .font(.largeTitle)
//                .padding()
//            Text(timeOffDetail.timeOffId)
//                .padding()
//            Text(timeOffDetail.startDate)
//            Text(timeOffDetail.endDate)
//                .padding()
//            Text(timeOffDetail.type)
//                .padding()
//            CheckBoxView(isChecked: $timeOffDetail.isHalfDay)
//            
//        }
//    }
//}

struct DummyDetailView: View {
    @State var timeOffDetail: TimeOffData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 9) {
                // Header
                HStack {
                    Image(systemName: "arrow.left")
                        .frame(alignment: .leading)
                        .onTapGesture { dismiss() }
                    
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
                    InputFormView(text: .constant(timeOffDetail.timeOffId), title: "Request ID", placeholder: "")
                        .disabled(true)
                    
                    InputFormView(text: .constant(timeOffDetail.startDate), title: "Start Date", placeholder: "")
                        .disabled(true)
                    
                    InputFormView(text: .constant(timeOffDetail.endDate), title: "End Date", placeholder: "")
                        .disabled(true)
                    
                    InputFormView(text: .constant(timeOffDetail.type), title: "Type", placeholder: "")
                        .disabled(true)
                    
                    Toggle("Half Day", isOn: .constant(timeOffDetail.isHalfDay))
                        .disabled(true)
                }
                .padding()
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


#Preview{
    var timeOff = sampleData.randomElement()
    DummyDetailView(timeOffDetail: timeOff!)
    //    DummyTestView()
}

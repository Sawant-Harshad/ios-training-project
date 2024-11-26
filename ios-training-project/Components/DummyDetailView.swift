// DetailView.swift

import SwiftUI

struct DummyDetailView: View {
    
    @State var timeOffDetail: TimeOffData
    
    var body: some View {
        VStack {
            Text("Time Off Details")
                .font(.largeTitle)
                .padding()
            Text(timeOffDetail.timeOffId)
                .padding()
            Text(timeOffDetail.startDate)
            Text(timeOffDetail.endDate)
                .padding()
            Text(timeOffDetail.type)
                .padding()
            CheckBoxView(isChecked: timeOffDetail.isHalfDay)
            
        }
    }
}

#Preview{
    var timeOff = sampleData.randomElement()
    DummyDetailView(timeOffDetail: timeOff!)
    //    DummyTestView()
}

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
            Text(timeOffDetail.startDate)
            Text(timeOffDetail.endDate)
            Text(timeOffDetail.type)
            CheckBoxView(isChecked: timeOffDetail.isHalfDay)
            
        }
    }
}

#Preview{
    var timeOff = sampleData.randomElement()
    DummyDetailView(timeOffDetail: timeOff!)
    //    DummyTestView()
}

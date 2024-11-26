//
//  TestData.swift
//

import Foundation

struct TimeOffData : Identifiable{
    
    let id = UUID()
    let timeOffId: String
    let startDate: String
    let endDate: String
    let type: String
    let isHalfDay: Bool
    
}

let sampleData: [TimeOffData] = [
    
    TimeOffData(timeOffId: "TF-000012", startDate: "10/21/2024", endDate: "10/21/2024", type: "Un-Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000011", startDate: "10/9/2024", endDate: "10/9/2024", type: "Paid",isHalfDay: true),
    TimeOffData(timeOffId: "TF-000010", startDate: "10/2/2024", endDate: "10/2/2024", type: "Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000009", startDate: "9/22/2024", endDate: "9/25/2024", type: "Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000008", startDate: "9/21/2024", endDate: "9/21/2024", type: "Un-Paid",isHalfDay: true),
    TimeOffData(timeOffId: "TF-000007", startDate: "8/15/2024", endDate: "8/15/2024", type: "Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000006", startDate: "6/17/2024", endDate: "6/17/2024", type: "Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000005", startDate: "6/6/2024", endDate: "6/6/2024", type: "Paid",isHalfDay: true),
    TimeOffData(timeOffId: "TF-000004", startDate: "5/14/2024", endDate: "5/16/2024", type: "Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000003", startDate: "4/16/2024", endDate: "4/16/2024", type: "Paid",isHalfDay: false),
    TimeOffData(timeOffId: "TF-000002", startDate: "4/4/2024", endDate: "4/4/2024", type: "Paid",isHalfDay: true),
    TimeOffData(timeOffId: "TF-000001", startDate: "3/4/2024", endDate: "3/4/2024", type: "Paid",isHalfDay: false)
]


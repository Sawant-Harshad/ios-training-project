//
//  TimeOffType.swift
//  ios-training-project
//
//  Created by Harshad Sawant on 12/12/24.
//

import Foundation

enum TimeOffType: String, CaseIterable {
    case paid = "Paid"
    case unpaid = "Unpaid"
}


extension TimeOffType : Identifiable{
    var id: String { self.rawValue }
}

//
//  TimeOffRequest.swift
//  ios-training-project
//
//  Created by Ankit Kishor on 26/11/24.
//

import Foundation
struct TimeOffRequest{
     var selectedTimeOffType = "Paid Time Off"
    var username = ""
        var holidayName = ""
        var startDate = Date()
       var endDate = Date()
         var isHalfDay = false
         var showFilePicker = false
         var selectedFile: URL? = nil
         var showError = false
      var errorMessage = ""
}

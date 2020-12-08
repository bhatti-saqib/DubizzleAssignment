//
//  Helper.swift
//  DubizzleTest
//
//  Created by Saqib Bhatti on 08/12/2020.
//

import Foundation
import UIKit

class Helper: NSObject {
    
    class func getFormattedDate(_ dateString: String?) -> String? {
        let dateFormat = DateFormatter()
        
        dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = dateFormat.date(from: dateString ?? "")

        dateFormat.dateFormat = "EEEE MMMM d, YYYY"
        var dateStr: String? = nil
        if let date = date {
            dateStr = dateFormat.string(from: date)
            return dateStr
        }
        else {
            return nil
        }
    }
}

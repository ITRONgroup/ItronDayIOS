//
//    Global Functions.swift
//  itronDay
//
//  Created by Сережа on 16.03.2022.
//

import UIKit

extension Date {
    
    static func getTodaysDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
}

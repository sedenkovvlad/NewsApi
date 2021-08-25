//
//  ConverterDate.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation
import UIKit

class ConverterDate{
    
    static let shared = ConverterDate()
    
    func formatDateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        if Calendar.current.isDateInToday(date) {
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: date)
        }
        
        if Calendar.current.isDateInYesterday(date) {
            return "Вчера"
        }
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func formatDate(from date: String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: date)
    }
    
}

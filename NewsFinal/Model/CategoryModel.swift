//
//  Category.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 24.08.2021.
//

import Foundation

enum Category: String, CaseIterable{
    
    case general
    case business
    case entertainment
    case health
    case science
    case sports
    case technology
    
    var systemImage: String {
        switch self {
        case .general:
            return "newspaper"
        case .business:
            return "dollarsign.square"
        case .entertainment:
            return "film"
        case .health:
            return "lungs"
        case .science:
            return "graduationcap"
        case .sports:
            return "sportscourt"
        case .technology:
            return "desktopcomputer"
        }
    }
}

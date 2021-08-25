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
    
    var api: String{
        switch self{
        case .general:
            return "https://newsapi.org/v2/top-headlines?country=ru&apiKey=75325cb36fdb473abcb269dc04991c40"
        case .business:
            return "https://newsapi.org/v2/top-headlines?country=ru&category=business&apiKey=75325cb36fdb473abcb269dc04991c40"
        case .entertainment:
            return "https://newsapi.org/v2/top-headlines?country=ru&category=entertainment&apiKey=75325cb36fdb473abcb269dc04991c40"
        case .health:
            return "https://newsapi.org/v2/top-headlines?country=ru&category=health&apiKey=75325cb36fdb473abcb269dc04991c40"
        case .science:
            return "https://newsapi.org/v2/top-headlines?country=ru&category=science&apiKey=75325cb36fdb473abcb269dc04991c40"
        case .sports:
            return "https://newsapi.org/v2/top-headlines?country=ru&category=sports&apiKey=75325cb36fdb473abcb269dc04991c40"
        case .technology:
            return "https://newsapi.org/v2/top-headlines?country=ru&category=technology&apiKey=75325cb36fdb473abcb269dc04991c40"
        }
    }
}

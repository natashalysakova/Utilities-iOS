//
//  Theme.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import SwiftUI

enum Theme : Int, CaseIterable, Identifiable, Codable {
    case January = 1
    case February = 2
    case March = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
    
    var id: Int {
        rawValue
    }
    
    var accentColor : Color{
        switch self {
        case .January, .February, .March, .April, .May, .July, .September, .October: return .black
        case .August, .November, .June, .December: return .white
        }
    }
    
    var name : String{
        Calendar.current.monthSymbols[rawValue-1]
    }
    
    var mainColor : Color{
        Color(String(rawValue))
    }
}

//
//  UtilityType.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import SwiftUI

enum UtilityType : Int, Codable, CaseIterable {
    case HotWater = 0
    case ColdWater = 1
    case Heating = 2
    case Electricity = 3
    case TrashService = 4
    case Security = 5
    case Internet = 6
    case Other = 7
    case Gas = 8
    
    var localizedName : String {
            return NSLocalizedString(name, comment: "")
    }
    
    public var name : String {
        switch self {
        case .HotWater:
            return "HotWater"
        case .ColdWater:
            return "ColdWater"
        case .Heating:
            return "Heating"
        case .Electricity:
            return "Electricity"
        case .TrashService:
            return "TrashService"
        case .Security:
            return "Security"
        case .Internet:
            return "Internet"
        case .Other:
            return "Other"
        case .Gas:
            return "Gas"
        }
    }
    
    public var icon : String {
        switch self {
        case .HotWater, .ColdWater :
            return "drop.fill"
        case .Heating, .Gas:
            return "flame.fill"
        case .Electricity:
            return "bolt.fill"
        case .TrashService:
            return "trash.fill"
        case .Security:
            return "lock.fill"
        case .Internet:
            return "network"
        case .Other:
            return "bag.fill"
        }
    }
    
    
    public var color : Color{
        return Color(self.name)
    }
    
    static public var allValues : [UtilityType] {
        [ UtilityType.HotWater, UtilityType.ColdWater, UtilityType.Heating, UtilityType.Electricity, UtilityType.Gas, UtilityType.TrashService, UtilityType.Security, UtilityType.Internet,  UtilityType.Other]
    }
}



/*
 HotWater = 0,
 ColdWater = 1,
 Heating = 2,
 Electricity = 3,
 TrashService = 4,
 Security = 5,
 Internet = 6,
 Other = 7
 */

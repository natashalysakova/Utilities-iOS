//
//  Tariff.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import SwiftUI

struct Tariff : Identifiable, Codable {
    
    let id : Int
    var utility : Utility
    var startDate : Date
    var endDate : Date?
    var cost : Decimal
    var isActive : Bool
    
    private enum CodingKeys : String, CodingKey{
        case id = "Id", utility = "Type", startDate = "StartDate", endDate = "EndDate", cost = "Cost", isActive = "IsActive"
    }
}


extension Tariff {
    
    static let sampleData : [Tariff] = [
        Tariff(id: 0, utility: Utility.sampleData[0], startDate: Date(), cost: 120, isActive: true),
        Tariff(id: 1, utility: Utility.sampleData[1], startDate: Date(), cost: 50, isActive: true),
        Tariff(id: 2, utility: Utility.sampleData[2], startDate: Date(), cost: 22, isActive: true),
        Tariff(id: 3, utility: Utility.sampleData[3], startDate: Date(), cost: 4.2, isActive: true),
        Tariff(id: 4, utility: Utility.sampleData[0], startDate: Date(), cost: 120, isActive: false),
        Tariff(id: 5, utility: Utility.sampleData[1], startDate: Date(), cost: 50, isActive: false),
        Tariff(id: 6, utility: Utility.sampleData[2], startDate: Date(), cost: 22, isActive: false),
        Tariff(id: 7, utility: Utility.sampleData[3], startDate: Date(), cost: 4.2, isActive: false)
    ]
    
    public var color : Color {
        if(isActive) {
            return .green
        }
        return Color("ListBackground")
    }
    
    public var textColor : Color {
        if(isActive) {
            return .white
        }
        //return Color("ListText")
        return .gray
    }
}
/*
public int Id { get; set; }
public UtilityType Type { get; set; }
public DateTime StartDate { get; set; }
public DateTime? EndDate { get; set; }
public decimal Cost { get; set; }
public bool IsActive { get; set; }
 */

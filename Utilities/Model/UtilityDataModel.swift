//
//  UtilityDataModel.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import SwiftUI

struct UtilityDataModel : Codable {
    
    var tariffs : [Tariff] = []
    var checks : [Check] = []
    var utilities : [Utility] = []
 
    private enum CodingKeys : String, CodingKey {
        case tariffs = "Tarifs", checks = "Checks", utilities = "UtilityTypes"
    }
    
    mutating func validate(){
        for i in checks.indices{

            if checks[i].id == nil{
                checks[i].id = UUID()
            }

            for j in  checks[i].records.indices{
                if checks[i].records[j].id == nil{
                    checks[i].records[j].id = UUID()
                }
            }
        }
    }

    public func Grouped() -> Dictionary<String, [Utility]> {
        return Dictionary(grouping: utilities) { u in
            u.utilityType.localizedName
        }
    }
}

extension UtilityDataModel {
    public static var sampleData: UtilityDataModel {
        UtilityDataModel(tariffs: Tariff.sampleData, checks: Check.sampleData, utilities: Utility.sampleData)
    }
}

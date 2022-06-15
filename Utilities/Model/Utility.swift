//
//  Utility.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation

class Utility : Identifiable, Codable {
    
    internal init(id: Int, name: String, utilityType: UtilityType, units: String, order: Int, useMeters: Bool, useMesures : Bool) {
        self.id = id
        self.name = name
        self.utilityType = utilityType
        self.units = units
        self.order = order
        self.useMeters = useMeters
        self.useMesures = useMesures
    }

    
    init(from: Utility) {
        self.id = from.id
        self.name = from.name
        self.utilityType = from.utilityType
        self.units = from.units
        self.order = from.order
        self.useMeters = from.useMeters
        self.useMesures = from.useMesures
    }
    
    func update(from: Utility.Data) {
        self.name = from.name
        self.utilityType = from.utilityType
        self.units = from.units
        self.order = from.order
        self.useMeters = from.useMeters
        self.useMesures = from.useMesures
    }
    
    
    let id : Int
    var name : String
    var utilityType : UtilityType
    var units : String?
    var order : Int
    var useMesures : Bool
    var useMeters : Bool
    
    var data : Data{
        Data(id: id, name: name, utilityType: utilityType, units: units ?? "", order: order, useMesures: useMesures, useMeters: useMeters)
    }
    
    private enum CodingKeys : String, CodingKey{
        case id = "Id", name = "Name", utilityType = "Type", units = "Units", order = "Order", useMesures = "UseMesures", useMeters = "UseMeters"
    }
    
    
    struct Data {
        var id = -1
        var name = ""
        var utilityType : UtilityType = .Other
        var units = ""
        var order = -1
        var useMesures = true
        var useMeters = false
    }
    
}

extension Utility {
    static let sampleData : [Utility] = [
        Utility(id: 0, name: "Hot Water", utilityType: .HotWater, units: "m2", order: 0, useMeters: true, useMesures: false),
        Utility(id: 1, name: "Cold Water", utilityType: .ColdWater, units: "m2", order: 1, useMeters: true, useMesures: false),
        Utility(id: 2, name: "Electricity", utilityType: .Electricity, units: "kw\\h", order: 2, useMeters: true, useMesures: false),
        Utility(id: 3, name: "Heating", utilityType: .Heating, units: "", order: 3, useMeters: false, useMesures: true)
    ]
}
/*
 public int Id { get; set; }
 public string Name { get; set; }
 public Utility Type { get; set; }
 public string Units { get; set; }
 public int Order { get; set; }
 public bool UseMesures { get; set; }
 public bool UseMeters { get; set; }
 */

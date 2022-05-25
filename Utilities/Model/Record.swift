//
//  Record.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import CoreImage

struct Record : Identifiable, Codable {
    
    var id : UUID? = UUID()
    var tariff : Tariff
    var previousValue : Decimal
    
    
    var meters : Decimal
    
    var measure : Decimal
    var cost : Decimal
    
    var costText : String {
        NumberFormatter.uah.string(from: cost as NSNumber) ?? "?"
    }
    
    private enum CodingKeys : String, CodingKey{
        case id = "Id", tariff = "Tariff", measure = "Measure", cost = "Cost", meters = "Meters", previousValue = "PreviousValue"
    }
}


extension Record {
    
    struct Data {
        var tarif : Tariff = Tariff.sampleData[0]
        var previousValue : Decimal = 0.0
        {
            didSet{
                measures = meters - previousValue
            }
        }
        var meters : Decimal = 0.0 {
            didSet {
                measures = meters - previousValue
            }
        }
        var measures  : Decimal = 0.0 {
            didSet{
                cost = measures * tarif.cost
            }
        }
        var cost : Decimal = 0.0
    }
    
    var data : Data{
        Data(tarif: tariff, previousValue: previousValue, meters: meters, measures: measure, cost: cost)
    }
    
    static let sampleData : [Record] = [
        Record(tariff: Tariff.sampleData[0], previousValue: 43, meters: 45, measure: 0, cost: 0),
        Record(tariff: Tariff.sampleData[1], previousValue: 23, meters: 22, measure: 0, cost: 0),
        Record(tariff: Tariff.sampleData[2], previousValue: 224, meters: 252, measure: 0, cost: 0),
        Record(tariff: Tariff.sampleData[3], previousValue: 0, meters: 0, measure: 23, cost: 0),
    ]
}

/*
 public Tariff Tariff { get; set; }
 public decimal Measure { get => measure; set { measure = value; ReCalculate(); } }
 public decimal Meters { get => meters; set { meters = value; ReCalculate(); } }
 
 public decimal Cost { get => cost; set { cost = value; OnPropertyChanged(nameof(Cost)); } }
 
 */

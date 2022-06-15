//
//  Check.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import SwiftUI

class Check : Identifiable, Codable {
    internal init(id: UUID? = UUID(), date: Date, sum: Decimal, records: [Record]) {
        self.id = id
        self.date = date
        self.sum = sum
        self.records = records
    }
    
    
    var id : UUID? = UUID()
    var date : Date
    var theme : Theme{
        Theme(rawValue: Calendar.current.component(.month, from: date))!
    }
    
    var sum : Decimal
    
    var sumText : String {
        NumberFormatter.uah.string(for: sum) ?? "?"
    }
    var records : [Record]
    
    private enum CodingKeys : String, CodingKey{
        case id = "Id", date = "Date", sum = "Sum", records = "Records"
    }
}


extension Check{
    
    struct Data {
        var date = Date()
        var sum : Decimal = 0.0
        var records : [Record] = []
    }
    
    var data : Data {
        Data(date: date, sum: sum, records: records)
    }
    
    static let sampleData : [Check] = [
        Check(id: UUID(), date: Date(), sum: 124, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -1), sum: 4312, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -2), sum: 32, records: Record.sampleData),
        Check(id: UUID(), date: Date(), sum: 124, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -1), sum: 4312, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -2), sum: 32, records: Record.sampleData),
        Check(id: UUID(), date: Date(), sum: 124, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -1), sum: 4312, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -2), sum: 32, records: Record.sampleData),
        Check(id: UUID(), date: Date(), sum: 124, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -1), sum: 4312, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -2), sum: 32, records: Record.sampleData),
        Check(id: UUID(), date: Date(), sum: 124, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -1), sum: 4312, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -2), sum: 32, records: Record.sampleData),
        Check(id: UUID(), date: Date(), sum: 124, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -1), sum: 4312, records: Record.sampleData),
        Check(id: UUID(), date: AddMonth(date: Date(), month: -2), sum: 32, records: Record.sampleData)
    ]
    
    private static func AddMonth(date : Date, month : Int) -> Date {
        Calendar.current.date(byAdding: .month, value: month, to: date)!
    }
    
    func SortedRecords() -> [Record] {
        records.sorted(by: { one, two in
            one.tariff.utility.order < two.tariff.utility.order
        })
    }
}

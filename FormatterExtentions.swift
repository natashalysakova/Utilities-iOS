//
//  FormatterExtentions.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
    
    static let shortDate : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
    
    static let monthAndYear : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        return formatter
    }()
}


extension NumberFormatter {
  static let uah: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.maximumFractionDigits = 2
      formatter.minimumFractionDigits = 2
      formatter.currencyCode = "UAH"
      formatter.numberStyle = .currency
      return formatter
  }()
}

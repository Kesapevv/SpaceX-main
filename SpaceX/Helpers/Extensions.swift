//
//  Extensions.swift
//  SpaceX
//
//  Created by Vadim Voronkov on 11/1/22.
//

import Foundation

//MARK: - Int extension
extension Int {
   func createCurrencyString() -> String {
       let formatter = NumberFormatter()
       formatter.numberStyle = .currency
       formatter.maximumFractionDigits = 0
       return formatter.string(from: NSNumber(value: self))!
   }
}

//MARK: - String extension
extension String {
    func longDateConverter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dt = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM d, yyyy"
        let formatedStringDate = dateFormatter.string(from: dt!)
        return formatedStringDate
    }
}

extension String {
    func shortDateConverter() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dt = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM d, yyyy"
        let formatedStringDate = dateFormatter.string(from: dt!)
        return formatedStringDate
    }
}

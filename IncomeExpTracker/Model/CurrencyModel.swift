//
//  CurrencyModel.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 29/07/25.
//

import Foundation

enum CurrencyModel: CaseIterable {
    case usd, inr

    var title: String {
        switch self{
        case .usd:
            return "USD"
        case .inr:
            return "INR"
        }
    }
}

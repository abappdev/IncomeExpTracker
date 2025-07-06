//
//  TransactionType.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 29/06/25.
//

import Foundation

enum TransactionTypeModel: String, CaseIterable, Identifiable {
	case income, expense
	var id: Self { self }
	var title: String {
		switch self {
		case .income:
			return "Income"
		case .expense:
			return "Expense"
		}
	}
}

//
//  Transaction.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 29/06/25.
//

import Foundation

struct TransactionModel: Identifiable, Hashable {
	let id = UUID()
	let title: String
	let amount: Double
	let date: Date
	let type: TransactionTypeModel

	var displayDate: String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd MMM yyyy"
		return dateFormatter.string(from: date)
	}

	var displayAmount: String {
		return String(format: "%.2f", amount)
	}
}

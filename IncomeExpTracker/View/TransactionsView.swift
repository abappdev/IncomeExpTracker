//
//  TransactionsView.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 29/06/25.
//

import SwiftUI

struct TransactionItem: View {
	let transaction: TransactionModel
	var body: some View {
		HStack(spacing: 16) {
			ZStack {
				Circle()
					.fill(
						transaction.type == .expense
							? Color.red.opacity(0.12)
							: Color.green.opacity(0.12)
					)
					.frame(width: 36, height: 36)
				Image(
					systemName: transaction.type == .expense
						? "arrow.up.forward" : "arrow.down.forward"
				)
				.foregroundStyle(
					transaction.type == .expense ? .red : .green
				)
				.font(.system(size: 16, weight: .bold))
			}
			VStack(alignment: .leading, spacing: 2) {
				Text(transaction.title)
					.font(.system(size: 17, weight: .semibold))
				Text(transaction.displayDate)
					.font(.caption)
					.foregroundStyle(.secondary)
			}
			Spacer()
			Text("₹\(transaction.displayAmount )")
				.font(.system(size: 16, weight: .bold))
				.foregroundStyle(
					transaction.type == .expense ? .red : .green
				)
				.padding(.horizontal, 10)
				.padding(.vertical, 6)
				.background(
					Capsule()
						.fill(
							(transaction.type == .expense
								? Color.red : Color.green).opacity(
									0.13
								)
						)
				)
		}
	}
}


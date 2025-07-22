//
//  AddTransactionPresentationDetent.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 30/06/25.
//

import SwiftUI

struct AddTransactionPresentationDetent: View {
	
	@State private var amountEntered = 0.0
	@State private var selectedTransactionType: TransactionTypeModel = .expense
	@State private var transactionInfo = ""
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var alertOn = false
	@Binding var transactions: [TransactionModel]
	var transactionToEdit: TransactionModel?
	@Environment(\.dismiss) var dismiss

	var numberFormatter: NumberFormatter {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		return numberFormatter
	}

	var body: some View {
		VStack(alignment: .center, spacing: 6) {

			HStack(spacing: 16) {
				Text("Add Transaction")
					.font(.title2)
					.bold()
				Spacer()
				Picker(
					"Select mode",
					selection: $selectedTransactionType,
					content: {
						ForEach(TransactionTypeModel.allCases) { mode in
							Text(mode.title)
								.foregroundStyle(.red)
								.tag(mode)

						}
					}
				)
			}.padding(.all)

			HStack(spacing: 16) {
				Button(action: {
					// Decrement by 20, then round to nearest value divisible by 10
					let decremented = amountEntered - 20
					amountEntered = roundToNearestTen(decremented)
				}) {
					Image(systemName: "chevron.down.circle.fill")
						.font(.title)
				}

				TextField(
					"0.00",
					value: $amountEntered,
					formatter: numberFormatter
				)
				.font(.system(size: 40, weight: .thin))
				.keyboardType(.decimalPad)
				.multilineTextAlignment(.center)
				.frame(width: 200)
				.textFieldStyle(.roundedBorder)

				Button(action: {
					// Increment by 20, then round to nearest value divisible by 10
					let incremented = amountEntered + 20
					amountEntered = roundToNearestTen(incremented)
				}) {
					Image(systemName: "chevron.up.circle.fill")
						.font(.title)
				}
			}

			TextField("Description", text: $transactionInfo)
				.padding(.all)
				.font(.system(size: 20))
				.textFieldStyle(.roundedBorder)

			Button(
				action: {
					guard transactionInfo.count >= 2 else {
						alertTitle = "Transaction info not valid"
						alertMessage = "Update the information and try again"
						alertOn = true
						return
					}
					guard amountEntered > 0 else {
						alertTitle = "Invalid transaction amount"
						alertMessage =
							"Use Expense for spent money and Income for earned money, amount should be greater than zero."
						alertOn = true
						return
					}

					let transaction: TransactionModel = .init(
						title: transactionInfo,
						amount: amountEntered,
						date: Date(),
						type: selectedTransactionType
					)

					if let transactionToEdit = transactionToEdit {
						guard
							let indexOfEditTransaction =
								transactions.firstIndex(
									of: transactionToEdit
								)
						else {
							alertTitle = "Invalid transaction"
							alertMessage =
								"Can't find transaction to update. Please try again."
							alertOn = true
							return
						}
						transactions[indexOfEditTransaction] = transaction
					} else {
						transactions.append(transaction)
					}

					dismiss()
				},
				label: {
					Text(transactionToEdit == nil ? "Add" : "Update")
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color.accentColor)
						.foregroundStyle(.white)
						.cornerRadius(8)
				}
			)
			.padding(.horizontal)
		}
		.padding()
		.alert(
			alertTitle,
			isPresented: $alertOn
		) {
			Button(action: {
				alertOn = false
			}) {
				Text("Got it!")
			}
		} message: {
			Text(alertMessage)
		}
		.onAppear {
			if let editTransaction = transactionToEdit {
				amountEntered = editTransaction.amount
				selectedTransactionType = editTransaction.type
				transactionInfo = editTransaction.title
			}
		}
	}

	// Add a rounding helper method inside the struct (outside of 'body')
	// This ensures values are rounded to the nearest value divisible by 10
	func roundToNearestTen(_ value: Double) -> Double {
		return round(value / 10.0) * 10.0
	}
}

#Preview {
	AddTransactionPresentationDetent(
		transactions: .constant([])
	)
}

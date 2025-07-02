//
//  AddTransactionPresentationDetent.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 30/06/25.
//

import SwiftUI

struct AddTransactionPresentationDetent: View {

	@State private var amountEntered = 0.0

	var numberFormatter: NumberFormatter {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		return numberFormatter
	}

	var body: some View {
		VStack(alignment: .center, spacing: 30) {
			Text("Add Transaction")
				.font(.title2)
				.bold()
				.padding(.top)
			
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
			
			Button(
				action: {},
				label: {
					Text("Add")
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
	}

	// Add a rounding helper method inside the struct (outside of 'body')
	// This ensures values are rounded to the nearest value divisible by 10
	func roundToNearestTen(_ value: Double) -> Double {
		return round(value / 10.0) * 10.0
	}
}

#Preview {
	AddTransactionPresentationDetent()
}

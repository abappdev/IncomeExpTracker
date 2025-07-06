//
//  ContentView.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 29/06/25.
//

import SwiftUI

struct HomeView: View {

	@State private var showTransactionAddView: Bool = false
	@State private var transactionToEdit: TransactionModel?

	@State private var transactions: [TransactionModel] = []

	fileprivate func BalanceView() -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 10)
				.fill(.primaryGreen)
			VStack(alignment: .leading) {
				HStack {
					Text("Balance".uppercased())
						.font(.caption)
						.foregroundStyle(.white)
					Spacer()
				}
				.padding(.top)

				Text("₹\(1000)")
					.font(.system(size: 45, weight: .light))
					.foregroundStyle(.white)
				Spacer()
				HStack {
					Spacer()
					Image(
						systemName: "arrow.up.forward"
					)
					VStack {
						Text("Expense")
							.font(.system(size: 15, weight: .semibold))
						Text("₹1000")
					}
					Spacer()
					Image(
						systemName: "arrow.down.forward"
					)
					VStack {
						Text("Income")
							.font(.system(size: 15, weight: .semibold))
						Text("₹1000")
					}
					Spacer()

				}

			}.padding(.all)

		}
		.frame(height: 200)
		.padding(.horizontal)
	}

	var body: some View {
		NavigationStack {
			ZStack {

				List {
					// Section 0: Balance view at the top
					Section {
						BalanceView()
							.listRowSeparator(.hidden)  // Optional: cleaner look
							.listRowInsets(EdgeInsets())  // Optional: edge-to-edge
					}

					// Section 1: Transactions
					Section {
						ForEach(transactions) { transaction in
							Button(
								action: {
									transactionToEdit = transaction
									showTransactionAddView = true
								},
								label: {
									TransactionItem(transaction: transaction)
								}
							)
						}
					}
				}
				.listStyle(.plain)
				.scrollContentBackground(.hidden)

				VStack {
					Spacer()
					Button(
						action: {
							showTransactionAddView = true
							transactionToEdit = nil
						},
						label: {
							Text("Add New Transaction")
								.fontWeight(.semibold)
								.foregroundColor(.white)
								.padding()
								.frame(maxWidth: .infinity)
								.background(
									RoundedRectangle(cornerRadius: 12)
								)
						}
					)
					.padding(.horizontal)
				}
			}
			.navigationTitle("Dashboard")
			.toolbar {
				ToolbarItem(
					placement: .topBarTrailing,
					content: {
						Button(
							action: {
								print("Settings")
							},
							label: {
								Image(systemName: "gearshape.fill")
							}
						)

					}
				)
			}
			.sheet(
				isPresented: $showTransactionAddView,
				content: {
					AddTransactionPresentationDetent(
						transactions: $transactions, transactionToEdit: transactionToEdit
					)
					.presentationDetents([
						.fraction(0.35)
					]
					)
				}
			)
		}
	}
}

#Preview {
	HomeView()
}

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
	
	var income: Double {
		return transactions.filter({ $0.type == .income}).reduce(0, { $0 + $1.amount })
	}
	
	var expense: Double {
		var sumExpense: Double = 0.0
		for transaction in transactions {
			if transaction.type == .expense {
				sumExpense += transaction.amount
			}
		}
		return sumExpense
	}
	
	fileprivate func BalanceView() -> some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20, style: .continuous)
				.fill(Color(.systemBackground))
				.shadow(color: Color(.black).opacity(0.08), radius: 12, x: 0, y: 6)
			
			VStack(alignment: .leading, spacing: 20) {
				HStack {
					Text("BALANCE")
						.font(.caption.weight(.medium))
						.foregroundStyle(Color.secondary)
					Spacer()
					Image(systemName: "creditcard")
						.font(.title3)
						.foregroundStyle(Color.secondary.opacity(0.3))
				}
				Text("₹\(String(format: "%.2f", income - expense))")
					.font(.system(size: 40, weight: .semibold, design: .rounded))
					.foregroundStyle(Color.primary)
				HStack(spacing: 24) {
					HStack(spacing: 8) {
						Circle()
							.fill(Color.red.opacity(0.12))
							.frame(width: 32, height: 32)
							.overlay(Image(systemName: "arrow.up.forward")
								.font(.system(size: 16, weight: .semibold))
								.foregroundStyle(Color.red))
						VStack(alignment: .leading, spacing: 2) {
							Text("Expense")
								.font(.caption2.weight(.medium))
								.foregroundStyle(Color.secondary)
							Text("₹\(String(format: "%.2f", expense))")
								.font(.subheadline.weight(.semibold))
								.foregroundStyle(Color.primary)
						}
					}
					HStack(spacing: 8) {
						Circle()
							.fill(Color.green.opacity(0.12))
							.frame(width: 32, height: 32)
							.overlay(Image(systemName: "arrow.down.forward")
								.font(.system(size: 16, weight: .semibold))
								.foregroundStyle(Color.green))
						VStack(alignment: .leading, spacing: 2) {
							Text("Income")
								.font(.caption2.weight(.medium))
								.foregroundStyle(Color.secondary)
							Text("₹\(String(format: "%.2f", income))")
								.font(.subheadline.weight(.semibold))
								.foregroundStyle(Color.primary)
						}
					}
					Spacer()
				}
			}
			.padding(24)
		}
		.frame(height: 180)
		.padding(.horizontal, 4)
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
					Section {
						Spacer()
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
						}.onDelete(perform: deleteTransaction)
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
						transactions: $transactions,
						transactionToEdit: transactionToEdit
					)
					.presentationDetents([
						.fraction(0.35)
					]
					)
				}
			)
		}
	}
	
	private func deleteTransaction(at offsets: IndexSet){
		transactions.remove(atOffsets: offsets)
	}
	
}

#Preview {
	HomeView()
}

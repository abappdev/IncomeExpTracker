//
//  SettingsView.swift
//  IncomeExpTracker
//
//  Created by Abhishek Bhalerao on 29/07/25.
//

import SwiftUI

struct SettingsView: View {

    @State private var isOrderedDescending: Bool = false
    @State private var selectedCurrency: CurrencyModel = .inr

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Toggle(
                        isOn: $isOrderedDescending,
                        label: {
                            Text(
                                "Order \( isOrderedDescending ? "Earliest First" : "Latest First")"
                            )
                        }
                    )
                }
                HStack {
                    Picker(
                        "Currency",
                        selection: $selectedCurrency,
                        content: {
                            ForEach(
                                CurrencyModel.allCases,
                                id: \.self,
                                content: { currency in
                                    Text("\(currency.title)")
                                }
                            )

                        }
                    )
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}

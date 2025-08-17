//
//  ATMInputView.swift
//  AccountBalance
//
//  Created by Pothiraj on 17/08/25.
//

import SwiftUI

struct ATMInputView: View {
    @Binding var inputAmount: String
    
    // MARK: - Constants
    private let titleText = "Enter Amount"
    private let placeholderText = "0.00"
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(titleText)
                .font(.headline)
                .foregroundColor(.secondary)
            
            TextField(placeholderText,
                      text: $inputAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}

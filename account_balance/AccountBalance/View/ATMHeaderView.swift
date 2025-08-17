//
//  ATMHeaderView.swift
//  AccountBalance
//
//  Created by Pothiraj on 17/08/25.
//

import SwiftUI

struct ATMHeaderView: View {
    let accountNumber: String
    let balance: String

    // MARK: - Constants
    private enum Constants {
        static let accountBalanceTitle = "Account Balance"
        static let cardIconAccessibilityLabel = "Account card icon"
        static let currentBalabceTitle = "Current Balance"
        static let cardIcon = "creditcard.fill"
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(Constants.accountBalanceTitle)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(accountNumber)
                        .font(.headline)
                        .fontWeight(.bold)
                }
                Spacer()
                Image(systemName: "creditcard.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .accessibilityLabel(Constants.cardIconAccessibilityLabel)
            }
            Divider()
            Text(Constants.currentBalabceTitle)
                .font(.headline)
                .foregroundColor(.gray)
            Text(balance)
                .font(.system(size: 36, weight: .bold, design: .rounded))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                )
        )
    }
}

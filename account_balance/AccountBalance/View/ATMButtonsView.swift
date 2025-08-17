//
//  ATMButtonsView.swift
//  AccountBalance
//
//  Created by Pothiraj on 17/08/25.
//

import SwiftUI

struct ATMButtonsView: View {
    let onDeposit: () -> Void
    let onWithdraw: () -> Void
    let isValidInput: Bool
    
    // MARK: - Constants
    private enum Constants {
        static let depositTitle = "Deposit"
        static let withdrawTitle = "Withdraw"
        static let depositIcon = "plus.circle.fill"
        static let withdrawIcon = "minus.circle.fill"
        static let buttonHeight: CGFloat = 50
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 20
    }
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: Constants.spacing) {
            
            Button(action: onDeposit) {
                HStack {
                    Image(systemName: Constants.depositIcon)
                    Text(Constants.depositTitle)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: Constants.buttonHeight)
                .background(Color.green)
                .cornerRadius(Constants.cornerRadius)
            }
            .disabled(!isValidInput)
            
            Button(action: onWithdraw) {
                HStack {
                    Image(systemName: Constants.withdrawIcon)
                    Text(Constants.withdrawTitle)
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: Constants.buttonHeight)
                .background(Color.red)
                .cornerRadius(Constants.cornerRadius)
            }
            .disabled(!isValidInput)
        }
        .padding(.horizontal)
    }
}

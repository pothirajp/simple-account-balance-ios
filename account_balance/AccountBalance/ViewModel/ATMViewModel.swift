//
//  ATMViewModel.swift
//  AccountBalance
//
//  Created by Pothiraj on 17/08/25.
//
import SwiftUI
import Foundation

import Foundation

// MARK: - ATM Error Types
/// Represents possible errors during ATM operations
enum ATMError: LocalizedError {
    
    // MARK: - Constants
    private enum Constants {
        static let invalidAmountMessage = "Please enter a valid amount."
        static let depositLimitMessage = "Deposit must be between $0.01 and $10,000."
        static let withdrawalLimitMessage = "Withdrawal must be between $0.01 and $5,000."
        static let insufficientFundsMessage = "Insufficient funds for this withdrawal."
    }
    
    case invalidAmount
    case depositLimitExceeded
    case withdrawalLimitExceeded
    case insufficientFunds

    var errorDescription: String? {
        switch self {
        case .invalidAmount:
            return Constants.invalidAmountMessage
        case .depositLimitExceeded:
            return Constants.depositLimitMessage
        case .withdrawalLimitExceeded:
            return Constants.withdrawalLimitMessage
        case .insufficientFunds:
            return Constants.insufficientFundsMessage
        }
    }
}

// MARK: - ATM ViewModel
/// Handles ATM logic such as deposit, withdrawal, and validation
final class ATMViewModel: ObservableObject {
    
    // MARK: - Constants
    private enum Constants {
        static let maxDeposit: Double = 10_000
        static let maxWithdrawal: Double = 5_000
        static let defaultCurrencyCode = "USD"
        static let depositText = "Deposit"
        static let withdrawalText = "Withdrawal"
        static let successMessage = "%@ of %@ successful!" // formatted string
    }
    
    // MARK: - Published Properties
    @Published var account = BankAccount()
    @Published var inputAmount: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false

    // MARK: - Computed Properties
    /// Returns account balance in currency format
    var formattedBalance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? Constants.defaultCurrencyCode
        return formatter.string(from: NSNumber(value: account.balance)) ?? "$0.00"
    }

    /// Returns last recorded transaction
    var lastTransaction: Transaction? {
        account.transactions.last
    }

    // MARK: - Public Methods
    func deposit() {
        performTransaction(type: .deposit)
    }

    func withdraw() {
        performTransaction(type: .withdrawal)
    }

    // MARK: - Private Helpers
    private func performTransaction(type: TransactionType) {
        do {
            let amount = try validatedAmount(for: type)
            if type == .deposit {
                account.balance += amount
            } else {
                account.balance -= amount
            }

            let description = type == .deposit ? Constants.depositText : Constants.withdrawalText
            let transaction = Transaction(
                type: type,
                amount: amount,
                timestamp: Date(),
                description: description
            )
            
            account.transactions.append(transaction)
            inputAmount = ""
            
            let message = String(format: Constants.successMessage, description, amount.currencyFormatted)
            showAlertWith(message: message)
            
        } catch {
            showAlertWith(message: error.localizedDescription)
        }
    }

    private func validatedAmount(for type: TransactionType) throws -> Double {
        guard let amount = Double(inputAmount), amount > 0 else {
            throw ATMError.invalidAmount
        }

        switch type {
        case .deposit where amount > Constants.maxDeposit:
            throw ATMError.depositLimitExceeded
        case .withdrawal where amount > Constants.maxWithdrawal:
            throw ATMError.withdrawalLimitExceeded
        case .withdrawal where amount > account.balance:
            throw ATMError.insufficientFunds
        default:
            return amount
        }
    }

    private func showAlertWith(message: String) {
        alertMessage = message
        showAlert = true
    }
}

// MARK: - Double Extension
private extension Double {
    /// Converts Double to currency string format
    
    var currencyFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"
        return formatter.string(from: NSNumber(value: self)) ?? "$0.00"
    }
}

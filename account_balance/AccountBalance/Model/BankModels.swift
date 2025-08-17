//
//  BankModels.swift
//  AccountBalance
//
//  Created by Pothiraj on 17/08/25.
//

import Foundation

// MARK: - Models

/// Represents a user's bank account
struct BankAccount {
    var balance: Double
    var accountNumber: String
    var transactions: [Transaction]
    
    init(balance: Double = 1000.0, accountNumber: String = "ACC001") {
        self.balance = balance
        self.accountNumber = accountNumber
        self.transactions = []
    }
}

/// Represents a single transaction
struct Transaction {
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let timestamp: Date
    let description: String
}

/// Transaction type: Deposit or Withdrawal
enum TransactionType {
    case deposit
    case withdrawal
}

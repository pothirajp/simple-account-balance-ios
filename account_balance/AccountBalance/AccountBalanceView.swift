import SwiftUI

// MARK: - Models
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

struct Transaction {
    let id = UUID()
    let type: TransactionType
    let amount: Double
    let timestamp: Date
    let description: String
}

enum TransactionType {
    case deposit
    case withdrawal
}

// MARK: - View Model
class ATMViewModel: ObservableObject {
    @Published var account = BankAccount()
    @Published var inputAmount: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false
    
    // MARK: - Computed Properties
    var formattedBalance: String {
        return "$\(account.balance)"
    }
    
    var isValidInput: Bool {
        guard let amount = Double(inputAmount) else { return false }
        return true
    }
    
    var lastTransaction: Transaction? {
        return nil
    }
    
    // MARK: - Business Logic
    func deposit() {
        guard let amount = Double(inputAmount), amount > 0 else {
            showAlertWith(message: "Please enter a valid amount")
            return
        }
        
        account.balance += amount
        
        let transaction = Transaction(
            type: .deposit,
            amount: amount,
            timestamp: Date(),
            description: "Deposit"
        )
        
        inputAmount = ""
        showAlertWith(message: "Deposit successful!")
    }
    
    func withdraw() {
        guard let amount = Double(inputAmount), amount > 0 else {
            showAlertWith(message: "Please enter a valid amount")
            return
        }
        
        account.balance -= amount
        
        inputAmount = ""
        showAlertWith(message: "Withdrawal successful!")
    }
    
    private func showAlertWith(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    func getTransactionHistory() -> [Transaction] {
        return []
    }
}

// MARK: - Views
struct AccountBalnceView: View {
    @StateObject private var viewModel = ATMViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // MARK: - Header
                ATMHeaderView(accountNumber: viewModel.account.accountNumber,
                              balance: viewModel.formattedBalance)
                
                // MARK: - Input Section
                ATMInputView(inputAmount: $viewModel.inputAmount)
                
                // MARK: - Action Buttons
                ATMButtonsView(
                    onDeposit: viewModel.deposit,
                    onWithdraw: viewModel.withdraw,
                    isValidInput: viewModel.isValidInput
                )
                
                // MARK: - Last Transaction (TODO: Implement this view)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Simple ATM")
            .alert("Bank Notification", isPresented: $viewModel.showAlert) {
                Button("OK") { }
            }
        }
    }
}

// MARK: - Preview
struct AccountBalnceView_Previews: PreviewProvider {
    static var previews: some View {
        AccountBalnceView()
    }
}

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
    @Published var account: BankAccount
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
struct ContentView: View {
    @StateObject private var viewModel = ATMViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // MARK: - Header
                ATMHeaderView(balance: viewModel.formattedBalance)
                
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

struct ATMHeaderView: View {
    let balance: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Account Balance")
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(balance)
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity)
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

struct ATMInputView: View {
    @Binding var inputAmount: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Enter Amount")
                .font(.headline)
                .foregroundColor(.secondary)
            
            TextField("0.00", text: $inputAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }
}

struct ATMButtonsView: View {
    let onDeposit: () -> Void
    let onWithdraw: () -> Void
    let isValidInput: Bool
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onDeposit) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Deposit")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.green)
                .cornerRadius(12)
            }
            .disabled(!isValidInput)
            
            Button(action: onWithdraw) {
                HStack {
                    Image(systemName: "minus.circle.fill")
                    Text("Withdraw")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.red)
                .cornerRadius(12)
            }
            .disabled(!isValidInput)
        }
        .padding(.horizontal)
    }
}

struct LastTransactionView: View {
    let transaction: Transaction?
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

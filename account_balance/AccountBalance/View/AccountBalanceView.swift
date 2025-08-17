import SwiftUI

// MARK: - Views
struct AccountBalnceView: View {
    @StateObject private var viewModel = ATMViewModel()
    
    /// Constant for View
    private let pageTitle: String = "Simple ATM"
    private let alertTitle: String = "Bank Notification"
    private let alertOkButton: String = "Ok"

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
                    onWithdraw: viewModel.withdraw
                )
                
                // MARK: - Last Transaction (TODO: Implement this view)
                
                Spacer()
            }
            .padding()
            .navigationTitle(pageTitle)
            .alert(alertTitle, isPresented: $viewModel.showAlert) {
                Button(alertOkButton) { }
            } message: {
                Text(viewModel.alertMessage)
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

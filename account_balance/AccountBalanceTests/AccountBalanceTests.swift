import Testing
@testable import AccountBalance

struct AccountBalanceTests {
    
    @Test func depositWithinLimit() async throws {
        let viewModel = ATMViewModel()
        viewModel.account.balance = 1000.0
        viewModel.inputAmount = "500"
        viewModel.deposit()
        
        #expect(viewModel.account.balance == 1500.0)
        #expect(viewModel.showAlert == true)
    }
    
    @Test func depositOverLimit() async throws {
        let viewModel = ATMViewModel()
        viewModel.account.balance = 1000.0
        viewModel.inputAmount = "20000"
        viewModel.deposit()
        
        #expect(viewModel.showAlert)
        #expect(viewModel.alertMessage == ATMError.depositLimitExceeded.localizedDescription)
    }
    
    @Test func withdrawWithinLimit() async throws {
        let viewModel = ATMViewModel()
        viewModel.account.balance = 1000.0
        viewModel.inputAmount = "200"
        viewModel.withdraw()
        
        #expect(viewModel.account.balance == 800.0)
        #expect(viewModel.showAlert == true)
    }
    
    @Test func withdrawOverBalance() async throws {
        let viewModel = ATMViewModel()
        viewModel.account.balance = 1000.0
        viewModel.inputAmount = "2000"
        viewModel.withdraw()
        
        #expect(viewModel.showAlert)
        #expect(viewModel.alertMessage == ATMError.insufficientFunds.localizedDescription)
    }
    
    @Test func invalidAmountInput() async throws {
        let viewModel = ATMViewModel()
        viewModel.account.balance = 1000.0
        viewModel.inputAmount = "abc" // invalid input
        viewModel.deposit()
        
        #expect(viewModel.showAlert)
        #expect(viewModel.alertMessage == ATMError.invalidAmount.localizedDescription)
    }
    
    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
}

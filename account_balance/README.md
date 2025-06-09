# Simple ATM Page Programming Test

## Overview

You are tasked with completing and fixing a Simple ATM application written in Swift using SwiftUI and the MVVM (Model-View-ViewModel) design pattern. The application has several bugs and incomplete features that need to be addressed.

## Test Duration

**Estimated Time:** 15-20 minutes

## Project Setup

1. Open the project in Xcode
2. The main file to work with is `ContentView.swift`
3. Build and run the project to see current state
4. Review the code structure and identify issues

## Current State

The application is structured using MVVM pattern with:

- **Models:** `BankAccount`, `Transaction`, `TransactionType`
- **ViewModel:** `ATMViewModel` (ObservableObject)
- **Views:** `ContentView`, `ATMHeaderView`, `ATMInputView`, `ATMButtonsView`, `LastTransactionView`

## Your Tasks

### 1. Fix Compilation Errors

The project currently has compilation errors that prevent it from building. Fix all compilation issues.

### 2. Complete Missing Implementation

- Fix the `ATMViewModel` initializer
- Implement proper currency formatting in `formattedBalance`
- Complete the `isValidInput` validation logic
- Implement the `lastTransaction` computed property
- Complete transaction recording in both `deposit()` and `withdraw()` methods
- Implement the `getTransactionHistory()` method
- Complete the `LastTransactionView` implementation

### 3. Fix Business Logic Bugs

- Add deposit limit validation ($10,000 maximum)
- Add withdrawal limit validation ($5,000 maximum)
- Implement insufficient balance check for withdrawals
- Fix alert message display
- Add proper loading state management

### 4. Improve User Experience

- Implement proper input validation (positive numbers only)
- Add transaction history display
- Improve error messaging
- Add loading indicators during operations

### 5. Code Quality Improvements

- Add proper error handling
- Implement unit tests (if time permits)
- Add documentation comments
- Follow Swift/SwiftUI best practices

## Functional Requirements

- Initial balance: $1,000
- Deposit limit: $10,000 per transaction
- Withdrawal limit: $5,000 per transaction
- Must prevent overdraft (insufficient balance)
- Display transaction history
- Show formatted currency amounts
- Proper input validation

## Bonus Points

- Implement additional features (e.g., account details, transaction filtering)
- Add accessibility features
- Implement proper error recovery
- Add animations/transitions
- Write unit tests

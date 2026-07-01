@LAAT-2 @billPayment
Feature: VB Bank Bill Payment Flow
  As a user of VB Bank, I want to test the Bill Payment feature
  so that I can verify users can view payment history and make bill payments
  using the SecurePay Gateway.

  Background:
    Given User navigates to "baseUrl" page
    When User clicks on "LoginPage.Button.quickLoginUser" button
    Then User waits for "DashboardPage.Nav.dashboard" element to be visible

  @AC1 @Regression @Important @Smoke
  Scenario: Bills Payment option is visible in the global navigation panel
    Then User should see "BillsPaymentPage.Nav.billsPaymentLink" element

  @AC2 @Regression @Important @Smoke
  Scenario: Bills Payment screen displays correct heading and information
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    Then User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User should see text "Pay Bills" on page
    And User should see text "Pay your utility bills quickly and securely" on page
    And User should see "BillsPaymentPage.Table.recentPayments" element

  @AC3 @Smoke
  Scenario: Bills Payment history displays existing paid bills
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    Then User waits for "BillsPaymentPage.Table.recentPayments" element to be visible
    And User should see text "VB Internet" on page
    And User should see text "Monthly internet bill" on page
    And User should see text "$79.99" on page
    And User should see text "2/1/2024" on page

  @AC4
  Scenario: User can initiate a bill payment with Pay with Card
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "150.00" in "BillsPaymentPage.Input.amount" field
    And User enters "Monthly payment" in "BillsPaymentPage.Input.description" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    Then User waits for "SecurePayGateway.Input.cardNumber" element to be visible

  @AC5 @Regression @Important @Smoke @Critical
  Scenario: User can complete payment through SecurePay Gateway
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "150.00" in "BillsPaymentPage.Input.amount" field
    And User enters "Monthly payment" in "BillsPaymentPage.Input.description" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User enters "4111111111111111" in "SecurePayGateway.Input.cardNumber" field
    And User enters "John Doe" in "SecurePayGateway.Input.cardholderName" field
    And User enters "12/28" in "SecurePayGateway.Input.expiryDate" field
    And User enters "123" in "SecurePayGateway.Input.cvv" field
    And User clicks on "SecurePayGateway.Button.pay" button
    And User waits for 5 seconds
    Then User waits for "BillsPaymentPage.Alert.cardPaymentConfirmation" element to be visible
    And User should see text "Card payment successful" on page

  @AC6 @Regression @Important @Negative
  Scenario: Payment fails with invalid card details showing error message
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "50.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User enters "4111111111111111" in "SecurePayGateway.Input.cardNumber" field
    And User enters "Test User" in "SecurePayGateway.Input.cardholderName" field
    And User enters "01/22" in "SecurePayGateway.Input.expiryDate" field
    And User enters "999" in "SecurePayGateway.Input.cvv" field
    And User clicks on "SecurePayGateway.Button.pay" button
    Then User waits for "SecurePayGateway.Alert.paymentError" element to be visible

  @AC7 @Negative
  Scenario: Payment fails with expired card showing expired card error
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "75.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User enters "4111111111111111" in "SecurePayGateway.Input.cardNumber" field
    And User enters "Jane Doe" in "SecurePayGateway.Input.cardholderName" field
    And User enters "01/20" in "SecurePayGateway.Input.expiryDate" field
    And User enters "456" in "SecurePayGateway.Input.cvv" field
    And User clicks on "SecurePayGateway.Button.pay" button
    Then User waits for "SecurePayGateway.Alert.expiredCardError" element to be visible

  @AC8 @Negative @Validation
  Scenario: Payment with empty amount field is blocked at form level
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User clears "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for 2 seconds
    Then User should see "BillsPaymentPage.Heading.payBills" element

  @AC9 @Negative @Validation
  Scenario: Payment without provider selection is blocked at form level
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User enters "100.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for 2 seconds
    Then User should see "BillsPaymentPage.Heading.payBills" element

  @AC10 @Regression @Important @Navigation
  Scenario: User can cancel payment and return to Bills Payment screen
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "50.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User clicks on "SecurePayGateway.Button.cancel" button
    Then User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User should see text "Pay Bills" on page

  @AC11 @Navigation
  Scenario: User can navigate back from Bills Payment to Dashboard
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User clicks on "DashboardPage.Nav.dashboard" link
    Then User waits for "DashboardPage.Nav.dashboard" element to be visible
    And User should not see "BillsPaymentPage.Heading.payBills" element

  @AC12 @Negative @Boundary
  Scenario: Payment with zero amount is blocked at form level
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "0" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for 2 seconds
    Then User should see "BillsPaymentPage.Heading.payBills" element

  @AC13 @Boundary
  Scenario: Payment with maximum amount proceeds to gateway without validation
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "999999.99" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    Then User waits for "SecurePayGateway.Input.cardNumber" element to be visible

  @AC14 @Provider
  Scenario: User can select different utility provider for payment
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "⚡ VB Power" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "200.00" in "BillsPaymentPage.Input.amount" field
    And User enters "Power bill payment" in "BillsPaymentPage.Input.description" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    Then User waits for "SecurePayGateway.Input.cardNumber" element to be visible

  @AC15 @Workflow
  Scenario: Payment history updates after successful payment
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "45.00" in "BillsPaymentPage.Input.amount" field
    And User enters "Test payment for history" in "BillsPaymentPage.Input.description" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User enters "4111111111111111" in "SecurePayGateway.Input.cardNumber" field
    And User enters "John Doe" in "SecurePayGateway.Input.cardholderName" field
    And User enters "12/28" in "SecurePayGateway.Input.expiryDate" field
    And User enters "123" in "SecurePayGateway.Input.cvv" field
    And User clicks on "SecurePayGateway.Button.pay" button
    And User waits for 5 seconds
    Then User waits for "BillsPaymentPage.Alert.cardPaymentConfirmation" element to be visible
    And User should see text "$45.00" on page

  @AC16 @Negative @Formatting
  Scenario: Payment with negative amount is blocked at form level
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "-50.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for 2 seconds
    Then User should see "BillsPaymentPage.Heading.payBills" element

  @AC17 @Negative @CardValidation
  Scenario: Payment fails with short card number showing validation error
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "100.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User enters "411111" in "SecurePayGateway.Input.cardNumber" field
    And User enters "John Doe" in "SecurePayGateway.Input.cardholderName" field
    And User enters "12/28" in "SecurePayGateway.Input.expiryDate" field
    And User enters "123" in "SecurePayGateway.Input.cvv" field
    And User clicks on "SecurePayGateway.Button.pay" button
    Then User waits for "SecurePayGateway.Alert.paymentError" element to be visible

  @AC18 @Regression @Important @Smoke @Workflow @Confirmation
  Scenario: Payment confirmation shows correct transaction details in Recent Payments
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "250.00" in "BillsPaymentPage.Input.amount" field
    And User enters "Quarterly internet bill" in "BillsPaymentPage.Input.description" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    And User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User enters "4111111111111111" in "SecurePayGateway.Input.cardNumber" field
    And User enters "John Doe" in "SecurePayGateway.Input.cardholderName" field
    And User enters "12/28" in "SecurePayGateway.Input.expiryDate" field
    And User enters "123" in "SecurePayGateway.Input.cvv" field
    And User clicks on "SecurePayGateway.Button.pay" button
    And User waits for 5 seconds
    Then User waits for "BillsPaymentPage.Alert.cardPaymentConfirmation" element to be visible
    And User should see text "Card payment successful" on page
    And User should see text "$250.00" on page
    And User should see text "VB Internet" on page

  # ─────────────────────────────────────────────────────────────────────────────
  # NEW SCENARIOS: AC19 – AC23  (total: 23 scenarios)
  # ─────────────────────────────────────────────────────────────────────────────

  @AC19 @Regression @Important @Smoke @PayFromAccount
  Scenario: User can complete payment using Pay from Account method
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "50.00" in "BillsPaymentPage.Input.amount" field
    And User enters "Account method payment" in "BillsPaymentPage.Input.description" field
    And User clicks on "BillsPaymentPage.Radio.payFromAccount" radio
    And User clicks on "BillsPaymentPage.Button.payBill" button
    And User waits for 3 seconds
    Then User should see "BillsPaymentPage.Heading.payBills" element

  @AC20 @Smoke @UI
  Scenario: All four utility providers are available in the provider dropdown
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    Then User should see "BillsPaymentPage.Dropdown.utilityProvider" element
    And User should see text "VB Power" on page
    And User should see text "VB Water" on page
    And User should see text "VB Internet" on page
    And User should see text "VB Gas" on page

  @AC21 @Smoke @Gateway
  Scenario: SecurePay Gateway displays the correct amount to be paid
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    And User selects "🌐 VB Internet" from "BillsPaymentPage.Dropdown.utilityProvider" dropdown
    And User enters "175.00" in "BillsPaymentPage.Input.amount" field
    And User clicks on "BillsPaymentPage.Radio.payWithCard" radio
    And User clicks on "BillsPaymentPage.Button.continueToPayment" button
    Then User waits for "SecurePayGateway.Input.cardNumber" element to be visible
    And User should see text "175" on page
    And User should see text "SecurePay Gateway" on page
    And User should see text "encrypted and secure" on page

  @AC22 @UI
  Scenario: Bills Payment form fields are visible and labelled correctly
    When User clicks on "BillsPaymentPage.Nav.billsPaymentLink" link
    And User waits for "BillsPaymentPage.Heading.payBills" element to be visible
    Then User should see "BillsPaymentPage.Dropdown.utilityProvider" element
    And User should see "BillsPaymentPage.Input.amount" element
    And User should see "BillsPaymentPage.Input.description" element
    And User should see "BillsPaymentPage.Button.continueToPayment" element
    And User should see text "Utility Provider" on page
    And User should see text "Amount" on page
    And User should see text "Payment Method" on page

  @AC23 @Regression @Important @Navigation
  Scenario: User can navigate to History page from navigation panel
    When User clicks on "DashboardPage.Nav.history" link
    Then User waits for "HistoryPage.Heading.transactionHistory" element to be visible
    And User should see text "Transaction History" on page

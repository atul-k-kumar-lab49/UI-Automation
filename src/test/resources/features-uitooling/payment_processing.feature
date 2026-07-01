# =====================================================================
# Feature: Payment Processing - VB Internet
# Business Flow: End-to-End payment lifecycle for internet service billing
# Priority: CRITICAL
# =====================================================================

@Regression @Payment @Smoke
Feature: Payment Processing for VB Internet Service
  As a registered VB Internet customer
  I want to make a payment for my internet subscription
  So that my service remains active without interruption

  Background:
    Given the user is logged in as a valid customer
    And the user is on the Payment page

  # ---------------------------------------------------------------
  # HAPPY PATH SCENARIOS
  # ---------------------------------------------------------------

  @Smoke @Critical
  Scenario: TC_PAY_001 - Successful payment of $250.00 for VB Internet service
    Given the user is on the payment page
    When the user enters the amount "$250.00"
    And the user selects the service "VB Internet"
    And the user selects payment method "Credit Card"
    And the user enters valid card details
    And the user confirms and submits the payment
    Then the user should see text "successful" on page
    And the user should see text "$250.00" on page
    And the user should see text "VB Internet" on page
    And a unique transaction ID should be generated
    And the payment confirmation receipt should be available

  @Critical
  Scenario: TC_PAY_002 - Payment confirmation shows all correct details
    Given the user submits a payment of "$250.00" for "VB Internet"
    Then the confirmation page should display:
      | Field           | Expected Value |
      | Status          | successful     |
      | Amount          | $250.00        |
      | Service         | VB Internet    |
    And the transaction timestamp should reflect today's date
    And the print receipt button should be enabled

  @Critical
  Scenario: TC_PAY_003 - Payment via Bank Transfer for VB Internet
    Given the user is on the payment page
    When the user enters the amount "$250.00"
    And the user selects the service "VB Internet"
    And the user selects payment method "Bank Transfer"
    And the user enters valid bank account details
    And the user submits the payment
    Then the user should see text "successful" on page
    And the user should see text "$250.00" on page
    And the user should see text "VB Internet" on page

  @Regression
  Scenario: TC_PAY_004 - Make another payment after a successful transaction
    Given the user successfully pays "$250.00" for "VB Internet"
    When the user clicks "Make Another Payment"
    Then the user should be redirected to a fresh payment form
    And all payment fields should be empty
    And the user should be able to enter a new payment amount

  @Regression
  Scenario: TC_PAY_005 - User can download receipt after payment
    Given the user successfully pays "$250.00" for "VB Internet"
    Then the download receipt button should be visible
    When the user clicks the download receipt button
    Then a receipt file should be downloaded

  # ---------------------------------------------------------------
  # AMOUNT VALIDATION - EDGE CASES
  # ---------------------------------------------------------------

  @EdgeCase @Negative
  Scenario: TC_PAY_006 - Payment with zero amount should fail validation
    Given the user is on the payment page
    When the user enters the amount "0.00"
    And the user selects the service "VB Internet"
    And the user attempts to submit the payment
    Then an error message "Amount must be greater than zero" should appear
    And the payment should not be processed

  @EdgeCase @Negative
  Scenario: TC_PAY_007 - Payment with negative amount is rejected
    Given the user is on the payment page
    When the user enters the amount "-50.00"
    And the user selects the service "VB Internet"
    And the user attempts to submit the payment
    Then an error message should appear for the amount field
    And the payment should not be processed

  @EdgeCase @Negative
  Scenario: TC_PAY_008 - Payment with non-numeric characters in amount field
    Given the user is on the payment page
    When the user enters the amount "abc##"
    And the user selects the service "VB Internet"
    And the user attempts to submit the payment
    Then an error message "Invalid amount" should appear
    And the Pay Now button should remain disabled

  @EdgeCase
  Scenario: TC_PAY_009 - Payment with very large amount
    Given the user is on the payment page
    When the user enters the amount "99999.99"
    And the user selects the service "VB Internet"
    And the user selects payment method "Credit Card"
    And the user enters valid card details
    And the user submits the payment
    Then the system should either process the payment successfully
    And an appropriate limit exceeded message may be displayed

  @EdgeCase @Negative
  Scenario: TC_PAY_010 - Submit payment without selecting a service
    Given the user is on the payment page
    When the user enters the amount "$250.00"
    But the user does not select a service
    And the user attempts to submit the payment
    Then a service selection error should be displayed
    And the payment should not be processed

  # ---------------------------------------------------------------
  # CARD VALIDATION EDGE CASES
  # ---------------------------------------------------------------

  @EdgeCase @Negative
  Scenario: TC_PAY_011 - Payment with expired card is declined
    Given the user is on the payment page
    When the user enters the amount "$250.00"
    And the user selects the service "VB Internet"
    And the user selects payment method "Credit Card"
    And the user enters an expired card with expiry "01/20"
    And the user submits the payment
    Then the payment should be declined
    And the user should see an error "Card has expired"

  @EdgeCase @Negative
  Scenario: TC_PAY_012 - Payment with invalid CVV is rejected
    Given the user is on the payment page
    When the user enters the amount "$250.00"
    And the user selects the service "VB Internet"
    And the user selects payment method "Credit Card"
    And the user enters an invalid CVV "99"
    And the user submits the payment
    Then the CVV validation error should be displayed

  @EdgeCase @Negative
  Scenario: TC_PAY_013 - Payment with insufficient funds declined
    Given the user is on the payment page
    When the user enters the amount "$250.00"
    And the user selects the service "VB Internet"
    And the user selects payment method "Credit Card"
    And the user enters a card that simulates insufficient funds
    And the user submits the payment
    Then the payment should be declined
    And the user should see "Insufficient funds" error

  # ---------------------------------------------------------------
  # SESSION AND CONCURRENCY EDGE CASES
  # ---------------------------------------------------------------

  @EdgeCase @Security
  Scenario: TC_PAY_014 - Payment form is not submitted twice on double click
    Given the user is on the payment page
    When the user enters valid payment details for "$250.00" and "VB Internet"
    And the user double-clicks the Pay Now button
    Then only one payment transaction should be created
    And the confirmation page should show a single "$250.00" debit

  @EdgeCase @Security
  Scenario: TC_PAY_015 - User cannot go back and resubmit a completed payment
    Given the user successfully pays "$250.00" for "VB Internet"
    When the user navigates back using the browser back button
    Then the payment form should not allow resubmission
    And the user should be redirected to the confirmation page or home

  # ---------------------------------------------------------------
  # DATA DRIVEN - Multiple Payment Scenarios
  # ---------------------------------------------------------------

  @Regression @DataDriven
  Scenario Outline: TC_PAY_016 - Process payments for multiple service tiers
    Given the user is on the payment page
    When the user enters the amount "<amount>"
    And the user selects the service "<service>"
    And the user selects payment method "Credit Card"
    And the user enters valid card details
    And the user submits the payment
    Then the user should see text "successful" on page
    And the user should see text "<amount>" on page
    And the user should see text "<service>" on page

    Examples:
      | amount   | service       |
      | $250.00  | VB Internet   |
      | $99.99   | VB Internet   |
      | $499.00  | VB Internet   |
      | $25.00   | VB Internet   |

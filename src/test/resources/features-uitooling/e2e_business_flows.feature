# =====================================================================
# Feature: End-to-End Business Flows
# Business Flow: Complete user journeys across multiple pages
# Priority: CRITICAL
# =====================================================================

@Regression @E2E @Critical
Feature: End-to-End Business Flows - VB Internet Payment Portal
  As a QA engineer validating the complete system
  I want to test full business journeys
  So that every critical path works seamlessly end-to-end

  # ---------------------------------------------------------------
  # COMPLETE PAYMENT LIFECYCLE
  # ---------------------------------------------------------------

  @Smoke @Critical
  Scenario: TC_E2E_001 - Complete payment lifecycle from login to receipt
    Given the user navigates to the login page
    When the user logs in with valid credentials
    Then the home dashboard should be displayed
    When the user clicks on Payment in the navigation
    Then the payment page should load
    When the user enters amount "$250.00"
    And the user selects service "VB Internet"
    And the user selects payment method "Credit Card"
    And the user fills in valid card details
    And the user submits the payment
    Then the confirmation page should show "successful"
    And the confirmation page should show "$250.00"
    And the confirmation page should show "VB Internet"
    And a transaction ID should be present
    When the user navigates to Billing
    Then the billing history should include the "$250.00" payment
    And the billing history should show "VB Internet"

  @Critical
  Scenario: TC_E2E_002 - Login, pay, verify confirmation, logout, re-login and verify history
    Given the user logs in as a valid customer
    And the user makes a payment of "$250.00" for "VB Internet"
    And the confirmation shows "successful" for "$250.00" and "VB Internet"
    When the user logs out
    And the user logs back in with valid credentials
    And the user navigates to Billing
    Then the last payment of "$250.00" for "VB Internet" should appear in the history

  @Critical
  Scenario: TC_E2E_003 - Quick Pay button directly from home page
    Given the user is logged in as a valid customer
    When the user clicks the Quick Pay button on the home page
    Then the payment page should load with default service pre-selected
    When the user enters the payment amount "$250.00"
    And the user submits the payment with valid payment method
    Then the user should see text "successful" on page
    And the user should see text "$250.00" on page
    And the user should see text "VB Internet" on page

  # ---------------------------------------------------------------
  # PAYMENT + BILLING VERIFICATION FLOW
  # ---------------------------------------------------------------

  @Regression
  Scenario: TC_E2E_004 - Multiple sequential payments reflect in billing
    Given the user is logged in as a valid customer
    When the user makes a payment of "$250.00" for "VB Internet"
    And the user clicks Make Another Payment
    And the user makes another payment of "$99.99" for "VB Internet"
    When the user navigates to the Billing page
    Then the billing history should contain a record for "$250.00"
    And the billing history should contain a record for "$99.99"
    And both payments should show status "successful"

  # ---------------------------------------------------------------
  # FAILURE AND RECOVERY FLOWS
  # ---------------------------------------------------------------

  @Regression @NegativeE2E
  Scenario: TC_E2E_005 - Failed payment does not appear in billing history
    Given the user is logged in as a valid customer
    When the user attempts a payment with an expired card
    And the payment is declined
    Then the confirmation should not show "successful"
    When the user navigates to Billing
    Then the declined payment should not appear in billing history as "successful"

  @Regression
  Scenario: TC_E2E_006 - User session timeout redirects to login during payment
    Given the user is on the payment page mid-entry
    When the user's session expires due to inactivity
    And the user tries to submit the payment
    Then the user should be redirected to the login page
    And a session expired message should be displayed
    And after re-login the user should be able to complete the payment

  # ---------------------------------------------------------------
  # CROSS-PAGE NAVIGATION
  # ---------------------------------------------------------------

  @Regression
  Scenario: TC_E2E_007 - Navigation between Payment and Billing pages preserves state
    Given the user is logged in as a valid customer
    When the user navigates to the Payment page
    And the user partially fills the payment amount "$250.00"
    And the user navigates to Billing and back to Payment
    Then the payment form fields should be in expected state
    And the page should be fully functional

  @Smoke
  Scenario: TC_E2E_008 - Responsive form validation sequence
    Given the user is on the payment page
    When the user attempts to submit without filling any field
    Then field-level validation errors should appear for required fields
    When the user fills in the amount "$250.00"
    And attempts to submit again
    Then the service selection error should appear
    When the user selects "VB Internet"
    And the user selects a payment method
    And the user submits the payment with valid details
    Then the user should see text "successful" on page

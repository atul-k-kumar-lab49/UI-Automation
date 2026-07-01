# =====================================================================
# Feature: Billing Management
# Business Flow: View billing history, statements, account balance
# Priority: HIGH
# =====================================================================

@Regression @Billing
Feature: Billing Management and Statement Access
  As a VB Internet subscriber
  I want to view my billing history and current balance
  So that I can track my payments and verify account status

  Background:
    Given the user is logged in as a valid customer

  # ---------------------------------------------------------------
  # HAPPY PATH
  # ---------------------------------------------------------------

  @Smoke @Critical
  Scenario: TC_BILL_001 - View billing history with recent VB Internet payment
    Given the user navigates to the Billing page
    Then the billing history table should be visible
    And the page should display the billing history
    And the account status should reflect "Active"

  @Critical
  Scenario: TC_BILL_002 - Billing history reflects completed $250.00 payment
    Given the user has completed a payment of "$250.00" for "VB Internet"
    When the user navigates to the Billing page
    Then the billing history should contain a record for "$250.00"
    And the billing history should contain a record for "VB Internet"
    And the payment status should show "successful"

  @Critical
  Scenario: TC_BILL_003 - Current bill amount is displayed correctly
    Given the user is on the Billing page
    Then the current bill amount should be visible
    And the due date should be displayed
    And the service name "VB Internet" should appear in the billing header

  @Regression
  Scenario: TC_BILL_004 - Download billing statement successfully
    Given the user is on the Billing page
    When the user clicks the Download Statement button
    Then the billing statement should download
    And the downloaded file should be a valid document

  @Regression
  Scenario: TC_BILL_005 - Filter billing history by date range
    Given the user is on the Billing page
    When the user filters billing records from "2024-01-01" to "2024-12-31"
    Then the results should only show records within that date range
    And records outside the range should not be displayed

  # ---------------------------------------------------------------
  # EDGE CASES
  # ---------------------------------------------------------------

  @EdgeCase
  Scenario: TC_BILL_006 - Billing page shows no records for new account
    Given the user is logged in as a brand new customer with no billing history
    When the user navigates to the Billing page
    Then a "No billing records found" message should be displayed
    And the billing table should be empty

  @EdgeCase
  Scenario: TC_BILL_007 - Billing history pagination works correctly
    Given the user is on the Billing page with more than 10 records
    When the user navigates to page 2 of billing history
    Then the second page of billing records should load
    And the page indicator should show page 2

  @EdgeCase
  Scenario: TC_BILL_008 - Billing filter with inverted dates shows validation error
    Given the user is on the Billing page
    When the user sets the From date to "2024-12-31" and To date to "2024-01-01"
    And the user applies the filter
    Then a date range validation error should be displayed
    And the billing table should not be updated

  @Regression
  Scenario: TC_BILL_009 - Clear filters restores full billing history
    Given the user has applied a date filter on the Billing page
    When the user clicks Clear Filters
    Then the full billing history should be restored
    And the date filter fields should be empty


  @Regression
  Scenario: TC_BILL_010 - Billing history shows correct status for pending payments
    Given the user has a pending payment of "$150.00" for "VB Internet"
    When the user navigates to the Billing page
    Then the billing history should show a record for "$150.00"
    And the payment status should show "pending"

  @Regression
  Scenario: TC_BILL_011 - Billing history shows correct status for failed payments
    Given the user has a failed payment of "$200.00" for "VB Internet"
    When the user navigates to the Billing page
    Then the billing history should show a record for "$200.00"
    And the payment status should show "failed"

  @Regression
    Scenario: TC_BILL_012 - Billing history shows correct status for refunded payments
    Given the user has a refunded payment of "$100.00" for "VB Internet"
    When the user navigates to the Billing page
    Then the billing history should show a record for "$100.00"
    And the payment status should show "refunded"

  @Regression
    Scenario: TC_BILL_013 - Billing history shows correct status for chargebacks
    Given the user has a chargeback payment of "$300.00" for "VB Internet"
    When the user navigates to the Billing page
    Then the billing history should show a record for "$300.00"
    And the payment status should show "chargeback"


  @Regression
    Scenario: TC_BILL_014 - Billing history shows correct status for disputed payments
        Given the user has a disputed payment of "$400.00" for "VB Internet"
        When the user navigates to the Billing page
        Then the billing history should show a record for "$400.00"
        And the payment status should show "disputed"







Feature: TopUp Functionality

  @Regression
  Scenario: User sees a Top Up link on left side navigation menu of Landing Page
    When User opens application
    And User clicks quick login user
    Then "Top Up" link is visible on left side navigation menu
    And "Top Up" link should be clickable

  Scenario: User sees the correct Top Up amount after clicking on Proceed to Payment.
    When User opens application
    And  User clicks quick login user
    And User clicks on Top Up link
    And User enters the Top Up amount as "1000" dollars
    And User clicks on Proceed to Payment
    Then Amount to Pay value is displayed as "$1000.00"

  Scenario: User is redirected to dashboard page on clicking Cancel button of Card details checkout page.
    When User opens application
    And  User clicks quick login user
    And User clicks on Top Up link
    And User enters the Top Up amount as "1000" dollars
    And User clicks on Proceed to Payment
    And User clicks on Cancel button
    Then Dashboard should be visible

  Scenario: User successfully add TopUp Amount by entering valid Card details.
    When User opens application
    And  User clicks quick login user
    And User clicks on Top Up link
    And User enters the Top Up amount as "1000" dollars
    And User clicks on Proceed to Payment
    And User enters the Card number as "1234 5678 9012 3456"
    And User enters the Card holder name as "John Doe"
    And User enters the Card expiry date as "08/26"
    And User enters the cvv as "123"
    And User clicks the Pay button
    Then Top Up success msg should be displayed as "Successfully added $1000.00 to your account!"


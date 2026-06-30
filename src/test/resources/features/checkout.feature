Feature: Checkout Functionality

  @Regression
  Scenario: User should be able to navigate to Checkout Payment gateway page
    When User opens application
    And User clicks quick login user
    And User clicks on Top Up link
    And User enters the Top Up amount as "200" dollars
    And User clicks on Proceed to Payment
    Then Entering Card Number input field is enabled
    And Entering Card Holder Name input field is displayed
    And Entering Card Expiry Date input field is enabled
    And Entering Card cvv input field is enabled
    And Entering Card pay button is displayed

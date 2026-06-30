Feature: Login

  @Regression
  Scenario: User can login successfully using Quick Login as User
    When User opens application
    And User clicks quick login user
    Then Dashboard should be visible
    And Username should be "John Doe"

  Scenario:Login page displays correct branding and elements
    When User opens application
    Then VB logo is visible
    And VB header should be "VB Bank"
    And User should see vb secondheader "Secure Banking at Your Fingertips"
    And Username field should be displayed
    And Password field should be displayed
    And login button is displayed
    And User should see text "QUICK LOGIN (FOR TESTING)"
    And quickLoginUser button should be displayed
    And quickLoginAdmin button should be displayed
    And register link should be displayed

  Scenario:Display error message when Login with Invalid Credentials
    When User opens application
    And the user enters an invalid Username as "Testuser"
    And the user enters an invalid password as "Test123"
    And User clicks on login button
    Then Error msg is displayed as "Invalid username or password"

  Scenario: Display error message when trying login only using password
    When User opens application
    And the user enters an invalid password as "Test123"
    And User clicks on login button
    Then Error msg is displayed on login only using Password as "Please fill out this field."

  Scenario: Display error message when trying login only using Username
    When User opens application
    And the user enters an invalid Username as "Testuser"
    And User clicks on login button
    Then Error msg is displayed on login only using Username as "Please fill out this field."

  Scenario: User can login successfully using Quick Login as Admin
    When User opens application
    And User clicks quick login as "Admin"
    Then Dashboard should be visible
    And Username should be "Admin User"
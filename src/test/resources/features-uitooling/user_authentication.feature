# =====================================================================
# Feature: User Authentication
# Business Flow: Login, logout, session management
# Priority: CRITICAL
# =====================================================================

@Regression @Authentication @Smoke
Feature: User Authentication - Login and Session Management
  As a VB Internet portal user
  I want to securely log in and manage my session
  So that only I can access my account and payment features

  # ---------------------------------------------------------------
  # HAPPY PATH
  # ---------------------------------------------------------------

  @Smoke @Critical
  Scenario: TC_AUTH_001 - Successful login with valid credentials
    Given the user is on the login page
    When the user enters username "testuser@vbinternet.com"
    And the user enters password "Test@1234"
    And the user clicks the Login button
    Then the user should be redirected to the home dashboard
    And the welcome message should be displayed
    And the navigation menu should be visible

  @Critical
  Scenario: TC_AUTH_002 - Logged-in user can access payment section
    Given the user is logged in as a valid customer
    When the user navigates to the payment section
    Then the payment page should be loaded
    And the amount input field should be visible
    And the service dropdown should be available

  @Critical
  Scenario: TC_AUTH_003 - User can successfully logout
    Given the user is logged in as a valid customer
    When the user clicks the Logout button
    Then the user should be redirected to the login page
    And the session should be terminated
    And the user should not be able to access the payment page

  # ---------------------------------------------------------------
  # NEGATIVE / EDGE CASES
  # ---------------------------------------------------------------

  @Negative @EdgeCase
  Scenario: TC_AUTH_004 - Login with invalid password shows error
    Given the user is on the login page
    When the user enters username "testuser@vbinternet.com"
    And the user enters password "WrongPassword"
    And the user clicks the Login button
    Then an error message "Invalid username or password" should be displayed
    And the user should remain on the login page

  @Negative @EdgeCase
  Scenario: TC_AUTH_005 - Login with non-existent user shows error
    Given the user is on the login page
    When the user enters username "nonexistent@vbinternet.com"
    And the user enters password "Test@1234"
    And the user clicks the Login button
    Then an error message should be displayed
    And the user should remain on the login page

  @Negative @EdgeCase
  Scenario: TC_AUTH_006 - Login with blank credentials is rejected
    Given the user is on the login page
    When the user leaves the username field empty
    And the user leaves the password field empty
    And the user clicks the Login button
    Then form validation errors should appear for both fields
    And the login should not proceed

  @Negative @EdgeCase
  Scenario: TC_AUTH_007 - Login with blank password is rejected
    Given the user is on the login page
    When the user enters username "testuser@vbinternet.com"
    And the user leaves the password field empty
    And the user clicks the Login button
    Then a password required error should be displayed

  @Security @EdgeCase
  Scenario: TC_AUTH_008 - SQL injection attempt in login fields is blocked
    Given the user is on the login page
    When the user enters username "' OR '1'='1"
    And the user enters password "' OR '1'='1"
    And the user clicks the Login button
    Then the login should fail
    And no application error page should be displayed

  @Security @EdgeCase
  Scenario: TC_AUTH_009 - XSS attempt in login fields is sanitized
    Given the user is on the login page
    When the user enters username "<script>alert('xss')</script>"
    And the user enters password "Test@1234"
    And the user clicks the Login button
    Then no script should execute
    And the application should remain stable

  @Security @EdgeCase
  Scenario: TC_AUTH_010 - Session does not persist after browser close simulation
    Given the user is logged in as a valid customer
    When the user clears browser cookies and sessions
    And the user attempts to access the payment page directly
    Then the user should be redirected to the login page

  @Regression
  Scenario: TC_AUTH_011 - Unauthenticated direct URL access redirects to login
    Given the user is not logged in
    When the user tries to access the payment page URL directly
    Then the user should be redirected to the login page
    And an appropriate message should be displayed

  @Regression
  Scenario: TC_AUTH_012 - Remember Me functionality keeps session across refresh
    Given the user is on the login page
    When the user enters valid credentials
    And the user checks the "Remember Me" checkbox
    And the user clicks the Login button
    Then the user should be logged in successfully
    And after refreshing the page the user should still be logged in

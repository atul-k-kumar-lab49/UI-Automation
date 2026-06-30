package stepdefinitions;

import io.cucumber.java.bs.A;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.testng.Assert;
import pages.DashboardPage;
import pages.LoginPage;
import utils.ConfigReader;

    public class LoginSteps {

        // Page object instances
        LoginPage login = new LoginPage();
        DashboardPage dashboard = new DashboardPage();

        //Logged in User validation
        @When("User opens application")
        public void openApp() {
            login.navigateToUrl(ConfigReader.get("base.url"));
        }

        @When("User clicks quick login user")
        public void clickQuickLogin() {
            login.clickQuickLoginUser();
        }

        @Then("Dashboard should be visible")
        public void verifyDashboard() {
            Assert.assertTrue(dashboard.isDashboardVisible());
        }

        @Then("Username should be {string}")
        public void verifyUsername(String name) {
            Assert.assertEquals(dashboard.getUsername(), name);
        }

    // UI Validations
        @Then("VB logo is visible")
        public void verifyLogo(){Assert.assertTrue(login.isLogoVisible());}

        @Then("VB header should be {string}")
        public void verifyBankHeader(String expectedHeader){
            String actual=login.actualLogoTitle();
            Assert.assertEquals(actual,expectedHeader);
        }

        @And("User should see vb secondheader {string}")
        public void verifySecureBankingTxt(String expectedVal){

            String actual=login.vbLogoSubtitle();
            Assert.assertEquals(actual,expectedVal);
        }
        @And("Username field should be displayed")
        public void verifyUsernameFieldIsVisible(){
            Assert.assertTrue(login.isUsernameFieldVisible());
        }

        @And("Password field should be displayed")
        public void verifyPasswordFieldIsVisible(){
        Assert.assertTrue(login.isPasswordFieldVisible());

        }

        @And("login button is displayed")
        public void verifyLoginButtonIsVisible(){

            Assert.assertTrue(login.isLoginButtonVisible());
        }

        @And("User should see text {string}")
        public void verifyQuickLoginTesting_txtIsVisible(String expectedVal){
            String actual=login.quickLoginTesting_Txt();
            Assert.assertEquals(actual,expectedVal);
        }

        @And("quickLoginUser button should be displayed")
        public void verifyQuickLoginUserButtonIsVisible(){
            Assert.assertTrue(login.isQuickLoginUserBtnVisible());
        }

        @And("quickLoginAdmin button should be displayed")
        public void verifyQuickLoginAdminButtonIsVisible(){
            Assert.assertTrue(login.isQuickLoginAdminBtnVisible());
        }

        @And("register link should be displayed")
        public void verifyRegisterLinkIsVisible(){
            Assert.assertTrue(login.isRegisterLinkVisible());
        }

        @And("the user enters an invalid Username as {string}")
        public void enterInvalidUserName(String inValidUserName){
            login.enterUserName(inValidUserName);

        }

        @And("the user enters an invalid password as {string}")
        public void enterInvalidPassword(String inValidPassword){
            login.enterPassword(inValidPassword);

        }

        @And("User clicks on login button")
        public void clickLogin(){
            login.clickLogin();

        }

        @Then("Error msg is displayed as {string}")
        public void verifyErrorMsgInvalidCredentials(String expectedVal){
            String actual= login.getErrorMsgInvalidCredentialsLogin();
            Assert.assertEquals(actual,expectedVal);

            //System.out.println(actual);
        }

        @Then("Error msg is displayed on login only using Password as {string}")
        public void verifyErrorMsgUsingEmptyUsername(String expectVal){
            String actualVal=login.getErrorMsgOnLoginUsingPassword();
            Assert.assertEquals(actualVal,expectVal);
        }

        @Then("Error msg is displayed on login only using Username as {string}")
        public void verifyErrorMsgUsingEmptyPassword(String expectVal){
            String actualVal=login.getErrorMsgOnLoginUsingUsername();
            Assert.assertEquals(actualVal,expectVal);
        }

        @And("User clicks quick login as {string}")
        public void quickLoginAsAdmin(String quickLoginAsAdmin){
            login.clickQuickLoginAdmin();
        }




    }



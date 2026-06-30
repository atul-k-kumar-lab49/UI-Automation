package stepdefinitions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.java.en_scouse.An;
import org.testng.Assert;
import pages.CheckoutPage;
import pages.DashboardPage;
import pages.LoginPage;
import utils.ConfigReader;

public class LandingSteps {

    LoginPage login = new LoginPage();
    DashboardPage dashboard = new DashboardPage();
    CheckoutPage checkout = new CheckoutPage();

    @Then("{string} link is visible on left side navigation menu")
    public void verifyTopUpLinkDisplayed(String link){
        Assert.assertTrue(dashboard.isTopUpLinkVisible());
    }

    @And("{string} link should be clickable")
    public void verifyTopUpLinkEnabled(String link){
        Assert.assertTrue(dashboard.isTopUpLinkEnabled());
    }

    @And("User clicks on Top Up link")
    public void verifyTopUplinkIsClickable() {

        dashboard.clickTopUpLink();
    }

    @And("User enters the Top Up amount as {string} dollars")
    public void enterTopUpAmount(String topUp) {

        dashboard.enterTopUpAmount(topUp);

    }

    @And("User clicks on Proceed to Payment")
    public void clicksProceedToPaymentButton() {

        dashboard.clickProceedToPayment();

    }

    @Then("Amount to Pay value is displayed as {string}")
    public void verifyAmountToPayValue(String expectedVal){

        String actual= checkout.getPaymentSummaryAmount();
        Assert.assertEquals(actual,expectedVal);
    }

    @And("User clicks on Cancel button")
    public void clickCancelButton(){

        checkout.clickCancelBtn();
    }

    @And("User enters the Card number as {string}")
    public void enterCardNumber(String cardNum) {

        checkout.enterCardNumber(cardNum);

    }

    @And("User enters the Card holder name as {string}")
    public void enterCardHolderName(String cardHolderName) {

        checkout.enterCardHolderName(cardHolderName);

    }

    @And("User enters the Card expiry date as {string}")
    public void enterCardExpiryDate(String cardExpiryDate) {

        checkout.enterCardExpiryDate(cardExpiryDate);

    }

    @And("User enters the cvv as {string}")
    public void enterCardCvv(String cvv) {

        checkout.enterCvv(cvv);

    }

    @And("User clicks the Pay button")
    public void clickPayButton(){

        checkout.clickPayBtn();
    }

    @Then("Top Up success msg should be displayed as {string}")
    public void verifySuccessMsg(String expectedVal){

        String actual= dashboard.getTopUpSuccessMsg();
        Assert.assertEquals(actual,expectedVal);
    }
}

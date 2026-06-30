package stepdefinitions;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import org.testng.Assert;
import pages.CheckoutPage;
import pages.DashboardPage;
import pages.LoginPage;

public class CheckoutSteps {

    LoginPage login = new LoginPage();
    DashboardPage dashboard = new DashboardPage();
    CheckoutPage checkout = new CheckoutPage();

    @Then("Entering Card Number input field is enabled")
    public void verifyCardNumberInputFieldIsEnabled(){
        Assert.assertTrue(checkout.isCardNumberFieldEnabled());
    }

    @And("Entering Card Holder Name input field is displayed")
    public void verifyCardHolderNameIsDisplayed(){
        Assert.assertTrue(checkout.isCardHolderNameFieldDisplayed());
    }

    @And("Entering Card Expiry Date input field is enabled")
    public void verifyCardExpiryDateIsEnabled(){
        Assert.assertTrue(checkout.isCardExpiryDateFieldEnabled());
    }

    @And("Entering Card cvv input field is enabled")
    public void verifyCardCvvIsEnabled(){
        Assert.assertTrue(checkout.isCardCvvFieldEnabled());
    }

    @And("Entering Card pay button is displayed")
    public void verifyCardPayBtnDisplayed(){
        Assert.assertTrue(checkout.isCardPayButtonDisplayed());
    }
}

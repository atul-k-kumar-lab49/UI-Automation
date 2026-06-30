package pages;

import org.openqa.selenium.By;

public class CheckoutPage extends BasePage {

    //  Locators
    private By paymentsummaryLabel = By.xpath("//div[@class='summary-label']");
    private By paymentsummaryamount = By.xpath("//div[@class='summary-amount']");
    private By cardNumberInput = By.xpath("//input[@id='cardNumber']");
    private By cardHolderNameInput = By.xpath("//input[@id='cardholderName']");
    private By expiryDateInput = By.xpath("//input[@id='expiry']");
    private By cvvInput = By.xpath("//input[@id='cvv']");
    private By payBtn = By.xpath("//button[contains(@class,'pay')]");
    private By cancelBtn = By.xpath("//button[contains(@class,'cancel')]");

    //  Actions / Validations
    public String getPaymentSummaryLabel() {
        return getText(paymentsummaryLabel);
    }

    public String getPaymentSummaryAmount() {
        return getText(paymentsummaryamount);
    }

    public void enterCardNumber(String cardNum) {
        type(cardNumberInput, cardNum);
    }

    public void enterCardHolderName(String cardholderName) {
        type(cardHolderNameInput, cardholderName);
    }

    public void enterCardExpiryDate(String cardExpiryDate) {
        type(expiryDateInput, cardExpiryDate);
    }

    public void enterCvv(String cvv) {
        type(cvvInput, cvv);
    }


    public void clickPayBtn() {
        click(payBtn);
    }

    public void clickCancelBtn() {
        click(cancelBtn);
    }

    public boolean isCardNumberFieldEnabled() {
        return isEnabled(cardNumberInput);
    }

    public boolean isCardHolderNameFieldDisplayed() {
        return isVisible(cardHolderNameInput);
    }

    public boolean isCardExpiryDateFieldEnabled() {
        return isEnabled(expiryDateInput);
    }

    public boolean isCardCvvFieldEnabled() {
        return isEnabled(cvvInput);
    }

    public boolean isCardPayButtonDisplayed() {
        return isVisible(payBtn);
    }

    public boolean isCardCancelButtonDisplayed() {
        return isVisible(cancelBtn);
    }



}
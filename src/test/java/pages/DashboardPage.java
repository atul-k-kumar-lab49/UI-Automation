
package pages;

import org.openqa.selenium.By;

public class DashboardPage extends BasePage {

    //  Locators
    private By dashboardLink = By.xpath("//a[contains(@href,'dash')]");
    private By dashboardText = By.xpath("//a[contains(@href,'dash')]//span");
    private By username = By.xpath("//div[@class='user-name']");
    private By topupLink = By.xpath("//a[contains(@href,'top')]");
    private By topupamountfield = By.xpath("//input[@id='amount']");
    private By proceedtopaymentBtn = By.xpath("//button[contains(text(),'Payment')]");
    private By topUpSuccessMsg = By.xpath("//div[@class='alert alert-success']//span");

    //  Actions / Validations
    public boolean isDashboardVisible() {
        return isVisible(dashboardLink);   //  generic reuse
    }

    public String getDashboardText() {
        return getText(dashboardText);
    }

    public String getUsername() {
        return getText(username);
    }

    public boolean isTopUpLinkVisible(){
        return isVisible(topupLink);
    }

    public boolean isTopUpLinkEnabled(){
        return isEnabled(topupLink);
    }

    public void clickTopUpLink(){
        click(topupLink);
    }

    public void enterTopUpAmount(String topUpAmount){
        type(topupamountfield, topUpAmount);

    }

    public void clickProceedToPayment(){
        click(proceedtopaymentBtn);
    }

    public String getTopUpSuccessMsg(){
      return  getText(topUpSuccessMsg);
    }
}

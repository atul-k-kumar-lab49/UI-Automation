package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.testng.Assert;

public class LoginPage extends BasePage {

    //  Locators (kept inside page)
    private By quickLoginUserBtn = By.xpath("//button[contains(text(),'User')]");
    public By vb_logo_title=By.xpath("//div[@class='logo-icon-large']/following-sibling::h1");
    public By vb_logo_icon=By.xpath("//div[@class='logo-icon-large']");
    private By vb_logo_subtitle=By.xpath("//div[@class='logo-icon-large']/following-sibling::p");
    private By username_field=By.xpath("//input[@name='username']");
    private By password_field=By.xpath("//input[@name='password']");
    private By login_btn=By.xpath("//button[@type='submit']");
    private By quick_login_for_testing_txt=By.xpath("//div[@class='quick-login']//p");
    private By login_as_user=By.xpath("//div[@class='quick-login-buttons']//button[contains(text(),'User')]");
    private By login_as_admin=By.xpath("//div[@class='quick-login-buttons']//button[contains(text(),'Admin')]");
    private By register_link=By.xpath("//div[@class='auth-footer']//a");
    private By errormsg_InvalidCreds=By.xpath("//div[@class='error-message']");


    //  Page Actions (reusable)
    public void navigateToUrl(String url) {
        getDriver().get(url);
    }

    public void clickQuickLoginUser() {
        click(quickLoginUserBtn);
    }

    public boolean isLogoVisible()
    {
        return isVisible(vb_logo_icon);
    }

    public String actualLogoTitle(){

        return getText(vb_logo_title);

    }

    public String vbLogoSubtitle(){
        return getText(vb_logo_subtitle);
    }


    public boolean isUsernameFieldVisible(){
        return isVisible(username_field);
    }

    public boolean isPasswordFieldVisible(){
        return isVisible(password_field);
    }

    public boolean isLoginButtonVisible(){
        return isVisible(login_btn);
    }
    public String quickLoginTesting_Txt(){
        return getText(quick_login_for_testing_txt);
    }

    public boolean isQuickLoginUserBtnVisible(){

        return isVisible(quickLoginUserBtn);
    }

    public boolean isQuickLoginAdminBtnVisible(){

        return isVisible(login_as_admin);
    }

    public boolean isRegisterLinkVisible(){

        return isVisible(register_link);
    }

    public void enterUserName(String username){
        type(username_field, username);

    }

    public void enterPassword(String password){
        type(password_field, password);

    }

    public void clickLogin(){
        click(login_btn);
    }

    public String getErrorMsgInvalidCredentialsLogin(){

        return getText(errormsg_InvalidCreds);
    }


    public String getErrorMsgOnLoginUsingPassword(){

        return getAttribute(username_field);

    }
    public String getErrorMsgOnLoginUsingUsername(){

        return getAttribute(password_field);

    }

    public void clickQuickLoginAdmin() {
        click(login_as_admin);
    }
}
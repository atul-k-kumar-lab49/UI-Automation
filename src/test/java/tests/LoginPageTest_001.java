package tests;

import drivers.DriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.time.Duration;

public class LoginPageTest_001 {

    //@AC1
    /* When User navigates to "app.login.url" page
     Then User should see text "VB" on page
     And User should see text "Secure Banking at Your Fingertips" on page
     And User should see "LoginPage.Input.username" element
     And User should see "LoginPage.Input.password" element
     And User should see "LoginPage.Button.login" element
     And User should see text "Quick Login (For Testing)" on page
     And User should see "LoginPage.Button.quickLoginUser" element
     And User should see "LoginPage.Button.quickLoginAdmin" element
     And User should see "LoginPage.Link.register" element*/

    @BeforeMethod
    public void setUp() {
        DriverManager.initDriver("chrome");
    }

    @AfterMethod
    public void tearDown() {
        DriverManager.quitDriver();
    }

    private WebDriver getDriver() {
        return DriverManager.getDriver();
    }

    private WebDriverWait getWait() {
        return new WebDriverWait(getDriver(), Duration.ofSeconds(10));
    }

    @Test
    public void checkLoginPage() {
        getDriver().get("https://vb-bank-demo.vercel.app/login");
        getDriver().manage().window().maximize();

        WebElement vb_logo_icon = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='logo-icon-large']")));
        WebElement vb_logo_title = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='logo-icon-large']/following-sibling::h1")));
        WebElement vb_logo_subtitle = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='logo-icon-large']/following-sibling::p")));
        WebElement username_field = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@name='username']")));
        WebElement password_field = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@name='password']")));
        WebElement login_btn = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//button[@type='submit']")));
        WebElement quick_login_for_testing_txt = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='quick-login']//p")));
        WebElement login_as_user = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='quick-login-buttons']//button[contains(text(),'User')]")));
        WebElement login_as_admin = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='quick-login-buttons']//button[contains(text(),'Admin')]")));
        WebElement register_link = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='auth-footer']//a")));

        Assert.assertTrue(vb_logo_icon.isDisplayed());
        Assert.assertEquals(vb_logo_title.getText(), "VB Bank");
        Assert.assertEquals(vb_logo_subtitle.getText(), "Secure Banking at Your Fingertips");
        Assert.assertTrue(username_field.isDisplayed());
        Assert.assertTrue(password_field.isDisplayed());
        Assert.assertTrue(login_btn.isDisplayed());
        Assert.assertEquals(quick_login_for_testing_txt.getText(), "QUICK LOGIN (FOR TESTING)");
        Assert.assertTrue(login_as_user.isDisplayed());
        Assert.assertTrue(login_as_admin.isDisplayed());
        Assert.assertTrue(register_link.isDisplayed());
        Assert.assertTrue(username_field.isEnabled());
    }

    @Test
    public void loginVisibleFieldsValidation() {
        getDriver().get("https://vb-bank-demo.vercel.app/login");
        getDriver().manage().window().maximize();

        Assert.assertEquals(getDriver().getTitle(), "VB Bank - Premium Banking Experience");
        Assert.assertEquals(getDriver().getCurrentUrl(), "https://vb-bank-demo.vercel.app/login");

        WebElement username_label = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@name='username']/preceding-sibling::label")));
        Assert.assertEquals(username_label.getText(), "Username");
        Assert.assertTrue(username_label.isDisplayed());

        String loginbtnTxt = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//button[@type='submit']"))).getText();
        System.out.println(loginbtnTxt);
        Assert.assertEquals(loginbtnTxt, "Login");
    }

    @Test
    public void loginWithBlankCredentials() {
        getDriver().get("https://vb-bank-demo.vercel.app/login");
        getDriver().manage().window().maximize();

        WebElement username_field = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@name='username']")));
        WebElement password_field = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//input[@name='password']")));
        WebElement login_btn = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//button[@type='submit']")));

        username_field.sendKeys("");
        password_field.sendKeys("");
        login_btn.click();

        String message = username_field.getAttribute("validationMessage");
        System.out.println(message);
        Assert.assertEquals(message, "Please fill out this field.");
        Assert.assertFalse(message.isBlank());

        username_field.sendKeys("Test");
        login_btn.click();
        String password_msg = password_field.getAttribute("validationMessage");
        System.out.println(password_msg);
        Assert.assertEquals(password_msg, "Please fill out this field.");
        //Assert.assertEquals(password_msg,"tests");
    }
}

package tests;

import drivers.DriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.testng.Assert;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import java.time.Duration;

/*
*   @AC2
  Scenario: User can login successfully using Quick Login as User
    When User navigates to "app.login.url" page
    And User clicks on "LoginPage.Button.quickLoginUser" button
    Then User waits for "DashboardPage.Link.dashboard" element to be visible
    And User should see text "John Doe" on page*/

public class LandingPageTest_001 {

    private static final Logger log = LoggerFactory.getLogger(LandingPageTest_001.class);

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
    public void verifyLandingPage() {
        getDriver().get("https://vb-bank-demo.vercel.app/login");
        getDriver().manage().window().maximize();

        WebElement login_as_user = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='quick-login-buttons']//button[contains(text(),'User')]")));
        Assert.assertTrue(login_as_user.isDisplayed());
        Assert.assertTrue(login_as_user.isEnabled());
        login_as_user.click();

        WebElement dashboard_link = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//nav[@class='sidebar-nav']//a[contains(@href,'dash')]")));
        Assert.assertTrue(dashboard_link.isDisplayed());
        Assert.assertTrue(dashboard_link.isEnabled());
        Assert.assertEquals(getDriver().findElement(By.xpath("//nav[@class='sidebar-nav']//a[contains(@href,'dash')]//span")).getText(), "Dashboard");

        WebElement logged_in_username = getWait().until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='user-name']")));
        Assert.assertEquals(logged_in_username.getText(), "John Doe");
    }
}

package pages;

import drivers.DriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.support.ui.*;

import java.time.Duration;

public class BasePage {

    // Always resolved from ThreadLocal — safe for parallel execution
    protected WebDriver getDriver() {
        return DriverManager.getDriver();
    }

    protected WebDriverWait getWait() {
        return new WebDriverWait(getDriver(), Duration.ofSeconds(30));
    }

    //  Generic Click
    public void click(By locator) {
        getWait().until(ExpectedConditions.elementToBeClickable(locator)).click();
    }

    // Generic SendKeys
    public void type(By locator, String text) {
        WebElement element = getWait().until(ExpectedConditions.visibilityOfElementLocated(locator));
        element.clear();
        element.sendKeys(text);
    }

    //  Generic Get Text
    public String getText(By locator) {
        return getWait().until(ExpectedConditions.visibilityOfElementLocated(locator)).getText();
    }

    //  Generic Visibility Check
    public boolean isVisible(By locator) {
        return getWait().until(ExpectedConditions.visibilityOfElementLocated(locator)).isDisplayed();
    }

    public boolean isPresent(By locator) {
        try {
            getWait().until(ExpectedConditions.presenceOfElementLocated(locator));
            return true;
        } catch (TimeoutException e) {
            return false;
        }
    }

    public boolean isDisplayed(By locator) {
        return getWait().until(ExpectedConditions.presenceOfElementLocated(locator)).isDisplayed();
    }

    //  Generic Attribute Check
    public String getAttribute(By locator) {
        return getWait().until(ExpectedConditions.visibilityOfElementLocated(locator)).getAttribute("validationMessage");
    }

    public boolean isEnabled(By locator) {
        return getWait().until(ExpectedConditions.visibilityOfElementLocated(locator)).isEnabled();
    }

    //  Generic Wait
    public void waitForVisibility(By locator) {
        getWait().until(ExpectedConditions.visibilityOfElementLocated(locator));
    }
}

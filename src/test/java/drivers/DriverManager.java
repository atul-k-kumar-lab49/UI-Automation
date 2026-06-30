package drivers;

import io.opentelemetry.exporter.logging.SystemOutLogRecordExporter;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class DriverManager {

    private static ThreadLocal<WebDriver> driver= new ThreadLocal<>();

    public static WebDriver getDriver(){

        return driver.get();
    }

    public static void initDriver(String browser){


        switch (browser.toLowerCase()) {

            case "chrome":
                driver.set(new ChromeDriver());
                break;

            default:
                throw new RuntimeException("Browser not supported");
        }

        getDriver().manage().window().maximize();

    }

    public static void quitDriver(){

        if(getDriver()!=null){

            getDriver().quit();
            driver.remove();

        } else if (getDriver()==null) {
           String driverName= driver.getClass().getName();




        }

    }

}

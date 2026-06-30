package hooks;

import drivers.DriverManager;
import utils.ConfigReader;
import io.cucumber.java.*;

public class Hooks {


    @Before
    public void setUp() {
        DriverManager.initDriver(ConfigReader.get("browser"));
    }

    @After
    public void tearDown() {
        DriverManager.quitDriver();
    }


}

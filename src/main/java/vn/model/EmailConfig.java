package vn.model;
import java.io.InputStream;
import java.util.Properties;
public class EmailConfig {
    private static String EMAIL;
    private static String APP_PASSWORD;

    static {
        try (InputStream is = EmailConfig.class
                .getClassLoader()
                .getResourceAsStream("config.properties")) {

            Properties props = new Properties();
            props.load(is);

            EMAIL = props.getProperty("EMAIL");
            APP_PASSWORD = props.getProperty("APP_PASSWORD");

        } catch (Exception e) {
            throw new RuntimeException("Không đọc được config.properties", e);
        }
    }

    public static String getEmail() {
        return EMAIL;
    }

    public static String getAppPassword() {
        return APP_PASSWORD;
    }
}

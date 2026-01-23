package vn.dao;

import java.io.InputStream;
import java.util.Properties;

public class DBProperties {

    private static final Properties prop = new Properties();

    static {
        try (InputStream is =
                     DBProperties.class.getClassLoader().getResourceAsStream("db.properties")) {

            if (is == null) {
                throw new RuntimeException("❌ Không tìm thấy file db.properties");
            }
            prop.load(is);

        } catch (Exception e) {
            throw new RuntimeException("❌ Lỗi load db.properties", e);
        }
    }

    public static String host() {
        return prop.getProperty("db.host", "localhost");
    }

    public static int port() {
        try {
            return Integer.parseInt(prop.getProperty("db.port", "3306"));
        } catch (NumberFormatException e) {
            return 3306;
        }
    }

    public static String username() {
        return prop.getProperty("db.username", "root");
    }

    public static String password() {
        return prop.getProperty("db.password", "");
    }

    public static String dbname() {
        return prop.getProperty("db.name");
    }

    public static String option() {
        return prop.getProperty("db.option", "");
    }
}

package vn.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://" + DBProperties.host() + ":" +
                    DBProperties.port() + "/" +
                    DBProperties.dbname() + "?" +
                    DBProperties.option();

            return DriverManager.getConnection(
                    url,
                    DBProperties.username(),
                    DBProperties.password()
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}

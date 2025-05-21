package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {

	private static final String DB_URL = "jdbc:mysql://localhost:3306/emsproject";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load JDBC driver once
        } catch (ClassNotFoundException e) {
            System.err.println("❌ JDBC Driver not found!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
}

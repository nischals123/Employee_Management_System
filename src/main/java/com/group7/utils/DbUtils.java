package com.group7.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtils {

    private static final String URL = "jdbc:mysql://localhost:3306/emsproject";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try{
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

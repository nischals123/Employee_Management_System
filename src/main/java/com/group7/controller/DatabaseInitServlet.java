package com.group7.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.Statement;
import java.util.stream.Collectors;

import com.group7.utils.DbUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DatabaseInitServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");

        try {
            // Read SQL script from resources
            String sqlScript;
            try (InputStream inputStream = getServletContext().getResourceAsStream("/WEB-INF/classes/database.sql");
                    BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
                sqlScript = reader.lines().collect(Collectors.joining("\n"));
            }

            // Split script into individual statements
            String[] statements = sqlScript.split(";");

            // Execute each statement
            try (Connection conn = DbUtils.getConnection()) {
                Statement stmt = conn.createStatement();

                for (String statement : statements) {
                    if (!statement.trim().isEmpty()) {
                        stmt.execute(statement);
                    }
                }

                response.getWriter().println("<h2>Database initialized successfully!</h2>");
                response.getWriter()
                        .println("<p>The database schema has been created and populated with initial data.</p>");
                response.getWriter().println("<p><a href='index.jsp'>Go to Home Page</a></p>");
            }
        } catch (Exception e) {
            response.getWriter().println("<h2>Error initializing database</h2>");
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace(response.getWriter());
        }
    }
}

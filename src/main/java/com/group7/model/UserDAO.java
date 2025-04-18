package com.group7.model;

import com.group7.utils.DbUtils;

import java.sql.*;

public class UserDAO {

    // Register User Method
    public static boolean registerUser(User user) {
        boolean result = false;
        
        System.out.println("Data got");

        String query = "INSERT INTO users (name, email, password, phone, picture_path, role, is_active, is_deleted, department_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
        	ps.setString(1, user.getName());
        	ps.setString(2, user.getEmail());
        	ps.setString(3, user.getPassword());
        	ps.setString(4, user.getPhone());
        	ps.setString(5, user.getPicturePath());
        	ps.setInt(6, user.getRole());
        	ps.setBoolean(7, true);  // is_active
        	ps.setBoolean(8, false); // is_deleted
        	ps.setInt(9, user.getDepartmentId());

        	System.out.println("Inserted successfully ✅");

            int rows = ps.executeUpdate();
            result = rows > 0;
            System.out.println("✅ SQL rows inserted: " + rows);

        } catch (SQLIntegrityConstraintViolationException e) {
            System.out.println("Email already exists: " + e.getMessage());
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("General SQL Error: " + e.getMessage());
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return result;
    }

// Validate User on Login
    public static User validateUser(String email, String password) {
        User user = null;
        String query = "SELECT * FROM users WHERE email=? AND password=? AND is_deleted=FALSE";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setPicturePath(rs.getString("picture_path"));
                user.setRole(rs.getInt("role"));
                user.setActive(rs.getBoolean("is_active"));
                user.setDepartmentId(rs.getInt("department_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

// Get User By Email (Session Refresh)
    public static User getUserByEmail(String email) {
        User user = null;
        String query = "SELECT * FROM users WHERE email=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setPicturePath(rs.getString("picture_path"));
                user.setRole(rs.getInt("role"));
                user.setActive(rs.getBoolean("is_active"));
                user.setDepartmentId(rs.getInt("department_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}

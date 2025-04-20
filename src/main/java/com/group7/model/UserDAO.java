package com.group7.model;

import com.group7.utils.DbUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Register User Method
	public static boolean registerUser(User user) {
	    boolean result = false;

	    System.out.println("UserDAO.registerUser called");
	    System.out.println("User data: " + user.getName() + ", " + user.getEmail());

	    String query = "INSERT INTO users (name, email, password, phone, picture_path, role, is_active, is_deleted, department_id, hire_date) " +
	            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	    try (Connection conn = DbUtils.getConnection()) {
	        System.out.println("Database connection established");
	        
	        PreparedStatement ps = conn.prepareStatement(query);
	        ps.setString(1, user.getName());
	        ps.setString(2, user.getEmail());
	        ps.setString(3, user.getPassword());
	        ps.setString(4, user.getPhone());
	        ps.setString(5, user.getPicturePath());
	        ps.setInt(6, user.getRole().getId());
	        ps.setBoolean(7, user.isActive());
	        ps.setBoolean(8, false); // is_deleted
	        ps.setInt(9, user.getDepartmentId());
	        ps.setDate(10, user.getHireDate());
//	        ps.setBigDecimal(11, user.getSalary());

	        System.out.println("Prepared statement created: " + ps);

	        int rows = ps.executeUpdate();
	        result = rows > 0;
	        System.out.println("SQL rows inserted: " + rows);

	    } catch (SQLIntegrityConstraintViolationException e) {
	        System.out.println("SQL Constraint Violation: " + e.getMessage());
	        e.printStackTrace();
	    } catch (SQLException e) {
	        System.out.println("SQL Error: " + e.getMessage());
	        e.printStackTrace();
	    } catch (ClassNotFoundException e) {
	        System.out.println("Class Not Found: " + e.getMessage());
	        e.printStackTrace();
	    } catch (Exception e) {
	        System.out.println("Unexpected error: " + e.getMessage());
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
                user = mapUserFromResultSet(rs);

                // Load department details
                Department department = DepartmentDAO.getDepartmentById(user.getDepartmentId());
                user.setDepartment(department);
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
                user = mapUserFromResultSet(rs);

                // Load department details
                Department department = DepartmentDAO.getDepartmentById(user.getDepartmentId());
                user.setDepartment(department);
            }

            System.out.println(ps);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // Get User By ID
    public static User getUserById(int id) {
        User user = null;
        String query = "SELECT * FROM users WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = mapUserFromResultSet(rs);

                // Load department details
                Department department = DepartmentDAO.getDepartmentById(user.getDepartmentId());
                user.setDepartment(department);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // Get All Users
    public static List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE is_deleted=FALSE ORDER BY name";

        try (Connection conn = DbUtils.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                User user = mapUserFromResultSet(rs);
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // Get Users By Department
    public static List<User> getUsersByDepartment(int departmentId) {
        List<User> users = new ArrayList<>();
        String query = "SELECT * FROM users WHERE department_id=? AND is_deleted=FALSE ORDER BY name";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, departmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = mapUserFromResultSet(rs);
                users.add(user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    // Update User
    public static boolean updateUser(User user) {
        boolean result = false;
        String query = "UPDATE users SET name=?, email=?, phone=?, picture_path=?, role=?, is_active=?, department_id=?, hire_date=?, salary=? WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPicturePath());
            ps.setInt(5, user.getRole().getId());
            ps.setBoolean(6, user.isActive());
            ps.setInt(7, user.getDepartmentId());
            ps.setDate(8, user.getHireDate());
//            ps.setBigDecimal(9, user.getSalary());
            ps.setInt(10, user.getId());

            int rows = ps.executeUpdate();
            result = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Update User Password
    public static boolean updatePassword(int userId, String newPassword) {
        boolean result = false;
        String query = "UPDATE users SET password=? WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);

            int rows = ps.executeUpdate();
            result = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Soft Delete User (set is_deleted to true)
    public static boolean deleteUser(int userId) {
        boolean result = false;
        String query = "UPDATE users SET is_deleted=TRUE WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);

            int rows = ps.executeUpdate();
            result = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Helper method to map ResultSet to User object
    private static User mapUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setPhone(rs.getString("phone"));
        user.setPicturePath(rs.getString("picture_path"));

        // Set Role object from DB role ID
        user.setRole(new Role(rs.getInt("role")));

        user.setActive(rs.getBoolean("is_active"));
        user.setDeleted(rs.getBoolean("is_deleted"));
        user.setDepartmentId(rs.getInt("department_id"));
        user.setHireDate(rs.getDate("hire_date"));
//        user.setSalary(rs.getBigDecimal("salary"));
        user.setCreatedAt(rs.getTimestamp("created_at"));

        return user;
    }
}

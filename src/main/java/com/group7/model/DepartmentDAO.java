package com.group7.model;

import com.group7.utils.DbUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDAO {

    // Get all departments
    public static List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        String query = "SELECT * FROM departments WHERE 1";

        try (Connection conn = DbUtils.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Department department = new Department();
                department.setId(rs.getInt("id"));
                department.setName(rs.getString("name"));
                department.setDescription(rs.getString("description"));
                department.setManagerId(rs.getInt("manager_id"));
                department.setCreatedAt(rs.getTimestamp("created_at"));
                departments.add(department);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return departments;
    }

    // Get department by ID
    public static Department getDepartmentById(int id) {
        Department department = null;
        String query = "SELECT * FROM departments WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                department = new Department();
                department.setId(rs.getInt("id"));
                department.setName(rs.getString("name"));
                department.setDescription(rs.getString("description"));
                department.setManagerId(rs.getInt("manager_id"));
                department.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return department;
    }

    // Add new department
    public static boolean addDepartment(Department department) {
        boolean result = false;
        String query = "INSERT INTO departments (name, description, manager_id) VALUES (?, ?, ?)";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            ps.setInt(3, department.getManagerId());

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Update department
    public static boolean updateDepartment(Department department) {
        boolean result = false;
        String query = "UPDATE departments SET name=?, description=?, manager_id=? WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, department.getName());
            ps.setString(2, department.getDescription());
            ps.setInt(3, department.getManagerId());
            ps.setInt(4, department.getId());

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Delete department
    public static boolean deleteDepartment(int id) {
        boolean result = false;
        String query = "DELETE FROM departments WHERE id=?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
}

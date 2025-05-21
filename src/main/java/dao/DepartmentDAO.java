package dao;

import model.Department;
import utils.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDAO {

    public static List<Department> getAllDepartments() {
        List<Department> departments = new ArrayList<>();
        String query = "SELECT * FROM departments";

        try (Connection conn = DbUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Department department = new Department();
                department.setId(rs.getInt("id"));
                department.setName(rs.getString("name"));
                departments.add(department);
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching all departments:");
            e.printStackTrace();
        }

        return departments;
    }

    public Department getDepartmentById(int id) {
        Department department = null;
        String query = "SELECT * FROM departments WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    department = new Department();
                    department.setId(rs.getInt("id"));
                    department.setName(rs.getString("name"));
                }
            }

        } catch (SQLException e) {
            System.err.println("❌ Error fetching department by ID:");
            e.printStackTrace();
        }

        return department;
    }

    public boolean addDepartment(Department department) {
        String query = "INSERT INTO departments (name) VALUES (?)";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, department.getName());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error adding department:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateDepartment(Department department) {
        String query = "UPDATE departments SET name = ? WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, department.getName());
            ps.setInt(2, department.getId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error updating department:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteDepartment(int id) {
        String query = "DELETE FROM departments WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error deleting department:");
            e.printStackTrace();
            return false;
        }
    }
}

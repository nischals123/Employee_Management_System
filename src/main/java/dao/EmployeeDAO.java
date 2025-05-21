package dao;

import model.Department;
import model.Employee;
import utils.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    public List<Employee> getEmployees(String search, String department, String role, String status, int page, int pageSize) {
        List<Employee> employees = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT u.*, d.name AS department_name FROM users u " +
            "LEFT JOIN departments d ON u.department_id = d.id " +
            "WHERE u.is_deleted = 0");

        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            query.append(" AND (u.name LIKE ? OR u.email LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        if (department != null && !department.isEmpty()) {
            query.append(" AND u.department_id = ?");
            params.add(Integer.parseInt(department));
        }
        if (role != null && !role.isEmpty()) {
            query.append(" AND u.role = ?");
            params.add(Integer.parseInt(role));
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND u.is_active = ?");
            params.add(status.equalsIgnoreCase("active") ? 1 : 0);
        }

        query.append(" ORDER BY u.id DESC LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Employee employee = extractEmployeeFromResultSet(rs);
                    employees.add(employee);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error retrieving employee list:");
            e.printStackTrace();
        }

        return employees;
    }

    public int getTotalEmployees(String search, String department, String role, String status) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM users u WHERE u.is_deleted = 0");
        List<Object> params = new ArrayList<>();

        if (search != null && !search.trim().isEmpty()) {
            query.append(" AND (u.name LIKE ? OR u.email LIKE ?)");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        if (department != null && !department.isEmpty()) {
            query.append(" AND u.department_id = ?");
            params.add(Integer.parseInt(department));
        }
        if (role != null && !role.isEmpty()) {
            query.append(" AND u.role = ?");
            params.add(Integer.parseInt(role));
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND u.is_active = ?");
            params.add(status.equalsIgnoreCase("active") ? 1 : 0);
        }

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error counting employees:");
            e.printStackTrace();
        }

        return 0;
    }

    public Employee getEmployeeById(int id) {
        String query = "SELECT u.*, d.name AS department_name FROM users u " +
                       "LEFT JOIN departments d ON u.department_id = d.id " +
                       "WHERE u.id = ? AND u.is_deleted = 0";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractEmployeeFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("❌ Error fetching employee by ID:");
            e.printStackTrace();
        }

        return null;
    }

    public boolean addEmployee(Employee employee) {
        String query = "INSERT INTO users (name, email, password, phone, picture_path, role, is_active, department_id, hire_date) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, employee.getName());
            ps.setString(2, employee.getEmail());
            ps.setString(3, employee.getPassword());
            ps.setString(4, employee.getPhone());
            ps.setString(5, employee.getPicturePath());
            ps.setInt(6, employee.getRole());
            ps.setBoolean(7, employee.isActive());
            ps.setInt(8, employee.getDepartmentId());
            ps.setDate(9, employee.getHireDate());
            
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error adding employee:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateEmployee(Employee employee) {
        String query = "UPDATE users SET name = ?, email = ?, phone = ?, picture_path = ?, " +
                       "role = ?, is_active = ?, department_id = ?, hire_date = ? WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, employee.getName());
            ps.setString(2, employee.getEmail());
            ps.setString(3, employee.getPhone());
            ps.setString(4, employee.getPicturePath());
            ps.setInt(5, employee.getRole());
            ps.setBoolean(6, employee.isActive());
            ps.setInt(7, employee.getDepartmentId());
            ps.setDate(8, employee.getHireDate());
            ps.setInt(9, employee.getId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error updating employee:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEmployee(int id) {
        String query = "UPDATE users SET is_deleted = 1 WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("❌ Error deleting employee:");
            e.printStackTrace();
            return false;
        }
    }

    private Employee extractEmployeeFromResultSet(ResultSet rs) throws SQLException {
        Employee emp = new Employee();
        emp.setId(rs.getInt("id"));
        emp.setName(rs.getString("name"));
        emp.setEmail(rs.getString("email"));
        emp.setPhone(rs.getString("phone"));
        emp.setPicturePath(rs.getString("picture_path"));
        emp.setDeleted(rs.getInt("is_deleted") == 1);
        emp.setActive(rs.getInt("is_active") == 1);
        emp.setRole(rs.getInt("role"));
        emp.setDepartmentId(rs.getInt("department_id"));
        emp.setHireDate(rs.getDate("hire_date"));
        emp.setCreatedAt(rs.getTimestamp("created_at"));

        Department dept = new Department();
        dept.setId(rs.getInt("department_id"));
        dept.setName(rs.getString("department_name"));
        emp.setDepartment(dept);

        return emp;
    }
}

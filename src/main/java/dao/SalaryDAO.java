package dao;

import model.Salary;
import utils.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SalaryDAO {

    /**
     * Get all salaries with user information
     */
    public static List<Salary> getAllSalariesWithUserInfo() {
        List<Salary> salaries = new ArrayList<>();
        String sql = "SELECT s.*, u.name as name " +
                "FROM salary s " +
                "JOIN users u ON s.user_id = u.id " +
                "ORDER BY s.id DESC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Salary salary = new Salary();
                salary.setId(rs.getInt("id"));
                salary.setUserId(rs.getInt("user_id"));
                salary.setMonth(rs.getString("month"));
                salary.setAmount(rs.getDouble("amount"));
                salary.setStatus(rs.getString("status"));
                salaries.add(salary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return salaries;
    }

    /**
     * Add a new salary record
     */
    public static boolean addSalary(Salary salary) {
        String sql = "INSERT INTO salary (user_id, month, amount, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, salary.getUserId());
            stmt.setString(2, salary.getMonth());
            stmt.setDouble(3, salary.getAmount());
            stmt.setString(4, salary.getStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update an existing salary record
     */
    public static boolean updateSalary(Salary salary) {
        String sql = "UPDATE salary SET user_id = ?, month = ?, amount = ?, status = ? WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, salary.getUserId());
            stmt.setString(2, salary.getMonth());
            stmt.setDouble(3, salary.getAmount());
            stmt.setString(4, salary.getStatus());
            stmt.setInt(5, salary.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a salary record by ID
     */
    public static boolean deleteSalary(int id) {
        String sql = "DELETE FROM salary WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get a salary by ID
     */
    public static Salary getSalaryById(int id) {
        String sql = "SELECT s.*, CONCAT(u.first_name, ' ', u.last_name) as user_name " +
                "FROM salary s " +
                "JOIN users u ON s.user_id = u.id " +
                "WHERE s.id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Salary salary = new Salary();
                    salary.setId(rs.getInt("id"));
                    salary.setUserId(rs.getInt("user_id"));
                    salary.setMonth(rs.getString("month"));
                    salary.setAmount(rs.getDouble("amount"));
                    salary.setStatus(rs.getString("status"));
                    salary.setUserName(rs.getString("user_name"));

                    return salary;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Check if salary exists for user and month
     */
    public static boolean salaryExistsForUserAndMonth(int userId, String month) {
        String sql = "SELECT COUNT(*) FROM salary WHERE user_id = ? AND month = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setString(2, month);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Get salaries by user ID
     */
    public static List<Salary> getSalariesByUserId(int userId) {
        List<Salary> salaries = new ArrayList<>();
        String sql = "SELECT * FROM salary WHERE user_id = ? ORDER BY month DESC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Salary salary = new Salary();
                    salary.setId(rs.getInt("id"));
                    salary.setUserId(rs.getInt("user_id"));
                    salary.setMonth(rs.getString("month"));
                    salary.setAmount(rs.getDouble("amount"));
                    salary.setStatus(rs.getString("status"));

                    salaries.add(salary);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return salaries;
    }
}
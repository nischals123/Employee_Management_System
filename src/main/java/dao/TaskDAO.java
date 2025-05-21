package dao;

import model.Task;
import utils.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;

public class TaskDAO {

    /**
     * Get all tasks with user information
     */
    public static List<Task> getAllTasksWithUserInfo() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks ORDER BY due_date ASC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setAssignedBy(rs.getInt("assigned_by"));
                task.setAssignedTo(rs.getInt("assigned_to"));
                task.setTitle(rs.getString("title"));
                task.setDescription(rs.getString("description"));
                task.setDueDate(rs.getDate("due_date"));
                task.setStatus(rs.getString("status"));
                task.setCreatedAt(rs.getTimestamp("created_at"));

                tasks.add(task);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

    /**
     * Add a new task
     */
    public static boolean addTask(Task task) {
        String sql = "INSERT INTO tasks (assigned_by, assigned_to, title, description, due_date, status, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, NOW())";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, task.getAssignedBy());
            stmt.setInt(2, task.getAssignedTo());
            stmt.setString(3, task.getTitle());
            stmt.setString(4, task.getDescription());
            stmt.setDate(5, new java.sql.Date(task.getDueDate().getTime()));
            stmt.setString(6, task.getStatus());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Update an existing task
     */
    public static boolean updateTask(Task task) {
        String sql = "UPDATE tasks SET assigned_to = ?, title = ?, description = ?, " +
                "due_date = ?, status = ? WHERE id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, task.getAssignedTo());
            stmt.setString(2, task.getTitle());
            stmt.setString(3, task.getDescription());
            stmt.setDate(4, new java.sql.Date(task.getDueDate().getTime()));
            stmt.setString(5, task.getStatus());
            stmt.setInt(6, task.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Delete a task by ID
     */
    public static boolean deleteTask(int id) {
        String sql = "DELETE FROM tasks WHERE id = ?";

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
     * Get a task by ID
     */
    public static Task getTaskById(int id) {
        String sql = "SELECT t.*, " +
                "CONCAT(u1.first_name, ' ', u1.last_name) as assigned_to_name, " +
                "CONCAT(u2.first_name, ' ', u2.last_name) as assigned_by_name " +
                "FROM tasks t " +
                "JOIN users u1 ON t.assigned_to = u1.id " +
                "JOIN users u2 ON t.assigned_by = u2.id " +
                "WHERE t.id = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setAssignedBy(rs.getInt("assigned_by"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setStatus(rs.getString("status"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));

                    task.setAssignedByName(rs.getString("assigned_to_name"));
                    task.setAssignedToName(rs.getString("assigned_by_name"));

                    return task;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Get tasks assigned to a specific user
     */
    public static List<Task> getTasksByAssignedTo(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE assigned_to = ? ORDER BY due_date ASC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setAssignedBy(rs.getInt("assigned_by"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setStatus(rs.getString("status"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));

                    tasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println(tasks);

        return tasks;
    }

    /**
     * Get tasks created by a specific user
     */
    public static List<Task> getTasksByAssignedBy(int userId) {
        return null;
    }

    /**
     * Get tasks by status
     */
    public static List<Task> getTasksByStatus(String status) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, " +
                "CONCAT(u1.first_name, ' ', u1.last_name) as assigned_to_name, " +
                "CONCAT(u2.first_name, ' ', u2.last_name) as assigned_by_name " +
                "FROM tasks t " +
                "JOIN users u1 ON t.assigned_to = u1.id " +
                "JOIN users u2 ON t.assigned_by = u2.id " +
                "WHERE t.status = ? " +
                "ORDER BY t.due_date ASC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setAssignedBy(rs.getInt("assigned_by"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setStatus(rs.getString("status"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));

                    task.setAssignedByName(rs.getString("assigned_by_name"));
                    task.setAssignedToName(rs.getString("assigned_to_name"));

                    tasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tasks;
    }

    /**
     * Count tasks by status
     */
    public static int countTasksByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM tasks WHERE status = ?";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

}
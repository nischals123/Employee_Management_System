package com.group7.model;

import com.group7.utils.DbUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    // Create a new task
    public static boolean createTask(Task task) {
        boolean result = false;
        String query = "INSERT INTO tasks (title, description, project_id, assigned_to, assigned_by, due_date, priority, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setInt(3, task.getProjectId());
            ps.setInt(4, task.getAssignedTo());
            ps.setInt(5, task.getAssignedBy());
            ps.setDate(6, task.getDueDate());
            ps.setString(7, task.getPriority());
            ps.setString(8, task.getStatus());

            int rows = ps.executeUpdate();
            result = rows > 0;
            
            // Get the generated ID
            if (result) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    task.setId(generatedKeys.getInt(1));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Get tasks by project
    public static List<Task> getTasksByProject(int projectId) {
        List<Task> tasks = new ArrayList<>();
        String query = "SELECT t.*, u.name as assignee_name FROM tasks t " +
                "LEFT JOIN users u ON t.assigned_to = u.id " +
                "WHERE t.project_id = ? ORDER BY t.due_date, t.priority DESC";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, projectId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = mapTaskFromResultSet(rs);
                
                // Create a minimal user object with just the name for assignee
                User assignee = new User();
                assignee.setId(rs.getInt("assigned_to"));
                assignee.setName(rs.getString("assignee_name"));
                task.setAssignee(assignee);
                
                tasks.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tasks;
    }

    // Get tasks assigned to a user
    public static List<Task> getTasksByAssignee(int userId) {
        List<Task> tasks = new ArrayList<>();
        String query = "SELECT t.*, p.name as project_name FROM tasks t " +
                "LEFT JOIN projects p ON t.project_id = p.id " +
                "WHERE t.assigned_to = ? ORDER BY t.due_date, t.priority DESC";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Task task = mapTaskFromResultSet(rs);
                
                // Create a minimal project object with just the name
                Project project = new Project();
                project.setId(rs.getInt("project_id"));
                project.setName(rs.getString("project_name"));
                task.setProject(project);
                
                tasks.add(task);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return tasks;
    }

    // Get a task by ID
    public static Task getTaskById(int id) {
        Task task = null;
        String query = "SELECT * FROM tasks WHERE id = ?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                task = mapTaskFromResultSet(rs);
                
                // Load project details
                Project project = ProjectDAO.getProjectById(task.getProjectId());
                task.setProject(project);
                
                // Load assignee details
                User assignee = UserDAO.getUserById(task.getAssignedTo());
                task.setAssignee(assignee);
                
                // Load assigner details
                User assigner = UserDAO.getUserById(task.getAssignedBy());
                task.setAssigner(assigner);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return task;
    }

    // Update task status
    public static boolean updateTaskStatus(int taskId, String status) {
        boolean result = false;
        String query = "UPDATE tasks SET status = ? WHERE id = ?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, taskId);

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Update a task
    public static boolean updateTask(Task task) {
        boolean result = false;
        String query = "UPDATE tasks SET title = ?, description = ?, project_id = ?, assigned_to = ?, " +
                "due_date = ?, priority = ?, status = ? WHERE id = ?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setInt(3, task.getProjectId());
            ps.setInt(4, task.getAssignedTo());
            ps.setDate(5, task.getDueDate());
            ps.setString(6, task.getPriority());
            ps.setString(7, task.getStatus());
            ps.setInt(8, task.getId());

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Delete a task
    public static boolean deleteTask(int id) {
        boolean result = false;
        String query = "DELETE FROM tasks WHERE id = ?";

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

    // Helper method to map ResultSet to Task object
    private static Task mapTaskFromResultSet(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setId(rs.getInt("id"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setProjectId(rs.getInt("project_id"));
        task.setAssignedTo(rs.getInt("assigned_to"));
        task.setAssignedBy(rs.getInt("assigned_by"));
        task.setDueDate(rs.getDate("due_date"));
        task.setPriority(rs.getString("priority"));
        task.setStatus(rs.getString("status"));
        task.setCreatedAt(rs.getTimestamp("created_at"));
        return task;
    }
}

package com.group7.model;

import com.group7.utils.DbUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

    // Create a new project
    public static boolean createProject(Project project) {
        boolean result = false;
        String query = "INSERT INTO projects (name, description, start_date, end_date, status, manager_id, department_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, project.getName());
            ps.setString(2, project.getDescription());
            ps.setDate(3, project.getStartDate());
            ps.setDate(4, project.getEndDate());
            ps.setString(5, project.getStatus());
            ps.setInt(6, project.getManagerId());
            ps.setInt(7, project.getDepartmentId());

            int rows = ps.executeUpdate();
            result = rows > 0;
            
            // Get the generated ID
            if (result) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    project.setId(generatedKeys.getInt(1));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Get all projects
    public static List<Project> getAllProjects() {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM projects ORDER BY start_date DESC";

        try (Connection conn = DbUtils.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                Project project = mapProjectFromResultSet(rs);
                projects.add(project);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return projects;
    }

    // Get projects by department
    public static List<Project> getProjectsByDepartment(int departmentId) {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM projects WHERE department_id = ? ORDER BY start_date DESC";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, departmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Project project = mapProjectFromResultSet(rs);
                projects.add(project);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return projects;
    }

    // Get projects managed by a user
    public static List<Project> getProjectsByManager(int managerId) {
        List<Project> projects = new ArrayList<>();
        String query = "SELECT * FROM projects WHERE manager_id = ? ORDER BY start_date DESC";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Project project = mapProjectFromResultSet(rs);
                projects.add(project);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return projects;
    }

    // Get a project by ID
    public static Project getProjectById(int id) {
        Project project = null;
        String query = "SELECT * FROM projects WHERE id = ?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                project = mapProjectFromResultSet(rs);
                
                // Load manager details
                User manager = UserDAO.getUserById(project.getManagerId());
                project.setManager(manager);
                
                // Load department details
                Department department = DepartmentDAO.getDepartmentById(project.getDepartmentId());
                project.setDepartment(department);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return project;
    }

    // Update a project
    public static boolean updateProject(Project project) {
        boolean result = false;
        String query = "UPDATE projects SET name = ?, description = ?, start_date = ?, end_date = ?, " +
                "status = ?, manager_id = ?, department_id = ? WHERE id = ?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, project.getName());
            ps.setString(2, project.getDescription());
            ps.setDate(3, project.getStartDate());
            ps.setDate(4, project.getEndDate());
            ps.setString(5, project.getStatus());
            ps.setInt(6, project.getManagerId());
            ps.setInt(7, project.getDepartmentId());
            ps.setInt(8, project.getId());

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Delete a project
    public static boolean deleteProject(int id) {
        boolean result = false;
        String query = "DELETE FROM projects WHERE id = ?";

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

    // Helper method to map ResultSet to Project object
    private static Project mapProjectFromResultSet(ResultSet rs) throws SQLException {
        Project project = new Project();
        project.setId(rs.getInt("id"));
        project.setName(rs.getString("name"));
        project.setDescription(rs.getString("description"));
        project.setStartDate(rs.getDate("start_date"));
        project.setEndDate(rs.getDate("end_date"));
        project.setStatus(rs.getString("status"));
        project.setManagerId(rs.getInt("manager_id"));
        project.setDepartmentId(rs.getInt("department_id"));
        project.setCreatedAt(rs.getTimestamp("created_at"));
        return project;
    }
}

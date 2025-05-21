package dao;

import model.LeaveRequest;
import model.User;
import utils.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LeaveRequestDAO {

    // Submit a leave request
    public static boolean submitLeaveRequest(LeaveRequest leaveRequest) {
        boolean result = false;
        String query = "INSERT INTO leave_requests (user_id, from_date, till_date, leave_type, reason, status) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, leaveRequest.getUserId());
            ps.setDate(2, leaveRequest.getStartDate());
            ps.setDate(3, leaveRequest.getEndDate());
            ps.setString(4, leaveRequest.getLeaveType());
            ps.setString(5, leaveRequest.getReason());
            ps.setString(6, leaveRequest.getStatus());

            int rows = ps.executeUpdate();
            result = rows > 0;
            
            // Get the generated ID
            if (result) {
                ResultSet generatedKeys = ps.getGeneratedKeys();
                if (generatedKeys.next()) {
                    leaveRequest.setId(generatedKeys.getInt(1));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        return result;
    }

    // Get leave requests for a user
    public static List<LeaveRequest> getUserLeaveHistory(int userId) {
        List<LeaveRequest> leaveRequests = new ArrayList<>();
        String query = "SELECT * FROM leave_requests WHERE user_id = ? AND status = \"approved\" ORDER BY from_date DESC";

        try (Connection conn = DbUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LeaveRequest leaveRequest = mapLeaveRequestFromResultSet(rs);
                leaveRequests.add(leaveRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveRequests;
    }

    // Get all pending leave requests (for admin/manager)
    public static List<LeaveRequest> getPendingLeaveRequests() {
        List<LeaveRequest> leaveRequests = new ArrayList<>();
        String query = "SELECT lr.*, u.name as user_name FROM leave_requests lr " +
                "JOIN users u ON lr.user_id = u.id " +
                "WHERE lr.status = 'Pending' ORDER BY lr.created_at";

        try (Connection conn = DbUtil.getConnection()) {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {
                LeaveRequest leaveRequest = mapLeaveRequestFromResultSet(rs);
                
                // Create a minimal user object with just the name
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setName(rs.getString("user_name"));
                leaveRequest.setUser(user);
                
                leaveRequests.add(leaveRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveRequests;
    }

    // Get leave requests by department
    public static List<LeaveRequest> getDepartmentLeaveRequests(int departmentId) {
        List<LeaveRequest> leaveRequests = new ArrayList<>();
        String query = "SELECT lr.*, u.name as user_name FROM leave_requests lr " +
                "JOIN users u ON lr.user_id = u.id " +
                "WHERE u.department_id = ? ORDER BY lr.created_at DESC";

        try (Connection conn = DbUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, departmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                LeaveRequest leaveRequest = mapLeaveRequestFromResultSet(rs);
                
                // Create a minimal user object with just the name
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setName(rs.getString("user_name"));
                leaveRequest.setUser(user);
                
                leaveRequests.add(leaveRequest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveRequests;
    }

    // Approve or reject a leave request
    public static boolean updateLeaveRequestStatus(int leaveRequestId, String status, int approvedBy) {
        boolean result = false;
        String query = "UPDATE leave_requests SET status = ?, approved_by = ? WHERE id = ?";

        try (Connection conn = DbUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, approvedBy);
            ps.setInt(3, leaveRequestId);

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Get a leave request by ID
    public static LeaveRequest getLeaveRequestById(int id) {
        LeaveRequest leaveRequest = null;
        String query = "SELECT * FROM leave_requests WHERE id = ?";

        try (Connection conn = DbUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                leaveRequest = mapLeaveRequestFromResultSet(rs);
                
                // Load user details
                User user = UserDAO.getUserById(leaveRequest.getUserId());
                leaveRequest.setUser(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaveRequest;
    }

    // get all leave requests
    public static List<LeaveRequest> getAllLeaveRequests() {
        List<LeaveRequest> leaveRequests = new ArrayList<>();
        String query = "SELECT * FROM leave_requests";

        try(
                Connection conn = DbUtil.getConnection();
                PreparedStatement ps = conn.prepareStatement(query);
                ){
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LeaveRequest leaveRequest = mapLeaveRequestFromResultSet(rs);
                System.out.println(leaveRequest);
                leaveRequests.add(leaveRequest);
            }

            return  leaveRequests;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Helper method to map ResultSet to LeaveRequest object
    private static LeaveRequest mapLeaveRequestFromResultSet(ResultSet rs) throws SQLException {
        LeaveRequest leaveRequest = new LeaveRequest();
        leaveRequest.setId(rs.getInt("leave_request_id"));
        leaveRequest.setUserId(rs.getInt("user_id"));
        leaveRequest.setStartDate(rs.getDate("from_date"));
        leaveRequest.setEndDate(rs.getDate("till_date"));
        leaveRequest.setLeaveType(rs.getString("leave_type"));
        leaveRequest.setReason(rs.getString("reason"));
        leaveRequest.setStatus(rs.getString("status"));
        leaveRequest.setAdminRemarks(rs.getString("admin_remarks"));
        return leaveRequest;
    }

    public static boolean setActionOnLeaveRequest(int leaveRequestId, String action) {
        String query = "UPDATE leave_requests SET status = ? WHERE leave_request_id = ?";
        try (Connection conn = DbUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);){
            ps.setString(1, action);
            ps.setInt(2, leaveRequestId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

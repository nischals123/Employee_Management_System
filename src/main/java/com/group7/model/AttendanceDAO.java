package com.group7.model;

import com.group7.utils.DbUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    // Record check-in
    public static boolean recordCheckIn(int userId) {
        boolean result = false;
        String query = "INSERT INTO attendance (user_id, check_in, status) VALUES (?, NOW(), 'Present')";

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

    // Record check-out
    public static boolean recordCheckOut(int attendanceId) {
        boolean result = false;
        String query = "UPDATE attendance SET check_out = NOW() WHERE id = ? AND check_out IS NULL";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, attendanceId);

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Get today's attendance for a user
    public static Attendance getTodayAttendance(int userId) {
        Attendance attendance = null;
        String query = "SELECT * FROM attendance WHERE user_id = ? AND DATE(check_in) = CURDATE()";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                attendance = new Attendance();
                attendance.setId(rs.getInt("id"));
                attendance.setUserId(rs.getInt("user_id"));
                attendance.setCheckIn(rs.getTimestamp("check_in"));
                attendance.setCheckOut(rs.getTimestamp("check_out"));
                attendance.setStatus(rs.getString("status"));
                attendance.setNote(rs.getString("note"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return attendance;
    }

    // Get attendance history for a user
    public static List<Attendance> getUserAttendanceHistory(int userId, Date startDate, Date endDate) {
        List<Attendance> attendanceList = new ArrayList<>();
        String query = "SELECT * FROM attendance WHERE user_id = ? AND DATE(check_in) BETWEEN ? AND ? ORDER BY check_in DESC";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ps.setDate(2, startDate);
            ps.setDate(3, endDate);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setId(rs.getInt("id"));
                attendance.setUserId(rs.getInt("user_id"));
                attendance.setCheckIn(rs.getTimestamp("check_in"));
                attendance.setCheckOut(rs.getTimestamp("check_out"));
                attendance.setStatus(rs.getString("status"));
                attendance.setNote(rs.getString("note"));
                attendanceList.add(attendance);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return attendanceList;
    }

    // Update attendance status
    public static boolean updateAttendanceStatus(int attendanceId, String status, String note) {
        boolean result = false;
        String query = "UPDATE attendance SET status = ?, note = ? WHERE id = ?";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, status);
            ps.setString(2, note);
            ps.setInt(3, attendanceId);

            int rows = ps.executeUpdate();
            result = rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // Get department attendance report
    public static List<Attendance> getDepartmentAttendance(int departmentId, Date date) {
        List<Attendance> attendanceList = new ArrayList<>();
        String query = "SELECT a.* FROM attendance a " +
                "JOIN users u ON a.user_id = u.id " +
                "WHERE u.department_id = ? AND DATE(a.check_in) = ? " +
                "ORDER BY a.check_in";

        try (Connection conn = DbUtils.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, departmentId);
            ps.setDate(2, date);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance attendance = new Attendance();
                attendance.setId(rs.getInt("id"));
                attendance.setUserId(rs.getInt("user_id"));
                attendance.setCheckIn(rs.getTimestamp("check_in"));
                attendance.setCheckOut(rs.getTimestamp("check_out"));
                attendance.setStatus(rs.getString("status"));
                attendance.setNote(rs.getString("note"));
                
                // Optionally load user details
                User user = UserDAO.getUserById(rs.getInt("user_id"));
                attendance.setUser(user);
                
                attendanceList.add(attendance);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return attendanceList;
    }
}

package dao;

import model.Attendance;
import utils.DbUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {


    public static List<Attendance> getAttendence() {
          String getAttendence = "Select * from attendance";
          List<Attendance> attendanceList = new ArrayList<>();

          try(Connection con = DbUtil.getConnection();
          PreparedStatement ps = con.prepareStatement(getAttendence);){

              ResultSet rs = ps.executeQuery();

              while (rs.next()) {
                  int id = rs.getInt("id");
                  Date date = rs.getDate("date");
                  int userId = rs.getInt("user_id");
                  String status = rs.getString("status");

                  Attendance attendance = new Attendance();
                  attendance.setId(id);
                  attendance.setDate(date);
                  attendance.setUserId(userId);
                  attendance.setStatus(status);

                  attendanceList.add(attendance);
              }

              return attendanceList;


          } catch (Exception e) {
              throw new RuntimeException(e);
          }

    }



    public static Attendance getTodayAttendance(int userId) {
        Attendance attendance = null;
        String query = "SELECT * FROM attendance WHERE user_id = ? AND date = CURDATE()";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setUserId(rs.getInt("user_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return attendance;
    }

    public static List<Attendance> getFilteredAttendance(Date startDate, Date endDate) {
        String query = "SELECT * \n" +
                "FROM attendance \n" +
                "WHERE date >= ? AND date <= ?";

        List<Attendance> attendanceList = new ArrayList<>();

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setDate(1, startDate);
            ps.setDate(2, endDate);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance att = new Attendance();
                    att.setId(rs.getInt("id"));
                    att.setUserId(rs.getInt("user_id"));
                    att.setDate(rs.getDate("date"));
                    att.setStatus(rs.getString("status"));
                    attendanceList.add(att);
                }
            }

            return attendanceList;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

        public List<Attendance> getAttendanceHistory(int userId, String yearMonth) {
        List<Attendance> history = new ArrayList<>();
        String query = "SELECT * FROM attendance WHERE user_id = ? AND DATE_FORMAT(date, '%Y-%m') = ? ORDER BY date DESC";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setString(2, yearMonth);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance att = new Attendance();
                    att.setId(rs.getInt("id"));
                    att.setUserId(rs.getInt("user_id"));
                    att.setDate(rs.getDate("date"));
                    att.setStatus(rs.getString("status"));
                    history.add(att);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return history;
    }

    public boolean markTimeIn(int userId) {
        String query = "INSERT INTO attendance (user_id, date, status) " +
                       "VALUES (?, CURDATE(), 'Present') ";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            System.out.println("markTimeIn() affected rows: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean markTimeOut(int userId) {
        String query = "UPDATE attendance SET time_out = CURRENT_TIME(), status = 'Present' " +
                       "WHERE user_id = ? AND date = CURDATE() AND time_out IS NULL";

        try (Connection conn = DbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            System.out.println("markTimeOut() affected rows: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

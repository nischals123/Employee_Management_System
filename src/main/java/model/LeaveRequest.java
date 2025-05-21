package model;

import java.sql.Date;
import java.sql.Timestamp;

public class LeaveRequest {
    private int id;
    private int userId;
    private User user; // Optional reference to user
    private Date startDate;
    private Date endDate;
    private String leaveType; // Annual, Sick, Personal, Maternity, Paternity, Other
    private String reason;
    private String status; // Pending, Approved, Rejected
    private String adminRemarks;

    public String getAdminRemarks() {
        return adminRemarks;
    }

    public void setAdminRemarks(String adminRemarks) {
        this.adminRemarks = adminRemarks;
    }

    private long totalDays; // Add this field

    public long getTotalDays() {
        return totalDays;
    }

    public void setTotalDays(long totalDays) {
        this.totalDays = totalDays;
    }


    public LeaveRequest(int userId, Date startDate, Date endDate, String leaveType, String reason) {
        this.userId = userId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.leaveType = leaveType;
        this.reason = reason;
        this.status = "Pending";
    }

    public LeaveRequest(int userId, Date startDate, Date endDate, String leaveType, String reason, String adminRemarks) {
        this.userId = userId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.leaveType = leaveType;
        this.reason = reason;
        this.status = "Pending";
        this.adminRemarks = adminRemarks;
    }

    // Constructors
    public LeaveRequest() {
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
        if (user != null) {
            this.userId = user.getId();
        }
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(String leaveType) {
        this.leaveType = leaveType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


}

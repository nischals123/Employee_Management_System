package com.group7.model;

import java.sql.Timestamp;

public class Attendance {
    private int id;
    private int userId;
    private User user; // Optional reference to user
    private Timestamp checkIn;
    private Timestamp checkOut;
    private String status; // Present, Absent, Half-day, Late
    private String note;

    // Constructors
    public Attendance() {
    }

    public Attendance(int userId, Timestamp checkIn) {
        this.userId = userId;
        this.checkIn = checkIn;
        this.status = "Present";
    }

    public Attendance(int id, int userId, Timestamp checkIn, Timestamp checkOut, String status, String note) {
        this.id = id;
        this.userId = userId;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.status = status;
        this.note = note;
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

    public Timestamp getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Timestamp checkIn) {
        this.checkIn = checkIn;
    }

    public Timestamp getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Timestamp checkOut) {
        this.checkOut = checkOut;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Attendance{" +
                "id=" + id +
                ", userId=" + userId +
                ", checkIn=" + checkIn +
                ", checkOut=" + checkOut +
                ", status='" + status + '\'' +
                ", note='" + note + '\'' +
                '}';
    }
}

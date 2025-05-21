package model;

import java.sql.Date;
import java.sql.Time;

public class Attendance {
    private int id;
    private int userId;
    private Date date;
    private String status;

    // Constructors
    public Attendance() {
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

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Attendance{" +
                "id=" + id +
                ", userId=" + userId +
                ", date=" + date +
                ", status='" + status + '\'' +
                '}';
    }
}
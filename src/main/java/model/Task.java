package model;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;

public class Task {
    private int id;
    private int assignedBy;
    private int assignedTo;
    private String title;
    private String description;
    private Date dueDate;
    private String status = "PENDING";
    private Date createdAt;

    // Additional fields for display
    private String assignedByName;
    private String assignedToName;
    private int daysUntilDue;

    // Constructors
    public Task() {
    }

    public Task(int id, int assignedBy, int assignedTo, String title, String description,
                Date dueDate, String status, Date createdAt) {
        this.id = id;
        this.assignedBy = assignedBy;
        this.assignedTo = assignedTo;
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.status = status;
        this.createdAt = createdAt;

        // Calculate days until due
        calculateDaysUntilDue();
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAssignedBy() {
        return assignedBy;
    }

    public void setAssignedBy(int assignedBy) {
        this.assignedBy = assignedBy;
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public String getFormattedDueDate() {
        if (dueDate == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(dueDate);
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
        calculateDaysUntilDue();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(createdAt);
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getAssignedByName() {
        return assignedByName;
    }

    public void setAssignedByName(String assignedByName) {
        this.assignedByName = assignedByName;
    }

    public String getAssignedToName() {
        return assignedToName;
    }

    public void setAssignedToName(String assignedToName) {
        this.assignedToName = assignedToName;
    }

    public int getAssignedToId() {
        return assignedTo;
    }

    public int getAssignedById() {
        return assignedBy;
    }

    public int getDaysUntilDue() {
        return daysUntilDue;
    }

    private void calculateDaysUntilDue() {
        if (dueDate == null) {
            daysUntilDue = 0;
            return;
        }

        Date today = new Date();
        long diffInMillies = dueDate.getTime() - today.getTime();
        daysUntilDue = (int) TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", assignedBy=" + assignedBy +
                ", assignedTo=" + assignedTo +
                ", title='" + title + '\'' +
                ", description='" + description + '\'' +
                ", dueDate=" + dueDate +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
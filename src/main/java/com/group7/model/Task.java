package com.group7.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Task {
    private int id;
    private String title;
    private String description;
    private int projectId;
    private Project project; // Optional reference to project
    private int assignedTo;
    private User assignee; // Optional reference to assignee
    private int assignedBy;
    private User assigner; // Optional reference to assigner
    private Date dueDate;
    private String priority; // Low, Medium, High, Urgent
    private String status; // To Do, In Progress, Review, Completed
    private Timestamp createdAt;

    // Constructors
    public Task() {
    }

    public Task(String title, String description, int projectId, int assignedTo, int assignedBy, Date dueDate) {
        this.title = title;
        this.description = description;
        this.projectId = projectId;
        this.assignedTo = assignedTo;
        this.assignedBy = assignedBy;
        this.dueDate = dueDate;
        this.priority = "Medium";
        this.status = "To Do";
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public int getProjectId() {
        return projectId;
    }

    public void setProjectId(int projectId) {
        this.projectId = projectId;
    }

    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
        if (project != null) {
            this.projectId = project.getId();
        }
    }

    public int getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(int assignedTo) {
        this.assignedTo = assignedTo;
    }

    public User getAssignee() {
        return assignee;
    }

    public void setAssignee(User assignee) {
        this.assignee = assignee;
        if (assignee != null) {
            this.assignedTo = assignee.getId();
        }
    }

    public int getAssignedBy() {
        return assignedBy;
    }

    public void setAssignedBy(int assignedBy) {
        this.assignedBy = assignedBy;
    }

    public User getAssigner() {
        return assigner;
    }

    public void setAssigner(User assigner) {
        this.assigner = assigner;
        if (assigner != null) {
            this.assignedBy = assigner.getId();
        }
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", projectId=" + projectId +
                ", assignedTo=" + assignedTo +
                ", dueDate=" + dueDate +
                ", priority='" + priority + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

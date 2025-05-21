package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Project {
    private int id;
    private String name;
    private String description;
    private Date startDate;
    private Date endDate;
    private String status; // Not Started, In Progress, On Hold, Completed, Cancelled
    private int managerId;
    private User manager; // Optional reference to manager
    private int departmentId;
    private Department department; // Optional reference to department
    private Timestamp createdAt;

    // Constructors
    public Project() {
    }

    public Project(String name, String description, Date startDate, Date endDate, int managerId, int departmentId) {
        this.name = name;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = "Not Started";
        this.managerId = managerId;
        this.departmentId = departmentId;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public User getManager() {
        return manager;
    }

    public void setManager(User manager) {
        this.manager = manager;
        if (manager != null) {
            this.managerId = manager.getId();
        }
    }

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
        if (department != null) {
            this.departmentId = department.getId();
        }
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Project{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status='" + status + '\'' +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", managerId=" + managerId +
                ", departmentId=" + departmentId +
                '}';
    }
}

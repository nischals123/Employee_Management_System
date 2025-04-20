package com.group7.model;

import java.sql.Timestamp;

public class Department {
    private int id;
    private String name;
    private String description;
    private int managerId;
    private User manager; // Optional reference to the manager
    private Timestamp createdAt;

    // Constructors
    public Department() {
    }

    public Department(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Department(int id, String name, String description, int managerId) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.managerId = managerId;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Department{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", managerId=" + managerId +
                ", createdAt=" + createdAt +
                '}';
    }
}

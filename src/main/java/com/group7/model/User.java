package com.group7.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String picturePath;
    private Role role;
    private boolean isActive;
    private boolean isDeleted;
    private int departmentId;
    private Department department; // Optional reference to department
    private Date hireDate;
//    private BigDecimal salary;
    private Timestamp createdAt;

    // No-argument constructor
    public User() {
    }

    // Basic constructor
    public User(String name, String email, String password, String phone, String picturePath) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.picturePath = picturePath;
    }

    // Full constructor
    public User(int id, String name, String email, String password, String phone, String picturePath,
                Role role, boolean isActive, boolean isDeleted, int departmentId, Date hireDate, BigDecimal salary) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.picturePath = picturePath;
        this.role = role;
        this.isActive = isActive;
        this.isDeleted = isDeleted;
        this.departmentId = departmentId;
        this.hireDate = hireDate;
//        this.salary = salary;
    }

    // Getters and setters
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPicturePath() {
        return picturePath;
    }

    public void setPicturePath(String picturePath) {
        this.picturePath = picturePath;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean deleted) {
        isDeleted = deleted;
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

    public Date getHireDate() {
        return hireDate;
    }

    public void setHireDate(Date hireDate) {
        this.hireDate = hireDate;
    }

//    public BigDecimal getSalary() {
//        return salary;
//    }
//
//    public void setSalary(BigDecimal salary) {
//        this.salary = salary;
//    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", role=" + (role != null ? role.getName() : "null") +
                ", department=" + (department != null ? department.getName() : "null") +
                ", isActive=" + isActive +
                ", hireDate=" + hireDate +
                '}';
    }
}

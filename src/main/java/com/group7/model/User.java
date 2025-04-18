package com.group7.model;

public class User {

    private String name;
    private String email;
    private String password;
    private String phone;
    private String picturePath;
    private Role role;
    private boolean isActive;
    private int departmentId;

    // No-argument constructor
    public User() {
    }

    // All-arguments constructor (optional, can customize this)
    public User(String name, String email, String password, String phone, String picturePath) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.picturePath = picturePath;
    }

    // Getters and setters

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

    public int getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }
}

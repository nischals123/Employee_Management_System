package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class User {

    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
//    private String picturePath;
    private byte[] picturePath;
    private int role; // 0 = User, 1 = Admin
    private boolean isActive;
    private boolean isDeleted;
    private int departmentId;
    private Department department; // Optional reference
    private Date hireDate;
    private Timestamp createdAt;
    private BigDecimal salary; // ✅ ADDED FIELD

    private String departmentName;
    private String roleName;

    // No-argument constructor
    public User() {
    }

    // Basic constructor
    public User(String name, String email, String password, String phone, byte[] picturePath) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.picturePath = picturePath;
    }

    // Full constructor
    public User(int id, String name, String email, String password, String phone, byte[] picturePath,
                int role, boolean isActive, boolean isDeleted, int departmentId, Date hireDate, BigDecimal salary) {
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
        this.salary = salary; // ✅ SET SALARY HERE
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

    public byte[] getPicturePath() {
        return picturePath;
    }

    public void setPicturePath(byte[] picturePath) {
        this.picturePath = picturePath;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public BigDecimal getSalary() { // ✅ ADDED GETTER
        return salary;
    }

    public void setSalary(BigDecimal salary) { // ✅ ADDED SETTER
        this.salary = salary;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", role=" + (role == 1 ? "admin" : "user") +
                ", department=" + (department != null ? department.getName() : "null") +
                ", isActive=" + isActive +
                ", hireDate=" + hireDate +
                ", salary=" + salary + 
                '}';
    }
}

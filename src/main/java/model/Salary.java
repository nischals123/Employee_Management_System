package model;

public class Salary {
    private int id;
    private int userId;
    private String month;
    private double amount;
    private String status;

    // Additional fields for display
    private String userName;

    // Constructors
    public Salary() {
    }

    public Salary(int id, int userId, String month, double amount, String status) {
        this.id = id;
        this.userId = userId;
        this.month = month;
        this.amount = amount;
        this.status = status;
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

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Salary{" +
                "id=" + id +
                ", userId=" + userId +
                ", month='" + month + '\'' +
                ", amount=" + amount +
                ", status='" + status + '\'' +
                '}';
    }
}
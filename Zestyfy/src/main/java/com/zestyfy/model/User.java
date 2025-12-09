package com.zestyfy.model;

import java.sql.Timestamp;

public class User {
    private int userId;
    private String name;
    private String email;
    private String phone;
    private String password;
    private String address;
    private Timestamp createdAt;
    
    // Default Constructor
    public User() {
    }
    
    // Parameterized Constructor
    public User(int userId, String name, String email, String phone, String password, String address) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.address = address;
    }
    
    // Getters and Setters
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
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
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "User [userId=" + userId + ", name=" + name + ", email=" + email 
                + ", phone=" + phone + ", address=" + address + "]";
    }
}
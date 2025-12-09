package com.zestyfy.dao;

import com.zestyfy.model.User;

public interface UserDao {
    
    // Register new user
    int registerUser(User user);
    
    // Login user with email and password
    User loginUser(String email, String password);
    
    // Get user by user ID
    User getUserById(int userId);
    
    // Get user by email
    User getUserByEmail(String email);
    
    // Update user profile
    int updateUser(User user);
}

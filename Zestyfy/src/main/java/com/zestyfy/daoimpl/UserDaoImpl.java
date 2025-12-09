package com.zestyfy.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.zestyfy.dao.UserDao;
import com.zestyfy.model.User;
import com.zestfy.util.DBconnection;

public class UserDaoImpl implements UserDao {
    
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet res;
    
    // SQL Queries
    private static final String INSERT_USER = 
        "INSERT INTO users (name, email, phone, password, address) VALUES (?, ?, ?, ?, ?)";
    
    private static final String LOGIN_USER = 
        "SELECT * FROM users WHERE email = ? AND password = ?";
    
    private static final String GET_USER_BY_ID = 
        "SELECT * FROM users WHERE user_id = ?";
    
    private static final String GET_USER_BY_EMAIL = 
        "SELECT * FROM users WHERE email = ?";
    
    private static final String UPDATE_USER = 
        "UPDATE users SET name = ?, phone = ?, address = ? WHERE user_id = ?";
    
    @Override
    public int registerUser(User user) {
        int userId = 0;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(INSERT_USER, Statement.RETURN_GENERATED_KEYS);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getPassword());
            pstmt.setString(5, user.getAddress());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                res = pstmt.getGeneratedKeys();
                if (res.next()) {
                    userId = res.getInt(1);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return userId;
    }
    
    @Override
    public User loginUser(String email, String password) {
        User user = null;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(LOGIN_USER);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
                user = extractUserFromResultSet(res);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return user;
    }
    
    @Override
    public User getUserById(int userId) {
        User user = null;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(GET_USER_BY_ID);
            pstmt.setInt(1, userId);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
                user = extractUserFromResultSet(res);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return user;
    }
    
    @Override
    public User getUserByEmail(String email) {
        User user = null;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(GET_USER_BY_EMAIL);
            pstmt.setString(1, email);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
                user = extractUserFromResultSet(res);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return user;
    }
    
    @Override
    public int updateUser(User user) {
        int rowsAffected = 0;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(UPDATE_USER);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getPhone());
            pstmt.setString(3, user.getAddress());
            pstmt.setInt(4, user.getUserId());
            
            rowsAffected = pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return rowsAffected;
    }
    
    // Helper method to extract User from ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setAddress(rs.getString("address"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        return user;
    }
    
    // Close resources
    private void closeResources() {
        try {
            if (res != null) res.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
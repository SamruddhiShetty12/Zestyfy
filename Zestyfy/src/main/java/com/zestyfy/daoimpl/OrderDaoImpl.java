package com.zestyfy.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.zestyfy.dao.OrderDao;
import com.zestyfy.model.Order;
import com.zestfy.util.DBconnection;

public class OrderDaoImpl implements OrderDao {
    
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet res;
    private Statement stmt;
    
    // SQL Queries
    private static final String ADD_ORDER = 
        "INSERT INTO orders (user_id, restaurant_id, total_amount, status, payment_method, " +
        "delivery_address, customer_name, customer_phone, customer_email, special_instructions) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    private static final String GET_ORDER_BY_ID = 
        "SELECT * FROM orders WHERE order_id = ?";
    
    private static final String GET_ALL_ORDERS = 
        "SELECT * FROM orders";
    
    private static final String GET_ORDERS_BY_USER = 
        "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
    
    private static final String UPDATE_ORDER_STATUS = 
        "UPDATE orders SET status = ? WHERE order_id = ?";
    
    @Override
    public int addOrder(Order order) {
        int orderId = 0;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(ADD_ORDER, Statement.RETURN_GENERATED_KEYS);
            
            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getRestaurantId());
            pstmt.setDouble(3, order.getTotalAmount());
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getPaymentMethod());
            pstmt.setString(6, order.getDeliveryAddress());
            pstmt.setString(7, order.getCustomerName());
            pstmt.setString(8, order.getCustomerPhone());
            pstmt.setString(9, order.getCustomerEmail());
            pstmt.setString(10, order.getSpecialInstructions());
            
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                res = pstmt.getGeneratedKeys();
                if (res.next()) {
                    orderId = res.getInt(1);
                }
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return orderId;
    }
    
    @Override
    public Order getOrder(int orderId) {
        Order order = null;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(GET_ORDER_BY_ID);
            pstmt.setInt(1, orderId);
            
            res = pstmt.executeQuery();
            
            if (res.next()) {
                order = extractOrderFromResultSet(res);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return order;
    }
    
    @Override
    public List<Order> getAllOrders() {
        List<Order> orderList = new ArrayList<>();
        try {
            con = DBconnection.getConnection();
            stmt = con.createStatement();
            res = stmt.executeQuery(GET_ALL_ORDERS);
            
            while (res.next()) {
                orderList.add(extractOrderFromResultSet(res));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return orderList;
    }
    
    @Override
    public List<Order> getOrdersByUser(int userId) {
        List<Order> orderList = new ArrayList<>();
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(GET_ORDERS_BY_USER);
            pstmt.setInt(1, userId);
            
            res = pstmt.executeQuery();
            
            while (res.next()) {
                orderList.add(extractOrderFromResultSet(res));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return orderList;
    }
    
    @Override
    public int updateOrderStatus(int orderId, String status) {
        int rowsAffected = 0;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(UPDATE_ORDER_STATUS);
            
            pstmt.setString(1, status);
            pstmt.setInt(2, orderId);
            
            rowsAffected = pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return rowsAffected;
    }
    
    // Helper method to extract Order from ResultSet
    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setRestaurantId(rs.getInt("restaurant_id"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setStatus(rs.getString("status"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setCustomerName(rs.getString("customer_name"));
        order.setCustomerPhone(rs.getString("customer_phone"));
        order.setCustomerEmail(rs.getString("customer_email"));
        order.setSpecialInstructions(rs.getString("special_instructions"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        return order;
    }
    
    // Close resources
    private void closeResources() {
        try {
            if (res != null) res.close();
            if (pstmt != null) pstmt.close();
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
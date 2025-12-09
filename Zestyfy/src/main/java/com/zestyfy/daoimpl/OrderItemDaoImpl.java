package com.zestyfy.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.zestyfy.dao.OrderItemDao;
import com.zestyfy.model.OrderItem;
import com.zestfy.util.DBconnection;

public class OrderItemDaoImpl implements OrderItemDao {
    
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet res;
    private Statement stmt;
    
    // SQL Queries
    private static final String ADD_ORDER_ITEM = 
        "INSERT INTO order_items (order_id, menu_id, quantity, price) VALUES (?, ?, ?, ?)";
    
    private static final String GET_ORDER_ITEMS_BY_ORDER = 
        "SELECT * FROM order_items WHERE order_id = ?";
    
    @Override
    public int addOrderItem(OrderItem orderItem) {
        int rowsAffected = 0;
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(ADD_ORDER_ITEM);
            
            pstmt.setInt(1, orderItem.getOrderId());
            pstmt.setInt(2, orderItem.getMenuId());
            pstmt.setInt(3, orderItem.getQuantity());
            pstmt.setDouble(4, orderItem.getPrice());
            
            rowsAffected = pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return rowsAffected;
    }
    
    @Override
    public List<OrderItem> getOrderItemsByOrder(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        try {
            con = DBconnection.getConnection();
            pstmt = con.prepareStatement(GET_ORDER_ITEMS_BY_ORDER);
            pstmt.setInt(1, orderId);
            
            res = pstmt.executeQuery();
            
            while (res.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(res.getInt("order_item_id"));
                item.setOrderId(res.getInt("order_id"));
                item.setMenuId(res.getInt("menu_id"));
                item.setQuantity(res.getInt("quantity"));
                item.setPrice(res.getDouble("price"));
                
                orderItems.add(item);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return orderItems;
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
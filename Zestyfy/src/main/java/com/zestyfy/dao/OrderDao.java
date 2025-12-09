package com.zestyfy.dao;

import java.util.List;

import com.zestyfy.model.Order;

public interface OrderDao {
    
    // Add new order to database
    int addOrder(Order order);
    
    // Get single order by order ID
    Order getOrder(int orderId);
    
    // Get all orders from database
    List<Order> getAllOrders();
    
    // Get all orders for a specific user
    List<Order> getOrdersByUser(int userId);
    
    // Update order status (Pending/Confirmed/Delivered)
    int updateOrderStatus(int orderId, String status);
}
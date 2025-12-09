package com.zestyfy.dao;

import java.util.List;

import com.zestyfy.model.OrderItem;

public interface OrderItemDao {
    
    // Add order item to database
    int addOrderItem(OrderItem orderItem);
    
    // Get all order items for a specific order
    List<OrderItem> getOrderItemsByOrder(int orderId);
}
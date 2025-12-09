<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.zestyfy.model.Order,com.zestyfy.daoimpl.OrderDaoImpl" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Confirmation - ZestyFly</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.confirmation-container {
    max-width: 600px;
    width: 100%;
    background: white;
    border-radius: 16px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.1);
    overflow: hidden;
    animation: slideUp 0.5s ease-out;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.success-header {
    background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
    color: white;
    padding: 40px 30px;
    text-align: center;
}

.success-icon {
    font-size: 80px;
    margin-bottom: 15px;
    animation: bounce 1s ease;
}

@keyframes bounce {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-20px); }
}

.success-header h1 {
    font-size: 32px;
    margin-bottom: 10px;
}

.success-header p {
    font-size: 16px;
    opacity: 0.9;
}

.order-details {
    padding: 40px 30px;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    padding: 15px 0;
    border-bottom: 1px solid #f0f0f0;
}

.detail-row:last-child {
    border-bottom: none;
}

.detail-label {
    color: #666;
    font-weight: 600;
}

.detail-value {
    color: #333;
    font-weight: 500;
    text-align: right;
    max-width: 60%;
    word-wrap: break-word;
}

.order-id {
    background: #fff3e0;
    color: #ff9800;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    margin-bottom: 25px;
    font-size: 18px;
    font-weight: bold;
}

.status-badge {
    display: inline-block;
    padding: 6px 16px;
    background: #fff3e0;
    color: #ff9800;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
}

.action-buttons {
    display: flex;
    gap: 15px;
    margin-top: 30px;
}

.btn {
    flex: 1;
    padding: 14px;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    text-align: center;
    transition: all 0.3s;
    display: inline-block;
}

.btn-primary {
    background: linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color: white;
    box-shadow: 0 4px 12px rgba(255, 152, 0, 0.4);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(255, 152, 0, 0.5);
}

.btn-secondary {
    background: #f5f5f5;
    color: #666;
}

.btn-secondary:hover {
    background: #e0e0e0;
    color: #333;
}

.info-message {
    background: #e3f2fd;
    color: #1976d2;
    padding: 15px;
    border-radius: 10px;
    margin-top: 20px;
    text-align: center;
    font-size: 14px;
}

.empty-state {
    text-align: center;
    padding: 60px 30px;
}

.empty-state p {
    color: #ff9800;
    font-size: 18px;
    margin-bottom: 20px;
}

@media (max-width: 600px) {
    .action-buttons {
        flex-direction: column;
    }
}
</style>
</head>
<body>

<%
Integer lastOrderId = (Integer) session.getAttribute("lastOrderId");

if (lastOrderId != null) {
    OrderDaoImpl orderDao = new OrderDaoImpl();
    Order order = orderDao.getOrder(lastOrderId);
    
    if (order != null) {
%>

<div class="confirmation-container">
    <div class="success-header">
        <div class="success-icon">✓</div>
        <h1>Order Placed Successfully!</h1>
        <p>Thank you for your order</p>
    </div>
    
    <div class="order-details">
        <div class="order-id">
            Order ID: #<%=order.getOrderId()%>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Customer Name</span>
            <span class="detail-value"><%=order.getCustomerName()%></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Phone Number</span>
            <span class="detail-value"><%=order.getCustomerPhone()%></span>
        </div>
        
        <% if (order.getCustomerEmail() != null && !order.getCustomerEmail().isEmpty()) { %>
        <div class="detail-row">
            <span class="detail-label">Email</span>
            <span class="detail-value"><%=order.getCustomerEmail()%></span>
        </div>
        <% } %>
        
        <div class="detail-row">
            <span class="detail-label">Delivery Address</span>
            <span class="detail-value"><%=order.getDeliveryAddress()%></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Payment Method</span>
            <span class="detail-value"><%=order.getPaymentMethod()%></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Total Amount</span>
            <span class="detail-value">₹<%=String.format("%.2f", order.getTotalAmount())%></span>
        </div>
        
        <div class="detail-row">
            <span class="detail-label">Status</span>
            <span class="detail-value">
                <span class="status-badge"><%=order.getStatus()%></span>
            </span>
        </div>
        
        <% if (order.getSpecialInstructions() != null && !order.getSpecialInstructions().isEmpty()) { %>
        <div class="detail-row">
            <span class="detail-label">Special Instructions</span>
            <span class="detail-value"><%=order.getSpecialInstructions()%></span>
        </div>
        <% } %>
        
        <div class="info-message">
            📱 You will receive order updates on your phone
        </div>
        
        <div class="action-buttons">
            <a href="home" class="btn btn-primary">Continue Shopping</a>
            <a href="cart.jsp" class="btn btn-secondary">View Cart</a>
        </div>
    </div>
</div>

<%
    } else {
%>
    <div class="confirmation-container">
        <div class="order-details empty-state">
            <p>⚠️ Order not found!</p>
            <a href="home" class="btn btn-primary">Go to Home</a>
        </div>
    </div>
<%
    }
} else {
%>
    <div class="confirmation-container">
        <div class="order-details empty-state">
            <p>⚠️ No order found!</p>
            <a href="home" class="btn btn-primary">Go to Home</a>
        </div>
    </div>
<%
}
%>

</body>
</html>
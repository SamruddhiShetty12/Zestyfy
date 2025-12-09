<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.zestyfy.model.Menuu,com.zestyfy.Cart,com.zestyfy.CartItem" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - ZestyFly</title>
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
    padding-bottom: 40px;
}

h1 {
    text-align: center;
    background: linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color: white;
    padding: 20px;
    margin: 0 0 30px 0;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    font-size: 28px;
    letter-spacing: 1px;
}

.checkout-container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
}

.section {
    background: white;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

.section h2 {
    color: #333;
    margin-bottom: 20px;
    font-size: 22px;
    border-bottom: 3px solid #ff9800;
    padding-bottom: 10px;
}

.form-group {
    margin-bottom: 18px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #555;
    font-weight: 600;
    font-size: 14px;
}

.form-group input,
.form-group textarea,
.form-group select {
    width: 100%;
    padding: 12px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.3s;
    font-family: inherit;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
    outline: none;
    border-color: #ff9800;
    box-shadow: 0 0 0 3px rgba(255, 152, 0, 0.1);
}

.form-group textarea {
    resize: vertical;
    min-height: 80px;
}

.order-summary {
    grid-column: span 2;
}

.order-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid #f0f0f0;
}

.order-item:last-child {
    border-bottom: none;
}

.item-details {
    flex: 1;
}

.item-name {
    font-weight: 600;
    color: #333;
    font-size: 16px;
}

.item-quantity {
    color: #666;
    font-size: 14px;
    margin-top: 4px;
}

.item-price {
    font-weight: 600;
    color: #2e7d32;
    font-size: 16px;
}

.price-breakdown {
    margin-top: 20px;
    padding-top: 20px;
    border-top: 2px solid #f0f0f0;
}

.price-row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    font-size: 15px;
}

.price-row.subtotal {
    color: #666;
}

.price-row.tax {
    color: #666;
}

.price-row.delivery {
    color: #666;
}

.price-row.total {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    border-top: 2px solid #ff9800;
    padding-top: 15px;
    margin-top: 10px;
}

.payment-methods {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px;
    margin-top: 10px;
}

.payment-option {
    position: relative;
}

.payment-option input[type="radio"] {
    position: absolute;
    opacity: 0;
}

.payment-option label {
    display: block;
    padding: 15px;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    cursor: pointer;
    text-align: center;
    font-weight: 600;
    transition: all 0.3s;
    background: white;
}

.payment-option input[type="radio"]:checked + label {
    border-color: #ff9800;
    background: #fff3e0;
    color: #ff6f00;
}

.payment-option label:hover {
    border-color: #ff9800;
}

.button-group {
    display: flex;
    gap: 15px;
    margin-top: 25px;
    grid-column: span 2;
}

.btn {
    flex: 1;
    padding: 15px;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
    text-decoration: none;
    text-align: center;
    display: inline-block;
}

.btn-primary {
    background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
    color: white;
    box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
}

.btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 16px rgba(76, 175, 80, 0.5);
}

.btn-secondary {
    background: #f5f5f5;
    color: #666;
    border: 2px solid #e0e0e0;
}

.btn-secondary:hover {
    background: #e0e0e0;
    color: #333;
}

.empty-cart {
    grid-column: span 2;
    text-align: center;
    padding: 60px 20px;
}

.empty-cart p {
    color: #ff9800;
    font-size: 22px;
    margin-bottom: 25px;
    font-weight: 600;
}

.empty-cart a {
    color: white;
    background: #ff9800;
    padding: 12px 30px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    display: inline-block;
    transition: all 0.3s;
    box-shadow: 0 4px 10px rgba(255, 152, 0, 0.3);
}

.empty-cart a:hover {
    background: #fb8c00;
    transform: translateY(-2px);
    box-shadow: 0 6px 14px rgba(255, 152, 0, 0.4);
}

@media (max-width: 768px) {
    .checkout-container {
        grid-template-columns: 1fr;
    }
    
    .order-summary {
        grid-column: span 1;
    }
    
    .button-group {
        grid-column: span 1;
        flex-direction: column;
    }
    
    .payment-methods {
        grid-template-columns: 1fr;
    }
}

.required {
    color: red;
    margin-left: 3px;
}
</style>
</head>
<body>

<h1>🛒 Checkout</h1>

<%
Cart cart = (Cart) session.getAttribute("cart");
Integer restaurantId = (Integer) session.getAttribute("restaurantId");

if (cart != null && !cart.getItems().isEmpty()) {
    double subtotal = cart.getTotalPrice();
    double taxRate = 0.05; // 5% tax
    double tax = subtotal * taxRate;
    double deliveryFee = 40.0;
    double total = subtotal + tax + deliveryFee;
%>

<form action="order" method="post">
    <div class="checkout-container">
        
        <!-- Delivery Information Section -->
        <div class="section">
            <h2>📍 Delivery Information</h2>
            
            <div class="form-group">
                <label for="name">Full Name <span class="required">*</span></label>
                <input type="text" id="name" name="name" required placeholder="Enter your full name">
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number <span class="required">*</span></label>
                <input type="tel" id="phone" name="phone" required placeholder="10-digit mobile number" pattern="[0-9]{10}">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="your.email@example.com">
            </div>
            
            <div class="form-group">
                <label for="address">Delivery Address <span class="required">*</span></label>
                <textarea id="address" name="address" required placeholder="House/Flat No., Building Name, Street, Area"></textarea>
            </div>
            
            <div class="form-group">
                <label for="city">City <span class="required">*</span></label>
                <input type="text" id="city" name="city" required placeholder="Enter your city">
            </div>
            
            <div class="form-group">
                <label for="pincode">Pincode <span class="required">*</span></label>
                <input type="text" id="pincode" name="pincode" required placeholder="6-digit pincode" pattern="[0-9]{6}">
            </div>
        </div>
        
        <!-- Payment Method Section -->
        <div class="section">
            <h2>💳 Payment Method</h2>
            
            <div class="payment-methods">
                <div class="payment-option">
                    <input type="radio" id="cod" name="paymentMethod" value="COD" checked>
                    <label for="cod">💵 Cash on Delivery</label>
                </div>
                
                <div class="payment-option">
                    <input type="radio" id="card" name="paymentMethod" value="Card">
                    <label for="card">💳 Debit/Credit Card</label>
                </div>
                
                <div class="payment-option">
                    <input type="radio" id="upi" name="paymentMethod" value="UPI">
                    <label for="upi">📱 UPI</label>
                </div>
                
                <div class="payment-option">
                    <input type="radio" id="wallet" name="paymentMethod" value="Wallet">
                    <label for="wallet">👛 Wallet</label>
                </div>
            </div>
            
            <div class="form-group" style="margin-top: 20px;">
                <label for="instructions">Special Instructions (Optional)</label>
                <textarea id="instructions" name="instructions" placeholder="Any special requests for your order..."></textarea>
            </div>
        </div>
        
        <!-- Order Summary Section -->
        <div class="section order-summary">
            <h2>📋 Order Summary</h2>
            
            <% for (CartItem item : cart.getItems().values()) { %>
            <div class="order-item">
                <div class="item-details">
                    <div class="item-name"><%=item.getName()%></div>
                    <div class="item-quantity">Quantity: <%=item.getQuantity()%> × ₹<%=String.format("%.2f", item.getPrice())%></div>
                </div>
                <div class="item-price">₹<%=String.format("%.2f", item.getTotalPrice())%></div>
            </div>
            <% } %>
            
            <div class="price-breakdown">
                <div class="price-row subtotal">
                    <span>Subtotal</span>
                    <span>₹<%=String.format("%.2f", subtotal)%></span>
                </div>
                <div class="price-row tax">
                    <span>Tax (5%)</span>
                    <span>₹<%=String.format("%.2f", tax)%></span>
                </div>
                <div class="price-row delivery">
                    <span>Delivery Fee</span>
                    <span>₹<%=String.format("%.2f", deliveryFee)%></span>
                </div>
                <div class="price-row total">
                    <span>Total Amount</span>
                    <span>₹<%=String.format("%.2f", total)%></span>
                </div>
            </div>
        </div>
        
        <!-- Buttons -->
        <div class="button-group">
            <a href="cart.jsp" class="btn btn-secondary">← Back to Cart</a>
            <button type="submit" class="btn btn-primary">Place Order ✓</button>
        </div>
        
    </div>
    
    <input type="hidden" name="restaurantId" value="<%=restaurantId != null ? restaurantId : ""%>">
    <input type="hidden" name="totalAmount" value="<%=total%>">
</form>

<% 
} else { 
%>
    <div class="checkout-container">
        <div class="section empty-cart">
            <p>Your cart is empty!</p>
            <a href="home">Browse Restaurants</a>
        </div>
    </div>
<% 
} 
%>

</body>
</html>
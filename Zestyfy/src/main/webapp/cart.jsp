<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.zestyfy.model.Menuu,com.zestyfy.Cart,com.zestyfy.CartItem" %>

<!DOCTYPE html>
<html>
<head>
<title>My Cart</title>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background:linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    margin:0;
    padding:0;
    min-height:100vh;
    background: #EEAECA;
background: radial-gradient(circle, rgba(238, 174, 202, 1) 0%, rgba(148, 187, 233, 1) 100%);
	
}
h1 {
    text-align:center;
    background:linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color:white;
    padding:20px;
    margin:0;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    font-size:28px;
    letter-spacing:1px;
}

.cart-container {
    width:90%;
    max-width:900px;
    margin:30px auto;
    padding-bottom:30px;
}

.cart-item {
    display:flex;
    background:white;
    border-radius:12px;
    margin-bottom:20px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
    overflow:hidden;
    transition:transform 0.2s, box-shadow 0.2s;
}

.cart-item:hover {
    transform:translateY(-2px);
    box-shadow:0 6px 16px rgba(0,0,0,0.12);
}

.cart-item img {
    width:150px;
    height:150px;
    object-fit:cover;
}

.cart-details {
    flex:1;
    padding:20px;
    display:flex;
    flex-direction:column;
    gap:8px;
}

.cart-details h3 {
    margin:0 0 8px 0;
    color:#333;
    font-size:20px;
}

.price {
    font-weight:600;
    color:#2e7d32;
    margin:0;
    font-size:15px;
}

.quality-controls {
    display:flex;
    align-items:center;
    gap:8px;
    margin:10px 0;
}

.quality-controls form {
    margin:0;
    padding:0;
    display:inline-flex;
}

.quality-controls p {
    margin:0;
    font-weight:bold;
    min-width:40px;
    text-align:center;
    font-size:16px;
    line-height:1;
}

.quantity-btn {
    padding:8px 15px;
    border:1px solid #ddd;
    border-radius:5px;
    cursor:pointer;
    font-size:18px;
    font-weight:bold;
    background:white;
    transition:all 0.2s;
    min-width:40px;
}

.quantity-btn:hover:not(:disabled) {
    background:#4CAF50;
    color:white;
    border-color:#4CAF50;
}

.quantity-btn:disabled {
    opacity:0.4;
    cursor:not-allowed;
    background:#f5f5f5;
}

.remove-btn {
    padding:8px 16px;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-size:14px;
    background:#e53935;
    color:white;
    margin-top:10px;
    font-weight:600;
    transition:background 0.2s;
}

.remove-btn:hover {
    background:#c62828;
}

.total {
    text-align:center;
    font-size:24px;
    font-weight:bold;
    margin:30px 0 20px 0;
    color:#333;
    padding:20px;
    background:linear-gradient(135deg, #fff3e0 0%, #ffe0b2 100%);
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,0.1);
}

.add-more-items {
    text-align:center;
    margin:20px 0;
}

.btn {
    display:inline-block;
    padding:12px 30px;
    text-decoration:none;
    border-radius:8px;
    font-size:15px;
    font-weight:600;
    transition:all 0.3s;
}

.add-more-items-btn {
    background:#4CAF50;
    color:white;
    box-shadow:0 4px 10px rgba(76, 175, 80, 0.3);
}

.add-more-items-btn:hover {
    background:#45a049;
    transform:translateY(-2px);
    box-shadow:0 6px 14px rgba(76, 175, 80, 0.4);
}

.proceed-to-checkout-btn {
    display:block;
    margin:20px auto;
    background:linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    padding:14px 40px;
    color:white;
    border:none;
    border-radius:10px;
    font-size:18px;
    cursor:pointer;
    font-weight:bold;
    transition:all 0.3s;
    box-shadow:0 4px 12px rgba(255, 152, 0, 0.4);
}

.proceed-to-checkout-btn:hover {
    background:linear-gradient(135deg, #fb8c00 0%, #e65100 100%);
    transform:translateY(-2px);
    box-shadow:0 6px 16px rgba(255, 152, 0, 0.5);
}

.empty {
    text-align:center;
    margin-top:80px;
    background:white;
    padding:40px;
    border-radius:12px;
    box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.empty p {
    color:#ff9800;
    font-size:22px;
    margin-bottom:25px;
    font-weight:600;
}

.empty a {
    color:white;
    background:#ff9800;
    padding:12px 30px;
    border-radius:8px;
    text-decoration:none;
    font-weight:600;
    display:inline-block;
    transition:all 0.3s;
    box-shadow:0 4px 10px rgba(255, 152, 0, 0.3);
}

.empty a:hover {
    background:#fb8c00;
    transform:translateY(-2px);
    box-shadow:0 6px 14px rgba(255, 152, 0, 0.4);
}
.user-navbar {
    background: linear-gradient(135deg, #333 0%, #555 100%);
    padding: 12px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.user-navbar .logo {
    color: white;
    font-size: 20px;
    font-weight: bold;
}

.user-navbar .user-info {
    display: flex;
    align-items: center;
    gap: 20px;
}

.user-navbar .welcome-text {
    color: white;
    font-size: 14px;
}

.user-navbar a {
    color: #ff9800;
    text-decoration: none;
    font-weight: 600;
    font-size: 14px;
    transition: all 0.3s;
}

.user-navbar a:hover {
    color: #ffb74d;
}

.user-navbar .btn-link {
    padding: 8px 16px;
    border-radius: 6px;
    background: rgba(255, 152, 0, 0.1);
}

.user-navbar .btn-link:hover {
    background: rgba(255, 152, 0, 0.2);
}

</style>
</head>
<body>
<!-- Add this at the top of your JSP pages (after opening <body> tag) -->

<div class="user-navbar">
    <div class="logo">🍕 ZestyFly</div>
    
    <div class="user-info">
        <%
        Integer userId = (Integer) session.getAttribute("userId");
        String userName = (String) session.getAttribute("userName");
        
        if (userId != null && userId != 0) {
            // User is logged in
        %>
            <span class="welcome-text">Welcome, <%= userName %>!</span>
            <a href="logout" class="btn-link">Logout</a>
        <%
        } else {
            // User is guest
        %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
        <%
        }
        %>
    </div>
</div>

<h1>🛒 My Cart</h1>

<div class="cart-container">
<%
Cart cart = (Cart)session.getAttribute("cart");
Integer restaurantId = (Integer)session.getAttribute("restaurantId");

if(cart != null && !cart.getItems().isEmpty()){
    for(CartItem item : cart.getItems().values()){
%>
    <div class="cart-item">
        <div class="cart-details">
            <h3><%=item.getName()%></h3>
            <div class="price">Price: ₹<%=item.getPrice()%></div>
            <div class="price">Total Price: ₹<%=String.format("%.2f", item.getTotalPrice())%></div>
            
            <div class="quality-controls">
                <!-- Decrease Quantity -->
                <form action="cart" style="display:inline;" method="post">
                    <input type="hidden" name="itemId" value="<%=item.getItemId()%>">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="restaurantId" value="<%=restaurantId != null ? restaurantId : ""%>">
                    <input type="hidden" name="quantity" value="<%=item.getQuantity() - 1%>">
                    <button class="quantity-btn" type="submit" <%if(item.getQuantity() == 1){%>disabled<%}%>>-</button>
                </form>
                
                <p><%=item.getQuantity()%></p>
                
                <!-- Increase Quantity -->
                <form action="cart" style="display:inline;" method="post">
                    <input type="hidden" name="itemId" value="<%=item.getItemId()%>">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="restaurantId" value="<%=restaurantId != null ? restaurantId : ""%>">
                    <input type="hidden" name="quantity" value="<%=item.getQuantity() + 1%>">
                    <button class="quantity-btn" type="submit">+</button>
                </form>
            </div>
            
            <!-- Remove Item -->
            <div>
                <form action="cart" method="post">
                    <input type="hidden" name="itemId" value="<%=item.getItemId()%>">
                    <input type="hidden" name="restaurantId" value="<%=restaurantId != null ? restaurantId : ""%>">
                    <input type="hidden" name="action" value="delete">
                    <button class="remove-btn" type="submit">Remove</button>
                </form>
            </div>
        </div>
    </div>
<%
    }
%>
    <div class="total">
        Grand Total: ₹<%=String.format("%.2f", cart.getTotalPrice())%>
    </div>
    
    <div class="add-more-items">
        <a href="menu?restaurantId=<%=restaurantId != null ? restaurantId : ""%>" class="btn add-more-items-btn">Add More Items</a>
    </div>
    
    <form action="checkout.jsp" method="post">
        <input type="submit" value="Proceed to Checkout" class="proceed-to-checkout-btn">
    </form>
<%
} else {
%>
    <div class="empty">
        <p>Your Cart is Empty.</p>
        <div>
            <a href="menu?restaurantId=<%=restaurantId != null ? restaurantId : ""%>">Add Items</a>
        </div>
    </div>
<%
}
%>
</div>

</body>
</html>
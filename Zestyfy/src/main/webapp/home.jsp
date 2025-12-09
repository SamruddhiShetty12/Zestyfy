<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List,com.zestyfy.model.Restaurant" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zestyfy</title>
<link rel="stylesheet" href="style.css">
<style>
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
<h1>Popular Restaurants Near You 🍴</h1>

<div class="container">
<% List<Restaurant>allRestaurant=(List<Restaurant>)request.getAttribute("allRestaurant"); 
for(Restaurant rest:allRestaurant) 
{  %>

<div class="card">
    <img src="<%=rest.getImage() %>" alt="Dragon Bowl">
    <div class="details">
        <h2 class="name"><%= rest.getName() %> </h2><div class="eta">Estimated Time:<%= rest.getEta() %> min</div>
        <div class="rating">Rating:⭐<%= rest.getRating() %></div>
        <div class="address">Location:<%= rest.getAddress() %></div>
        <div class="desc"><%= rest.getDescription() %></div>
        <a href="menu?restaurantId=<%= rest.getId() %>">Menu Details</a>
    </div>
</div>

	<%} 
	%>	
</div>
</body>
</html>
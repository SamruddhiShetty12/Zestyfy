<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List,com.zestyfy.model.Menuu"%>
<!DOCTYPE html>
<html>
<head>
<title>Food Menu</title>
<meta charset="UTF-8">

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f6f6f6;
    margin: 0;
    background: #EEAECA;
background: radial-gradient(circle, rgba(238, 174, 202, 1) 0%, rgba(148, 187, 233, 1) 100%);
}
h1{
	background-clip: text;
	color:transparent;
    text-align:center;
    background:linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color:white;
    padding:20px;
    margin:0;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    font-size:28px;
    letter-spacing:1px;
}
h1{
	background-clip: text;
	color:transparent;
    text-align:center;
    background:linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color:white;
    padding:20px;
    margin:0;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
    font-size:28px;
    letter-spacing:1px;
}

.menu-container {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 15px;
    padding: 20px;
}

.card {
    background: white;
    border-radius: 10px;
    box-shadow: 0px 2px 8px rgba(0,0,0,0.1);
    overflow: hidden;
}

.card img {
    width: 100%;
    height: 150px;
    object-fit: cover;
}

.card-content {
    padding: 10px;
}

.card-content h3 {
    margin: 0;
    font-size: 18px;
}

.desc {
    font-size: 13px;
    color: #666;
    margin: 5px 0;
}

.rating {
    background: green;
    color: white;
    display: inline-block;
    padding: 3px 6px;
    border-radius: 5px;
    font-size: 12px;
}

.price {
    font-weight: bold;
    margin: 6px 0;
}

button {
    width: 100%;
    padding: 8px;
    border: none;
    background: orange;
    color: white;
    font-size: 14px;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background: darkorange;
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
<h1>🍴 Food Menu</h1>

<div class="menu-container">
<% List<Menuu> allMenubyresto= (List<Menuu>)request.getAttribute("allMenubyresto");
for(Menuu menu:allMenubyresto){%>
    <div class="card">
        <img src="<%=menu.getImage() %>">
        <div class="card-content">
            <h3><%=menu.getItemName() %></h3>
            <span class="rating">★<%=menu.getRating() %></span>
            <p class="desc"><%=menu.getDescription() %></p>
            <p class="price">₹<%=menu.getPrice() %></p>
            
            <form action="cart">
            <input type="hidden" name="menuId" value="<%= menu.getId()%>">
            <input type="hidden" name="quantity" value="1">
            <input type="hidden" name="restaurantId" value="<%=menu.getRestaurantId()%>">
            <input type="hidden" name="action" value="add">
            <div><button>Add to Cart</button>
            </form>
            </div>
        </div>
    </div>
<% }%>  

</div>

</body>
</html>

</body>
</html>
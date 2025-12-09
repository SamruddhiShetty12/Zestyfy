<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - ZestyFly</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
}

.login-container {
    background: white;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.3);
    overflow: hidden;
    max-width: 400px;
    width: 100%;
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

.login-header {
    background: linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color: white;
    padding: 40px 30px;
    text-align: center;
}

.login-header h1 {
    font-size: 32px;
    margin-bottom: 10px;
}

.login-header p {
    opacity: 0.9;
    font-size: 14px;
}

.login-form {
    padding: 40px 30px;
}

.form-group {
    margin-bottom: 25px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #333;
    font-weight: 600;
    font-size: 14px;
}

.form-group input {
    width: 100%;
    padding: 14px;
    border: 2px solid #e0e0e0;
    border-radius: 10px;
    font-size: 15px;
    transition: all 0.3s;
}

.form-group input:focus {
    outline: none;
    border-color: #ff9800;
    box-shadow: 0 0 0 3px rgba(255, 152, 0, 0.1);
}

.error-message {
    background: #ffebee;
    color: #c62828;
    padding: 12px;
    border-radius: 8px;
    margin-bottom: 20px;
    font-size: 14px;
    text-align: center;
    border-left: 4px solid #c62828;
}

.btn-login {
    width: 100%;
    padding: 15px;
    background: linear-gradient(135deg, #ff9800 0%, #ff6f00 100%);
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
    box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
}

.btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(255, 152, 0, 0.5);
}

.register-link {
    text-align: center;
    margin-top: 25px;
    padding-top: 25px;
    border-top: 1px solid #e0e0e0;
    color: #666;
    font-size: 14px;
}

.register-link a {
    color: #ff9800;
    text-decoration: none;
    font-weight: 600;
}

.register-link a:hover {
    text-decoration: underline;
}

.guest-link {
    text-align: center;
    margin-top: 15px;
}

.guest-link a {
    color: #666;
    text-decoration: none;
    font-size: 14px;
}

.guest-link a:hover {
    color: #ff9800;
    text-decoration: underline;
}
</style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <h1>🍕 ZestyFly</h1>
        <p>Login to your account</p>
    </div>
    
    <div class="login-form">
        <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
        <div class="error-message">
            ❌ <%= errorMessage %>
        </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" required 
                       placeholder="Enter your email">
            </div>
            
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required 
                       placeholder="Enter your password">
            </div>
            
            <button type="submit" class="btn-login">Login</button>
        </form>
        
        <div class="register-link">
            Don't have an account? <a href="register.jsp">Register here</a>
        </div>
        
        <div class="guest-link">
            <a href="home">Continue as Guest</a>
        </div>
    </div>
</div>

</body>
</html>
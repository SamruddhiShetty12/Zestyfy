<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - ZestyFly</title>
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

.register-container {
    background: white;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.3);
    overflow: hidden;
    max-width: 500px;
    width: 100%;
    animation: slideUp 0.5s ease-out;
    margin: 20px 0;
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

.register-header {
    background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
    color: white;
    padding: 40px 30px;
    text-align: center;
}

.register-header h1 {
    font-size: 32px;
    margin-bottom: 10px;
}

.register-header p {
    opacity: 0.9;
    font-size: 14px;
}

.register-form {
    padding: 40px 30px;
    max-height: 70vh;
    overflow-y: auto;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #333;
    font-weight: 600;
    font-size: 14px;
}

.form-group input,
.form-group textarea {
    width: 100%;
    padding: 14px;
    border: 2px solid #e0e0e0;
    border-radius: 10px;
    font-size: 15px;
    transition: all 0.3s;
    font-family: inherit;
}

.form-group input:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #4CAF50;
    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
}

.form-group textarea {
    resize: vertical;
    min-height: 60px;
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

.btn-register {
    width: 100%;
    padding: 15px;
    background: linear-gradient(135deg, #4CAF50 0%, #45a049 100%);
    color: white;
    border: none;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.3s;
    box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
}

.btn-register:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(76, 175, 80, 0.5);
}

.login-link {
    text-align: center;
    margin-top: 25px;
    padding-top: 25px;
    border-top: 1px solid #e0e0e0;
    color: #666;
    font-size: 14px;
}

.login-link a {
    color: #4CAF50;
    text-decoration: none;
    font-weight: 600;
}

.login-link a:hover {
    text-decoration: underline;
}

.required {
    color: red;
}

/* Custom scrollbar for form */
.register-form::-webkit-scrollbar {
    width: 8px;
}

.register-form::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.register-form::-webkit-scrollbar-thumb {
    background: #4CAF50;
    border-radius: 10px;
}

.register-form::-webkit-scrollbar-thumb:hover {
    background: #45a049;
}
</style>
</head>
<body>

<div class="register-container">
    <div class="register-header">
        <h1>🍕 ZestyFly</h1>
        <p>Create your account</p>
    </div>
    
    <div class="register-form">
        <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
        <div class="error-message">
            ❌ <%= errorMessage %>
        </div>
        <% } %>
        
        <form action="register" method="post">
            <div class="form-group">
                <label for="name">Full Name <span class="required">*</span></label>
                <input type="text" id="name" name="name" required 
                       placeholder="Enter your full name">
            </div>
            
            <div class="form-group">
                <label for="email">Email Address <span class="required">*</span></label>
                <input type="email" id="email" name="email" required 
                       placeholder="Enter your email">
            </div>
            
            <div class="form-group">
                <label for="phone">Phone Number <span class="required">*</span></label>
                <input type="tel" id="phone" name="phone" required 
                       placeholder="10-digit mobile number" pattern="[0-9]{10}">
            </div>
            
            <div class="form-group">
                <label for="password">Password <span class="required">*</span></label>
                <input type="password" id="password" name="password" required 
                       placeholder="Create a password" minlength="6">
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">Confirm Password <span class="required">*</span></label>
                <input type="password" id="confirmPassword" name="confirmPassword" required 
                       placeholder="Confirm your password" minlength="6">
            </div>
            
            <div class="form-group">
                <label for="address">Address (Optional)</label>
                <textarea id="address" name="address" 
                          placeholder="Enter your delivery address"></textarea>
            </div>
            
            <button type="submit" class="btn-register">Create Account</button>
        </form>
        
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </div>
</div>

</body>
</html>
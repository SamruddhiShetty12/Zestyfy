package com.zestyfy;

import java.io.IOException;

import com.zestyfy.daoimpl.UserDaoImpl;
import com.zestyfy.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        // Get form data
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String address = req.getParameter("address");
        
        // Validate input
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            req.setAttribute("errorMessage", "All fields except address are required");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }
        
        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            req.setAttribute("errorMessage", "Passwords do not match");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }
        
        // Check if email already exists
        UserDaoImpl userDao = new UserDaoImpl();
        User existingUser = userDao.getUserByEmail(email.trim());
        
        if (existingUser != null) {
            req.setAttribute("errorMessage", "Email already registered. Please login.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }
        
        // Create new user
        User newUser = new User();
        newUser.setName(name.trim());
        newUser.setEmail(email.trim());
        newUser.setPhone(phone.trim());
        newUser.setPassword(password.trim()); // Note: In production, hash the password!
        newUser.setAddress(address != null ? address.trim() : "");
        
        // Save user to database
        int userId = userDao.registerUser(newUser);
        
        if (userId > 0) {
            // Registration successful - auto login
            HttpSession session = req.getSession();
            session.setAttribute("userId", userId);
            session.setAttribute("userName", newUser.getName());
            session.setAttribute("userEmail", newUser.getEmail());
            session.setAttribute("userPhone", newUser.getPhone());
            session.setAttribute("userAddress", newUser.getAddress());
            
            // Redirect to home page
            res.sendRedirect("home");
            
        } else {
            // Registration failed
            req.setAttribute("errorMessage", "Registration failed. Please try again.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        // Redirect to registration page
        res.sendRedirect("register.jsp");
    }
}
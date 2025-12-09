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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        // Get form data
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        // Validate input
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Email and password are required");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }
        
        // Check user credentials
        UserDaoImpl userDao = new UserDaoImpl();
        User user = userDao.loginUser(email.trim(), password.trim());
        
        if (user != null) {
            // Login successful - create session
            HttpSession session = req.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userPhone", user.getPhone());
            session.setAttribute("userAddress", user.getAddress());
            
            // Redirect to home page
            res.sendRedirect("home");
            
        } else {
            // Login failed
            req.setAttribute("errorMessage", "Invalid email or password");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        // Redirect to login page
        res.sendRedirect("login.jsp");
    }
}
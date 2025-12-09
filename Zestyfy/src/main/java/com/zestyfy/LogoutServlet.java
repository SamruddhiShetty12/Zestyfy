package com.zestyfy;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        // Get current session (don't create new one)
        HttpSession session = req.getSession(false);
        
        if (session != null) {
            // Invalidate session (clear all attributes)
            session.invalidate();
        }
        
        // Redirect to home page
        res.sendRedirect("home");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        // Handle POST requests same as GET
        doGet(req, res);
    }
}

package com.zestyfy;

import java.io.IOException;

import com.zestyfy.daoimpl.MenuDaoImpl;
import com.zestyfy.model.Menuu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        HttpSession ses = req.getSession();
        Cart cart = (Cart) ses.getAttribute("cart");
        
        // Get restaurantId from request parameter
        String restId = req.getParameter("restaurantId");
        
        // Validate restaurantId parameter
        if (restId == null || restId.isEmpty() || restId.equals("null")) {
            // If no restaurantId in request, try to get from session
            Integer sessionRestId = (Integer) ses.getAttribute("restaurantId");
            if (sessionRestId != null) {
                restId = String.valueOf(sessionRestId);
            } else {
                // No valid restaurantId found anywhere
                res.sendRedirect("home");
                return;
            }
        }
        
        int newRestaurantId = 0;
        try {
            newRestaurantId = Integer.parseInt(restId);
        } catch (NumberFormatException e) {
            res.sendRedirect("home");
            return;
        }
        
        Integer oldRestaurantId = (Integer) ses.getAttribute("oldRestaurantId");
        
        // Clear cart if restaurant changes or cart is new
        if (cart == null || oldRestaurantId == null || !oldRestaurantId.equals(newRestaurantId)) {
            cart = new Cart();
            ses.setAttribute("cart", cart);
            ses.setAttribute("oldRestaurantId", newRestaurantId);
            ses.setAttribute("restaurantId", newRestaurantId);
        }
        
        String action = req.getParameter("action");
        
        // If no action specified, just show cart
        if (action == null || action.isEmpty()) {
            res.sendRedirect("cart.jsp");
            return;
        }
        
        // Handle different actions
        try {
            switch (action) {
                case "add":
                    addItemtoCart(req, cart);
                    break;
                case "update":
                    updateItemInCart(req, cart);
                    break;
                case "delete":
                    deleteItemFromCart(req, cart);
                    break;
                default:
                    // Unknown action, just redirect to cart
                    break;
            }
        } catch (NumberFormatException e) {
            // Handle invalid numeric parameters
            System.err.println("Error processing cart action: " + e.getMessage());
        }
        
        res.sendRedirect("cart.jsp");
    }
    
    private void deleteItemFromCart(HttpServletRequest req, Cart cart) {
        String itemIdStr = req.getParameter("itemId");
        if (itemIdStr != null && !itemIdStr.isEmpty()) {
            int itemId = Integer.parseInt(itemIdStr);
            cart.removeItem(itemId);
        }
    }
    
    private void updateItemInCart(HttpServletRequest req, Cart cart) {
        String itemIdStr = req.getParameter("itemId");
        String quantityStr = req.getParameter("quantity");
        
        if (itemIdStr != null && !itemIdStr.isEmpty() && 
            quantityStr != null && !quantityStr.isEmpty()) {
            int itemId = Integer.parseInt(itemIdStr);
            int quantity = Integer.parseInt(quantityStr);
            cart.updateItem(itemId, quantity);
        }
    }
    
    private void addItemtoCart(HttpServletRequest req, Cart cart) {
        String menuIdStr = req.getParameter("menuId");
        String quantityStr = req.getParameter("quantity");
        
        if (menuIdStr == null || menuIdStr.isEmpty() || 
            quantityStr == null || quantityStr.isEmpty()) {
            return;
        }
        
        int menuId = Integer.parseInt(menuIdStr);
        int quantity = Integer.parseInt(quantityStr);
        
        MenuDaoImpl menuDaoImpl = new MenuDaoImpl();
        Menuu menu = menuDaoImpl.getMenu(menuId);
        
        if (menu != null) {
            String itemname = menu.getItemName();
            double price = menu.getPrice();
            CartItem cartItem = new CartItem(menuId, itemname, quantity, price);
            cart.addItem(cartItem);
        }
    }
}

	package com.zestyfy;

	import java.io.IOException;

import com.zestyfy.daoimpl.OrderDaoImpl;
	import com.zestyfy.daoimpl.OrderItemDaoImpl;
import com.zestyfy.model.Order;
import com.zestyfy.model.OrderItem;

import jakarta.servlet.ServletException;
	import jakarta.servlet.annotation.WebServlet;
	import jakarta.servlet.http.HttpServlet;
	import jakarta.servlet.http.HttpServletRequest;
	import jakarta.servlet.http.HttpServletResponse;
	import jakarta.servlet.http.HttpSession;

	@WebServlet("/order")
	public class OrderServlet extends HttpServlet {
	    
	    @Override
	    protected void doPost(HttpServletRequest req, HttpServletResponse res) 
	            throws ServletException, IOException {
	        
	        HttpSession session = req.getSession();
	        Cart cart = (Cart) session.getAttribute("cart");
	        Integer userId = (Integer) session.getAttribute("userId"); // If user is logged in
	        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
	        
	        // Validate cart - if empty, redirect back
	        if (cart == null || cart.getItems().isEmpty()) {
	            res.sendRedirect("cart.jsp");
	            return;
	        }
	        
	        // Get form data from checkout.jsp
	        String name = req.getParameter("name");
	        String phone = req.getParameter("phone");
	        String email = req.getParameter("email");
	        String address = req.getParameter("address");
	        String city = req.getParameter("city");
	        String pincode = req.getParameter("pincode");
	        String paymentMethod = req.getParameter("paymentMethod");
	        String instructions = req.getParameter("instructions");
	        String totalAmountStr = req.getParameter("totalAmount");
	        
	        // Validate required fields
	        if (name == null || name.trim().isEmpty() || 
	            phone == null || phone.trim().isEmpty() || 
	            address == null || address.trim().isEmpty() || 
	            city == null || city.trim().isEmpty() || 
	            pincode == null || pincode.trim().isEmpty() || 
	            totalAmountStr == null) {
	            
	            req.setAttribute("errorMessage", "Please fill all required fields");
	            req.getRequestDispatcher("checkout.jsp").forward(req, res);
	            return;
	        }
	        
	        try {
	            double totalAmount = Double.parseDouble(totalAmountStr);
	            
	            // Create full delivery address
	            String fullAddress = address + ", " + city + " - " + pincode;
	            
	            // Create Order object
	            Order order = new Order();
	            order.setUserId(userId != null ? userId : 0); // 0 for guest users
	            order.setRestaurantId(restaurantId != null ? restaurantId : 0);
	            order.setTotalAmount(totalAmount);
	            order.setStatus("Pending");
	            order.setPaymentMethod(paymentMethod != null ? paymentMethod : "COD");
	            order.setDeliveryAddress(fullAddress);
	            order.setCustomerName(name.trim());
	            order.setCustomerPhone(phone.trim());
	            order.setCustomerEmail(email != null ? email.trim() : "");
	            order.setSpecialInstructions(instructions != null ? instructions.trim() : "");
	            
	            // Save order to database
	            OrderDaoImpl orderDao = new OrderDaoImpl();
	            int orderId = orderDao.addOrder(order);
	            
	            if (orderId > 0) {
	                // Order created successfully, now save order items
	                OrderItemDaoImpl orderItemDao = new OrderItemDaoImpl();
	                
	                for (CartItem cartItem : cart.getItems().values()) {
	                    OrderItem orderItem = new OrderItem();
	                    orderItem.setOrderId(orderId);
	                    orderItem.setMenuId(cartItem.getItemId());
	                    orderItem.setQuantity(cartItem.getQuantity());
	                    orderItem.setPrice(cartItem.getPrice());
	                    
	                    orderItemDao.addOrderItem(orderItem);
	                }
	                
	                // Clear cart after successful order placement
	                cart.clear();
	                
	                // Store order ID in session for confirmation page
	                session.setAttribute("lastOrderId", orderId);
	                
	                // Redirect to order confirmation page
	                res.sendRedirect("orderConfirmation.jsp");
	                
	            } else {
	                // Order creation failed
	                req.setAttribute("errorMessage", "Failed to place order. Please try again.");
	                req.getRequestDispatcher("checkout.jsp").forward(req, res);
	            }
	            
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	            req.setAttribute("errorMessage", "Invalid amount format");
	            req.getRequestDispatcher("checkout.jsp").forward(req, res);
	        } catch (Exception e) {
	            e.printStackTrace();
	            req.setAttribute("errorMessage", "An error occurred. Please try again.");
	            req.getRequestDispatcher("checkout.jsp").forward(req, res);
	        }
	    }
	    
	    @Override
	    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
	            throws ServletException, IOException {
	        // Redirect GET requests to checkout page
	        res.sendRedirect("checkout.jsp");
	    }
	}


/*-- Use zestyfy database
USE zestyfy;

-- Create Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT DEFAULT 0,
    restaurant_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    payment_method VARCHAR(50) NOT NULL,
    delivery_address TEXT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(15) NOT NULL,
    customer_email VARCHAR(100),
    special_instructions TEXT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id) ON DELETE CASCADE
);

-- Create Order Items Table
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    menu_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (menu_id) REFERENCES menu(id) ON DELETE CASCADE
);

-- Create indexes for better performance
CREATE INDEX idx_user_orders ON orders(user_id);
CREATE INDEX idx_restaurant_orders ON orders(restaurant_id);
CREATE INDEX idx_order_items ON order_items(order_id);*/
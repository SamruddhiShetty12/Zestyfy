package com.zestyfy;

import java.io.IOException;
import java.util.List;

import com.zestyfy.*;
import com.zestyfy.dao.RestuarantDao;
import com.zestyfy.daoimpl.RestaurantDaoImpl;
import com.zestyfy.model.Restaurant;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
		@Override
		protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		    System.out.println("hi from homeservlet");// to check whether home servlet works
		    try {
		        RestuarantDao impl = new RestaurantDaoImpl();
		        List<Restaurant> allRestaurant = impl.getAllRestaurants();
		        System.out.println("DATA FROM DB = " + allRestaurant);
		        System.out.println("List size: " + allRestaurant.size());  // Check if empty
		        req.setAttribute("allRestaurant", allRestaurant);
		        RequestDispatcher rd = req.getRequestDispatcher("home.jsp");
		        rd.forward(req, res);
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}
	}


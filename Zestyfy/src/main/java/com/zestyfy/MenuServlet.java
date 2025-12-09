package com.zestyfy;

import java.io.IOException;
import java.util.List;

import com.zestyfy.daoimpl.MenuDaoImpl;
import com.zestyfy.model.Menuu;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/menu")
public class MenuServlet  extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		MenuDaoImpl impl=new MenuDaoImpl();
		int id=Integer.parseInt(req.getParameter("restaurantId"));//  getting restid from home.jsp
		List<Menuu>allMenubyresto=impl.getAllMenuByRestaurant(id);
		req.setAttribute("allMenubyresto", allMenubyresto);
		RequestDispatcher rd = req.getRequestDispatcher("menu.jsp");
        rd.forward(req, res);
	
	
	}
}

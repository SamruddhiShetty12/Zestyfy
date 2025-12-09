package com.zestyfy.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.zestfy.util.DBconnection;
import com.zestyfy.dao.RestuarantDao;
import com.zestyfy.model.Restaurant;

public class RestaurantDaoImpl implements RestuarantDao {
	   private static final String GET_ALL ="SELECT * FROM restaurant";   // table name: restaurant
		    @Override
		    public List<Restaurant> getAllRestaurants() {

		        List<Restaurant> list = new ArrayList<>();

		        try (Connection con = DBconnection.getConnection();
		             PreparedStatement ptmt = con.prepareStatement(GET_ALL)) {

		            ResultSet rs = ptmt.executeQuery();

		            while (rs.next()) {
		                Restaurant r = new Restaurant();

		                r.setId(rs.getInt("id"));
		                r.setName(rs.getString("name"));
		                r.setImage(rs.getString("image"));
		                r.setRating(rs.getDouble("rating"));
		                r.setEta(rs.getInt("eta"));
		                r.setAddress(rs.getString("address"));
		                r.setDescription(rs.getString("description"));

		                list.add(r);
		            }

		        } catch (Exception e) {
		            e.printStackTrace();
		        }

		        return list;
		    }
		

     }


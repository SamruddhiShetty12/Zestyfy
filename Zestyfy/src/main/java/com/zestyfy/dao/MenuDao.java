package com.zestyfy.dao;

import java.util.List;

import com.zestyfy.model.Menuu;
import com.zestyfy.model.Restaurant;

public interface MenuDao {
	List<Menuu> getAllMenuByRestaurant(int restaurantId);
	Menuu getMenu(int id);
}

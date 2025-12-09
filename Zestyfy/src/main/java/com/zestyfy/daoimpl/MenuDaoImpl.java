package com.zestyfy.daoimpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.zestyfy.dao.MenuDao;
import com.zestyfy.model.Menuu;
import com.zestfy.util.DBconnection;

public class MenuDaoImpl implements MenuDao {

    // ✅ Get all menu items for one restaurant
    private static final String GET_MENU_BY_RESTAURANT =
            "SELECT * FROM menu WHERE restaurantId = ?";

    //  Get item by menu ID
    private static final String GET_MENU_BY_ID =
            "SELECT * FROM menu WHERE id = ?";

    // ------------------------------------------
    // METHOD: getAllMenuByRestaurant
    // ------------------------------------------
    @Override
    public List<Menuu> getAllMenuByRestaurant(int restaurantId) {

        List<Menuu> menuList = new ArrayList<>();

        try (
            Connection con = DBconnection.getConnection();
            PreparedStatement ps = con.prepareStatement(GET_MENU_BY_RESTAURANT)
        ) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Menuu menu = new Menuu();

                menu.setId(rs.getInt("id"));
                menu.setRestaurantId(rs.getInt("restaurantId"));
                menu.setItemName(rs.getString("itemName"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getDouble("price"));
                menu.setRating(rs.getDouble("rating"));
                menu.setImage(rs.getString("image"));

                menuList.add(menu);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menuList;
    }

    // ------------------------------------------
    //  METHOD: getMenu
    // ------------------------------------------
    @Override
    public Menuu getMenu(int id) {

        Menuu menu = null;

        try (
            Connection con = DBconnection.getConnection();
            PreparedStatement ps = con.prepareStatement(GET_MENU_BY_ID)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                menu = new Menuu();

                menu.setId(rs.getInt("id"));
                menu.setRestaurantId(rs.getInt("restaurantId"));
                menu.setItemName(rs.getString("itemName"));
                menu.setDescription(rs.getString("description"));
                menu.setPrice(rs.getDouble("price"));
                menu.setRating(rs.getDouble("rating"));
                menu.setImage(rs.getString("image"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return menu;
    }
}

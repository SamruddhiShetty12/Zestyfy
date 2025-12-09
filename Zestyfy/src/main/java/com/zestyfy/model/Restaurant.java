package com.zestyfy.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Restaurant {
	    private int id;
	    private String name;
	    private String image;
	    private double rating;
	    private int eta;
	    private String address;
	    private String description;

	    //  No-Argument Constructor
	    public Restaurant() {
	    }

	    // Parameterized Constructor
	    public Restaurant(int id, String name, String image, double rating, int eta,
	                      String address, String description) {

	        this.id = id;
	        this.name = name;
	        this.image = image;
	        this.rating = rating;
	        this.eta = eta;
	        this.address = address;
	        this.description = description;
	    }
	    public Restaurant( String name, String image, double rating, int eta,
                String address, String description) {
  this.name = name;
  this.image = image;
  this.rating = rating;
  this.eta = eta;
  this.address = address;
  this.description = description;
}

	    // ✅ Getters and Setters

	    public int getId() {
	        return id;
	    }
	    public void setId(int id) {
	        this.id = id;
	    }

	    public String getName() {
	        return name;
	    }
	    public void setName(String name) {
	        this.name = name;
	    }
	    
	    public String getImage() {
	        return image;
	    }
	    public void setImage(String image) {
	        this.image = image;
	    }

	    public double getRating() {
	        return rating;
	    }
	    public void setRating(double rating) {
	        this.rating = rating;
	    }

	    public int getEta() {
	        return eta;
	    }
	    public void setEta(int eta) {
	        this.eta = eta;
	    }

	    public String getAddress() {
	        return address;
	    }
	    public void setAddress(String address) {
	        this.address = address;
	    }

	    public String getDescription() {
	        return description;
	    }
	    public void setDescription(String description) {
	        this.description = description;
	    }

	}



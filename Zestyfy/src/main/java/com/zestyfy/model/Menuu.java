package com.zestyfy.model;

public class Menuu {
	private int id;
    private int restaurantId;
    private String itemName;
    private String description;
    private double price;
    private double rating;
    private String image;

    // ✅ No-argument constructor
    public Menuu() {
    }

    // ✅ Parameterized constructor
    public Menuu(int id, int restaurantId, String itemName, String description,
                double price, double rating, String image) {
        this.id = id;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.rating = rating;
        this.image = image;
    }
    public Menuu( int restaurantId, String itemName, String description,
            double price, double rating, String image) {
    this.restaurantId = restaurantId;
    this.itemName = itemName;
    this.description = description;
    this.price = price;
    this.rating = rating;
    this.image = image;
}
    public Menuu(  String itemName, String description,
            double price, double rating, String image) {
    this.itemName = itemName;
    this.description = description;
    this.price = price;
    this.rating = rating;
    this.image = image;
}
    // ✅ Getters and Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    } 

    public void setPrice(double price) {
        this.price = price;
    }

    public double getRating() {
        return rating;
    } 

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getImage() {
        return image;
    } 

    public void setImage(String image) {
        this.image = image;
    }
}

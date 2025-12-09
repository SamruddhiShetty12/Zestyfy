package com.zestyfy;

public class CartItem {
private int itemId;
private String name;
private int quantity;
private double price;
public CartItem() {
	// TODO Auto-generated constructor stub
}
public CartItem(int itemId, String name, int quantity, double price) {
	super();
	this.itemId = itemId;
	this.name = name;
	this.quantity = quantity;
	this.price = price;
}
public int getItemId() {
	return itemId;
}
public void setItemId(int itemId) {
	this.itemId = itemId;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public int getQuantity() {
	return quantity;
}
public void setQuantity(int quantity) {
	this.quantity = quantity;
}
public double getPrice() {
	return price;
}
public void setPrice(double price) {
	this.price = price;
}
public double getTotalPrice() {
    return price * quantity;
}

}

package com.zestyfy;

import java.util.HashMap;
import java.util.Map;

public class Cart {
private Map<Integer,CartItem>items;
public Cart() {
	this.items=new HashMap<>();
}
public void addItem(CartItem item) {
	int itemId=item.getItemId();
	if(items.containsKey(itemId)) {
		CartItem existingItem=items.get(itemId);
		int newQua=item.getQuantity();
		int oldQua=existingItem.getQuantity();
		int sumqua=newQua+oldQua;
		existingItem.setQuantity(sumqua);
		//existingItem.setQuantity(existingItem.getQuantity()+item.getQuantity());//can also write like this
	}else {
		items.put(itemId, item);
	}
} public void updateItem(int itemId,int quantity) {//itemid,quantity both are present in request object send it to update method in cartservlet
	if(items.containsKey(itemId)) {
		if(quantity<=0) {
		items.remove(itemId);
	}else {
		CartItem existingcartItem=items.get(itemId);
		existingcartItem.setQuantity(quantity);
	}
}
}
public  void removeItem(int itemId) {
	items.remove(itemId);
}
public Map<Integer,CartItem>getItems(){
	return items;
}
public double getTotalPrice() {
	return items.values().stream().mapToDouble(item->item.getPrice()*item.getQuantity()).sum();
}
public void clear() {
	items.clear();
}
}

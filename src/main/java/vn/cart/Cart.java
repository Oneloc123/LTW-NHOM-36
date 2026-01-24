package vn.cart;

import vn.model.Product;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

public class Cart implements Serializable {
    Map<Integer, CartItem> data;
    public Cart(){
        data = new HashMap<Integer, CartItem>();
    }
    public void addItem(Product product, int quantity){
        System.out.println("=== CART.addItem() START ===");
        System.out.println("Adding product ID: " + product.getId());
        System.out.println("Product name: " + product.getName());
        System.out.println("Quantity: " + quantity);
        System.out.println("Price: " + product.getPrice());

        if(quantity <= 0){
            quantity = 1;
            System.out.println("Quantity adjusted to: " + quantity);
        }

        if(!data.containsKey(product.getId())){
            System.out.println("Creating new CartItem...");
            CartItem newItem = new CartItem(product, quantity, product.getPrice());
            System.out.println("CartItem created: " + newItem);
            System.out.println("CartItem product: " + (newItem.getProduct() != null ? newItem.getProduct().getName() : "NULL"));
            System.out.println("CartItem quantity: " + newItem.getQuantity());
            System.out.println("CartItem price: " + newItem.getPrice());

            data.put(product.getId(), newItem);
            System.out.println("New item added to cart. Total items now: " + data.size());
        } else {
            System.out.println("Updating existing item quantity...");
            CartItem existingItem = data.get(product.getId());
            System.out.println("Existing quantity: " + existingItem.getQuantity());
            existingItem.upQuantity(quantity);
            System.out.println("New quantity: " + existingItem.getQuantity());
        }

        System.out.println("Current cart contents:");
        for (Map.Entry<Integer, CartItem> entry : data.entrySet()) {
            CartItem item = entry.getValue();
            System.out.println("  - Product ID: " + entry.getKey() +
                    ", Name: " + (item.getProduct() != null ? item.getProduct().getName() : "NULL") +
                    ", Quantity: " + item.getQuantity() +
                    ", Price: " + item.getPrice());
        }

        System.out.println("=== CART.addItem() END ===");
    }
    public void updateItem(int productId, int quantity) {
        if (data.containsKey(productId) && quantity > 0) {
            CartItem item = data.get(productId);
            item.setQuantity(quantity);
        }
    }
    public CartItem delItem(int id){
        return data.remove(id);
    }
    public List<CartItem>  delAll(){
        List<CartItem> list = new ArrayList<CartItem>(data.values());
        data.clear();
        return list;
    }
    public List<CartItem>  getItems(){
        return new ArrayList<>(data.values());
    }
    public int getTotalQuantity(){
        AtomicInteger total = new AtomicInteger();
        data.values().forEach(c->total.addAndGet(c.getQuantity()));
        return total.get();
    }
    public double getTotal(){
        AtomicReference<Double> sum = new AtomicReference<>((double) 0);
        data.values().forEach(c-> sum.updateAndGet(v -> v + (c.getPrice() * c.getQuantity())));
        return sum.get();
    }
}

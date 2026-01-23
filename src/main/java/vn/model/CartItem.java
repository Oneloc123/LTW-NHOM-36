package vn.model;

import java.io.Serializable;

public class CartItem implements Serializable {

    private int productId;
    private String name;
    private String image;
    private double price;   // ✅ int → double
    private int quantity;

    public CartItem() {
    }

    public CartItem(int productId, String name, String image, double price, int quantity) {
        this.productId = productId;
        this.name = name;
        this.image = image;
        this.price = price;
        this.quantity = quantity;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
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

    // ===== PRICE =====
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {   // ✅ int → double
        this.price = price;
    }

    // ===== QUANTITY =====
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // ===== TOTAL =====
    public double getTotal() {              // ✅ int → double
        return price * quantity;
    }
}

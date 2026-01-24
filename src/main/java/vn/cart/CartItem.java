package vn.cart;

import vn.model.Product;

import java.io.Serializable;

public class CartItem implements Serializable {
    private Product product;
    private int quantity;
    private double price;
    public CartItem() {}
    public CartItem(Product product, int quantity, double price) {
        System.out.println("=== CartItem Constructor ===");
        System.out.println("Product: " + (product != null ? product.getName() : "NULL"));
        System.out.println("Quantity: " + quantity);
        System.out.println("Price: " + price);

        this.product = product;
        this.quantity = quantity;
        this.price = price;

        System.out.println("CartItem created successfully");
        System.out.println("this.product: " + (this.product != null ? this.product.getName() : "NULL"));
        System.out.println("this.quantity: " + this.quantity);
        System.out.println("this.price: " + this.price);
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
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

    public void upQuantity(int quantity) {
        this.quantity += quantity;
    }
}

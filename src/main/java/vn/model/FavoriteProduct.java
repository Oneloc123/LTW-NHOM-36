package vn.model;

import java.io.Serializable;
import java.util.Date;

public class FavoriteProduct implements Serializable {

    private int id;
    private int userId;
    private int productId;
    private String productName;
    private String status;
    private double price;
    private String imageUrl;
    private Date createdAt;

    public FavoriteProduct() {
    }

    // ===== GET =====
    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getStatus() {
        return status;
    }

    public double getPrice() {
        return price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    // ===== SET =====
    public void setId(int id) {
        this.id = id;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}

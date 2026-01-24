package vn.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Wishlist implements Serializable {
    private int id;
    private int userId;
    private int productId;
    private Timestamp addedDate;

    // Constructor đầy đủ
    public Wishlist(int id, int userId, int productId, Timestamp addedDate) {
        this.id = id;
        this.userId = userId;
        this.productId = productId;
        this.addedDate = addedDate;
    }

    // Constructor không có id (cho thêm mới)
    public Wishlist(int userId, int productId) {
        this.userId = userId;
        this.productId = productId;
        this.addedDate = new Timestamp(System.currentTimeMillis());
    }

    // Constructor rỗng
    public Wishlist() {}

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Timestamp getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Timestamp addedDate) {
        this.addedDate = addedDate;
    }
}
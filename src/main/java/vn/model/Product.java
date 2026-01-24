package vn.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

// Dùng javabean yêu cầu phải implement Serializable
public class Product implements Serializable {
    private int id;
    private String name;
    private int categoryID;
    private String shortDescription;
    private String fullDescription;
    private int price;
    private boolean isFeatured;
    private String createAt;
    private String updateAt;
    private List<String> images = new ArrayList<>();
    private double avgRating;
    private int ratingCount;


    public Product(int id, String name, int categoryID, String shortDescription, String fullDescription, int price, boolean isFeatured, String createAt, String updateAt, List<String> images) {
        this.id = id;
        this.name = name;
        this.categoryID = categoryID;
        this.shortDescription = shortDescription;
        this.fullDescription = fullDescription;
        this.price = price;
        this.isFeatured = isFeatured;
        this.createAt = createAt;
        this.updateAt = updateAt;
        this.images = images;
    }

    public List<String> getImages() {
        return images;
    }

    public String getImagesTop() {
        if(images == null || images.isEmpty()) return null;
        return images.get(0);
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public int getRatingCount() {
        return ratingCount;
    }

    public void setRatingCount(int ratingCount) {
        this.ratingCount = ratingCount;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public Product() {}

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

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getFullDescription() {
        return fullDescription;
    }

    public void setFullDescription(String fullDescription) {
        this.fullDescription = fullDescription;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public boolean isFeatured() {
        return isFeatured;
    }

    public void setFeatured(boolean featured) {
        isFeatured = featured;
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }

    public String getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(String updateAt) {
        this.updateAt = updateAt;
    }
}

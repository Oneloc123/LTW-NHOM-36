package vn.model;

public class FavoriteProduct {

    private int productId;
    private String productName;
    private String imageUrl;
    private double price;
    private String status;

    // ⚠️ BẮT BUỘC: constructor rỗng cho JSP
    public FavoriteProduct() {
    }

    public FavoriteProduct(int productId, String productName, String imageUrl, double price, String status) {
        this.productId = productId;
        this.productName = productName;
        this.imageUrl = imageUrl;
        this.price = price;
        this.status = status;
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public double getPrice() {
        return price;
    }

    public String getStatus() {
        return status;
    }
}

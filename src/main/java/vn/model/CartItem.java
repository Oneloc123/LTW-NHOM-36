package vn.model;

public class CartItem {
    private int productId;
    private Product product;
    private String name;
    private String image;
    private double price;
    private int quantity;
    private double total;

    // Constructors
    public CartItem() {}

    public CartItem(int productId, Product product, int quantity) {
        this.productId = productId;
        this.product = product;
        this.name = product.getName();
        this.image = product.getImagesTop();
        this.price = product.getPrice();
        this.quantity = quantity;
        this.total = price * quantity;
    }

    // Getters and Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) {
        this.product = product;
        if (this.name == null && product != null) {
            this.name = product.getName();
        }
        if (this.image == null && product != null) {
            this.image = product.getImagesTop();
        }
        if (this.price == 0 && product != null) {
            this.price = product.getPrice();
        }
    }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public double getPrice() { return price; }
    public void setPrice(double price) {
        this.price = price;
        calculateTotal();
    }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        calculateTotal();
    }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    private void calculateTotal() {
        this.total = this.price * this.quantity;
    }

    // Helper method để tăng số lượng
    public void increaseQuantity(int amount) {
        this.quantity += amount;
        calculateTotal();
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "productId=" + productId +
                ", name='" + name + '\'' +
                ", quantity=" + quantity +
                ", price=" + price +
                ", total=" + total +
                '}';
    }
}
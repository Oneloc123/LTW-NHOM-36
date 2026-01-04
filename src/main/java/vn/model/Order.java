package vn.model;

public class Order {
    private int id;
    private int userId;
    private String orderStatus;
    private String createAt;
    private double total;

    public Order() {}

    public Order(int id, int userId, String orderStatus, String createAt, double total) {
        this.id = id;
        this.userId = userId;
        this.orderStatus = orderStatus;
        this.createAt = createAt;
        this.total = total;
    }

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

    public String getOrderStatus() {
        return orderStatus;
    }
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCreateAt() {
        return createAt;
    }
    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }

    public double getTotal() {
        return total;
    }
    public void setTotal(double total) {
        this.total = total;
    }
}

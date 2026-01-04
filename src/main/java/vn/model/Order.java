package vn.model;

public class Order {
    private int id;
    private int userId;
    private int addressId;
    private String OrderStatus; //trạng thái giao hàng
    private  String createAt;

    public Order(int id, int userId, int addressId, String orderStatus, String createAt) {
        this.id = id;
        this.userId = userId;
        this.addressId = addressId;
        OrderStatus = orderStatus;
        this.createAt = createAt;
    }
    public Order(){}

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

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getOrderStatus() {
        return OrderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        OrderStatus = orderStatus;
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt;
    }
}

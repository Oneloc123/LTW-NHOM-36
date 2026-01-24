package vn.model;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Order implements Serializable {
    private int id;
    private int userId;
    private Timestamp orderDate;
    private double totalAmount;
    private String shippingAddress;
    private String phoneNumber;
    private String email;
    private String status;
    private String paymentMethod;
    private String paymentStatus;
    private String notes;

    // Danh sách sản phẩm trong đơn hàng
    private List<OrderItem> items = new ArrayList<>();

    public Order() {}

    public Order(int id, int userId, Timestamp orderDate, double totalAmount,
                 String shippingAddress, String phoneNumber, String email,
                 String status, String paymentMethod, String paymentStatus,
                 String notes) {
        this.id = id;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.shippingAddress = shippingAddress;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.notes = notes;
    }

    // Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    public void addItem(OrderItem item) {
        this.items.add(item);
    }

    // Phương thức tiện ích
    public String getStatusDisplay() {
        switch (status) {
            case "pending": return "Đang chờ xử lý";
            case "processing": return "Đang xử lý";
            case "shipped": return "Đang giao hàng";
            case "delivered": return "Đã giao hàng";
            case "cancelled": return "Đã hủy";
            default: return status;
        }
    }

    public String getPaymentStatusDisplay() {
        switch (paymentStatus) {
            case "unpaid": return "Chưa thanh toán";
            case "paid": return "Đã thanh toán";
            case "refunded": return "Đã hoàn tiền";
            default: return paymentStatus;
        }
    }

    public String getPaymentMethodDisplay() {
        switch (paymentMethod) {
            case "cod": return "Thanh toán khi nhận hàng";
            case "bank_transfer": return "Chuyển khoản ngân hàng";
            case "credit_card": return "Thẻ tín dụng";
            case "paypal": return "PayPal";
            default: return paymentMethod;
        }
    }
}
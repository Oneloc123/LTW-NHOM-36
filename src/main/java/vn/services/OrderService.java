package vn.services;

import vn.cart.CartItem;
import vn.dao.OrderDao;
import vn.model.Order;
import vn.model.OrderItem;

import java.util.List;

public class OrderService {
    private OrderDao orderDao = new OrderDao();

    // Lấy danh sách đơn hàng của user
    public List<Order> getUserOrders(int userId) {
        return orderDao.getOrdersByUserId(userId);
    }

    // Lấy chi tiết đơn hàng của user
    public Order getOrderDetail(int orderId, int userId) {
        return orderDao.getOrderById(orderId, userId);
    }

    // Tạo đơn hàng mới từ giỏ hàng
    public int createOrder(Order order, List<CartItem> cartItems) {
        return orderDao.createOrder(order, cartItems);
    }

    // Hủy đơn hàng
    public boolean cancelOrder(int orderId, int userId) {
        return orderDao.cancelOrder(orderId, userId);
    }

    // Đếm số đơn hàng của user
    public int countUserOrders(int userId) {
        return orderDao.countOrdersByUserId(userId);
    }

    // Tính tổng tiền cho đơn hàng
    public double calculateTotal(List<OrderItem> items) {
        double total = 0;
        for (OrderItem item : items) {
            total += item.getSubtotal();
        }
        return total;
    }
    // Tính tổng tiền từ cart items
    public double calculateTotalFromCart(List<CartItem> cartItems) {
        double total = 0;
        for (CartItem item : cartItems) {
            total += item.getPrice() * item.getQuantity();
        }
        return total;
    }


    // Lấy các trạng thái đơn hàng
    public String[] getOrderStatuses() {
        return new String[]{"pending", "processing", "shipped", "delivered", "cancelled"};
    }

    // Lấy các phương thức thanh toán
    public String[] getPaymentMethods() {
        return new String[]{"cod", "bank_transfer", "credit_card", "paypal"};
    }
}
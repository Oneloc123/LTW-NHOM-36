package vn.dao;

import vn.cart.CartItem;
import vn.model.Order;
import vn.model.OrderItem;
import org.jdbi.v3.core.Jdbi;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDao extends BaseDao {


    // Lấy tất cả đơn hàng (dành cho admin)
    public List<Order> getAllOrders() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                        "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                        "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                        "FROM orders ORDER BY order_date DESC"
                        )
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // Lấy đơn hàng theo user ID
    public List<Order> getOrdersByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                        "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                        "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                        "FROM orders WHERE user_id = ? ORDER BY order_date DESC"
                        )
                        .bind(0, userId)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // Lấy đơn hàng theo ID và kiểm tra user ID (bảo mật)
    public Order getOrderById(int orderId, int userId) {
        return get().withHandle(h -> {
            Order order = h.createQuery(
                            "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                    "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                    "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                    "FROM orders WHERE id = ? AND user_id = ?"
                    )
                    .bind(0, orderId)
                    .bind(1, userId)
                    .mapToBean(Order.class)
                    .findOne()
                    .orElse(null);

            if (order != null) {
                // Lấy danh sách sản phẩm trong đơn hàng
                List<OrderItem> items = getOrderItems(orderId);
                order.setItems(items);
            }

            return order;
        });
    }

    // Lấy đơn hàng theo ID (không kiểm tra user, dùng cho admin)
    public Order getOrderById(int orderId) {
        return get().withHandle(h -> {
            Order order = h.createQuery(
                            "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                    "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                    "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                    "FROM orders WHERE id = ?"
                    )
                    .bind(0, orderId)
                    .mapToBean(Order.class)
                    .findOne()
                    .orElse(null);

            if (order != null) {
                List<OrderItem> items = getOrderItems(orderId);
                order.setItems(items);
            }

            return order;
        });
    }

    // Tạo đơn hàng mới từ Cart
    public int createOrder(Order order, List<CartItem> cartItems) {
        return get().withHandle(h -> {
            // Chèn đơn hàng
            int orderId = h.createUpdate(
                            "INSERT INTO orders (user_id, order_date, total_amount, shipping_address, " +
                                    "phone_number, email, status, payment_method, payment_status, notes) " +
                                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
                    )
                    .bind(0, order.getUserId())
                    .bind(1, order.getOrderDate() != null ? order.getOrderDate() : new Timestamp(System.currentTimeMillis()))
                    .bind(2, order.getTotalAmount())
                    .bind(3, order.getShippingAddress())
                    .bind(4, order.getPhoneNumber())
                    .bind(5, order.getEmail())
                    .bind(6, order.getStatus() != null ? order.getStatus() : "pending")
                    .bind(7, order.getPaymentMethod())
                    .bind(8, order.getPaymentStatus() != null ? order.getPaymentStatus() : "unpaid")
                    .bind(9, order.getNotes())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();

            // Chèn từng OrderItem
            for (CartItem cartItem : cartItems) {
                double subtotal = cartItem.getPrice() * cartItem.getQuantity();
                h.createUpdate(
                                "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) " +
                                        "VALUES (?, ?, ?, ?, ?)"
                        )
                        .bind(0, orderId)
                        .bind(1, cartItem.getProduct().getId())
                        .bind(2, cartItem.getQuantity())
                        .bind(3, cartItem.getPrice())
                        .bind(4, subtotal)
                        .execute();
            }

            return orderId;
        });
    }

    // Hủy đơn hàng (chỉ cho user đó)
    public boolean cancelOrder(int orderId, int userId) {
        int rows = get().withHandle(h ->
                h.createUpdate("UPDATE orders SET status = 'cancelled', updated_at = CURRENT_TIMESTAMP WHERE id = ? AND user_id = ?")
                        .bind(0, orderId)
                        .bind(1, userId)
                        .execute()
        );
        return rows > 0;
    }

    // Đếm số đơn hàng của user
    public int countOrdersByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM orders WHERE user_id = ?")
                        .bind(0, userId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // Lấy các OrderItem theo orderId
    public List<OrderItem> getOrderItems(int orderId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, order_id as orderId, product_id as productId, quantity, " +
                                        "unit_price as unitPrice, subtotal " +
                                        "FROM order_items WHERE order_id = ?"
                        )
                        .bind(0, orderId)
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String status) {
        int rows = get().withHandle(h ->
                h.createUpdate("UPDATE orders SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?")
                        .bind(0, status)
                        .bind(1, orderId)
                        .execute()
        );
        return rows > 0;
    }

    // Cập nhật trạng thái thanh toán
    public boolean updatePaymentStatus(int orderId, String paymentStatus) {
        int rows = get().withHandle(h ->
                h.createUpdate("UPDATE orders SET payment_status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?")
                        .bind(0, paymentStatus)
                        .bind(1, orderId)
                        .execute()
        );
        return rows > 0;
    }

    // Lấy đơn hàng theo trạng thái
    public List<Order> getOrdersByStatus(String status) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                        "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                        "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                        "FROM orders WHERE status = ? ORDER BY order_date DESC"
                        )
                        .bind(0, status)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // Lấy đơn hàng theo trạng thái thanh toán
    public List<Order> getOrdersByPaymentStatus(String paymentStatus) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                        "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                        "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                        "FROM orders WHERE payment_status = ? ORDER BY order_date DESC"
                        )
                        .bind(0, paymentStatus)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // Lấy tổng doanh thu
    public double getTotalRevenue() {
        return get().withHandle(h ->
                h.createQuery("SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'delivered' AND payment_status = 'paid'")
                        .mapTo(Double.class)
                        .one()
        );
    }

    // Lấy số đơn hàng theo tháng
    public int getOrdersCountByMonth(int year, int month) {
        return get().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM orders WHERE YEAR(order_date) = ? AND MONTH(order_date) = ?")
                        .bind(0, year)
                        .bind(1, month)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // Xóa đơn hàng (admin only)
    public boolean deleteOrder(int orderId) {
        int rows = get().withHandle(h ->
                h.createUpdate("DELETE FROM orders WHERE id = ?")
                        .bind(0, orderId)
                        .execute()
        );
        return rows > 0;
    }

    // Tìm kiếm đơn hàng theo nhiều tiêu chí (admin)
    public List<Order> searchOrders(String keyword, String status, String paymentStatus) {
        return get().withHandle(h -> {
            StringBuilder sql = new StringBuilder(
                    "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                            "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                            "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                            "FROM orders WHERE 1=1"
            );

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND (email LIKE ? OR phone_number LIKE ? OR shipping_address LIKE ?)");
            }
            if (status != null && !status.trim().isEmpty()) {
                sql.append(" AND status = ?");
            }
            if (paymentStatus != null && !paymentStatus.trim().isEmpty()) {
                sql.append(" AND payment_status = ?");
            }
            sql.append(" ORDER BY order_date DESC");

            var query = h.createQuery(sql.toString());

            int paramIndex = 0;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword.trim() + "%";
                query.bind(paramIndex++, likeKeyword)
                        .bind(paramIndex++, likeKeyword)
                        .bind(paramIndex++, likeKeyword);
            }
            if (status != null && !status.trim().isEmpty()) {
                query.bind(paramIndex++, status.trim());
            }
            if (paymentStatus != null && !paymentStatus.trim().isEmpty()) {
                query.bind(paramIndex++, paymentStatus.trim());
            }

            return query.mapToBean(Order.class).list();
        });
    }
    // 1. Lấy tất cả đơn hàng (dành cho admin)


    // 2. Tìm kiếm đơn hàng với nhiều tiêu chí
    public List<Order> searchOrders(String keyword, String status, String paymentStatus, String userId) {
        return get().withHandle(h -> {
            StringBuilder sql = new StringBuilder(
                    "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                            "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                            "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                            "FROM orders WHERE 1=1"
            );

            // Thêm điều kiện tìm kiếm
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND (email LIKE ? OR phone_number LIKE ? OR shipping_address LIKE ? OR notes LIKE ?)");
            }
            if (status != null && !status.trim().isEmpty()) {
                sql.append(" AND status = ?");
            }
            if (paymentStatus != null && !paymentStatus.trim().isEmpty()) {
                sql.append(" AND payment_status = ?");
            }
            if (userId != null && !userId.trim().isEmpty()) {
                try {
                    int userIdInt = Integer.parseInt(userId);
                    sql.append(" AND user_id = ?");
                } catch (NumberFormatException e) {
                    // Nếu không phải số, không thêm điều kiện
                }
            }

            sql.append(" ORDER BY order_date DESC");

            var query = h.createQuery(sql.toString());

            int paramIndex = 0;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword.trim() + "%";
                query.bind(paramIndex++, likeKeyword)
                        .bind(paramIndex++, likeKeyword)
                        .bind(paramIndex++, likeKeyword)
                        .bind(paramIndex++, likeKeyword);
            }
            if (status != null && !status.trim().isEmpty()) {
                query.bind(paramIndex++, status.trim());
            }
            if (paymentStatus != null && !paymentStatus.trim().isEmpty()) {
                query.bind(paramIndex++, paymentStatus.trim());
            }
            if (userId != null && !userId.trim().isEmpty()) {
                try {
                    int userIdInt = Integer.parseInt(userId);
                    query.bind(paramIndex++, userIdInt);
                } catch (NumberFormatException e) {
                    // Bỏ qua nếu không phải số
                }
            }

            return query.mapToBean(Order.class).list();
        });
    }

    // 3. Cập nhật thông tin đơn hàng
    public boolean updateOrder(Order order) {
        int rows = get().withHandle(h ->
                h.createUpdate(
                                "UPDATE orders SET " +
                                        "shipping_address = ?, " +
                                        "phone_number = ?, " +
                                        "email = ?, " +
                                        "total_amount = ?, " +
                                        "status = ?, " +
                                        "payment_method = ?, " +
                                        "payment_status = ?, " +
                                        "notes = ?, " +
                                        "updated_at = CURRENT_TIMESTAMP " +
                                        "WHERE id = ?"
                        )
                        .bind(0, order.getShippingAddress())
                        .bind(1, order.getPhoneNumber())
                        .bind(2, order.getEmail())
                        .bind(3, order.getTotalAmount())
                        .bind(4, order.getStatus())
                        .bind(5, order.getPaymentMethod())
                        .bind(6, order.getPaymentStatus())
                        .bind(7, order.getNotes())
                        .bind(8, order.getId())
                        .execute()
        );
        return rows > 0;
    }


    // 5. Lấy đơn hàng theo khoảng thời gian
    public List<Order> getOrdersByDateRange(Timestamp startDate, Timestamp endDate) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                        "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                        "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                        "FROM orders WHERE order_date BETWEEN ? AND ? " +
                                        "ORDER BY order_date DESC"
                        )
                        .bind(0, startDate)
                        .bind(1, endDate)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // 6. Thống kê đơn hàng theo trạng thái
    public Map<String, Integer> getOrderStatistics() {
        return get().withHandle(h -> {
            Map<String, Integer> stats = new HashMap<>();

            // Tổng số đơn hàng
            int total = h.createQuery("SELECT COUNT(*) FROM orders")
                    .mapTo(Integer.class)
                    .one();
            stats.put("total", total);

            // Đếm theo trạng thái
            List<Map<String, Object>> statusCounts = h.createQuery(
                    "SELECT status, COUNT(*) as count FROM orders GROUP BY status"
            ).mapToMap().list();

            for (Map<String, Object> row : statusCounts) {
                String status = (String) row.get("status");
                Long count = (Long) row.get("count");
                stats.put(status, count.intValue());
            }

            // Doanh thu
            Double revenue = h.createQuery(
                    "SELECT COALESCE(SUM(total_amount), 0) FROM orders " +
                            "WHERE status = 'delivered' AND payment_status = 'paid'"
            ).mapTo(Double.class).one();
            stats.put("revenue", revenue.intValue());

            return stats;
        });
    }

    // 7. Lấy đơn hàng với phân trang
    public List<Order> getOrdersWithPagination(int offset, int limit) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id as userId, order_date as orderDate, total_amount as totalAmount, " +
                                        "shipping_address as shippingAddress, phone_number as phoneNumber, email, status, " +
                                        "payment_method as paymentMethod, payment_status as paymentStatus, notes " +
                                        "FROM orders ORDER BY order_date DESC LIMIT ? OFFSET ?"
                        )
                        .bind(0, limit)
                        .bind(1, offset)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // 8. Đếm tổng số đơn hàng (cho phân trang)
    public int countAllOrders() {
        return get().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM orders")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // 9. Cập nhật chỉ trạng thái
    public boolean updateOrderStatusOnly(int orderId, String status) {
        int rows = get().withHandle(h ->
                h.createUpdate("UPDATE orders SET status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?")
                        .bind(0, status)
                        .bind(1, orderId)
                        .execute()
        );
        return rows > 0;
    }

    // 10. Cập nhật chỉ trạng thái thanh toán
    public boolean updatePaymentStatusOnly(int orderId, String paymentStatus) {
        int rows = get().withHandle(h ->
                h.createUpdate("UPDATE orders SET payment_status = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?")
                        .bind(0, paymentStatus)
                        .bind(1, orderId)
                        .execute()
        );
        return rows > 0;
    }
}
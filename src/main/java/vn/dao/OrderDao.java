package vn.dao;

import vn.model.Order;
import vn.model.OrderItem;
import vn.model.Product;

import java.util.List;

public class OrderDao extends BaseDao {

    // Lấy tất cả đơn hàng của user
    public List<Order> getOrdersByUserId(int userId) {
        return get().withHandle(h -> {
            String sql = """
                SELECT o.* 
                FROM orders o
                WHERE o.user_id = :userId
                ORDER BY o.order_date DESC
            """;

            return h.createQuery(sql)
                    .bind("userId", userId)
                    .map((rs, ctx) -> {
                        Order order = new Order();
                        order.setId(rs.getInt("id"));
                        order.setUserId(rs.getInt("user_id"));
                        order.setOrderDate(rs.getTimestamp("order_date"));
                        order.setTotalAmount(rs.getDouble("total_amount"));
                        order.setShippingAddress(rs.getString("shipping_address"));
                        order.setPhoneNumber(rs.getString("phone_number"));
                        order.setEmail(rs.getString("email"));
                        order.setStatus(rs.getString("status"));
                        order.setPaymentMethod(rs.getString("payment_method"));
                        order.setPaymentStatus(rs.getString("payment_status"));
                        order.setNotes(rs.getString("notes"));

                        return order;
                    })
                    .list();
        });
    }

    // Lấy chi tiết đơn hàng của user
    public Order getOrderById(int orderId, int userId) {
        return get().withHandle(h -> {
            // Lấy thông tin đơn hàng
            String orderSql = """
                SELECT o.* 
                FROM orders o
                WHERE o.id = :orderId AND o.user_id = :userId
            """;

            Order order = h.createQuery(orderSql)
                    .bind("orderId", orderId)
                    .bind("userId", userId)
                    .map((rs, ctx) -> {
                        Order o = new Order();
                        o.setId(rs.getInt("id"));
                        o.setUserId(rs.getInt("user_id"));
                        o.setOrderDate(rs.getTimestamp("order_date"));
                        o.setTotalAmount(rs.getDouble("total_amount"));
                        o.setShippingAddress(rs.getString("shipping_address"));
                        o.setPhoneNumber(rs.getString("phone_number"));
                        o.setEmail(rs.getString("email"));
                        o.setStatus(rs.getString("status"));
                        o.setPaymentMethod(rs.getString("payment_method"));
                        o.setPaymentStatus(rs.getString("payment_status"));
                        o.setNotes(rs.getString("notes"));

                        return o;
                    })
                    .findOne()
                    .orElse(null);

            if (order != null) {
                // Lấy danh sách sản phẩm trong đơn hàng
                String itemsSql = """
                    SELECT oi.*, p.name as product_name, p.price
                    FROM order_items oi
                    LEFT JOIN products p ON oi.product_id = p.id
                    WHERE oi.order_id = :orderId
                """;

                List<OrderItem> items = h.createQuery(itemsSql)
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            OrderItem item = new OrderItem();
                            item.setId(rs.getInt("id"));
                            item.setOrderId(rs.getInt("order_id"));
                            item.setProductId(rs.getInt("product_id"));
                            item.setQuantity(rs.getInt("quantity"));
                            item.setUnitPrice(rs.getDouble("unit_price"));
                            item.setSubtotal(rs.getDouble("subtotal"));

                            // Thêm thông tin sản phẩm
                            Product product = new Product();
                            product.setId(rs.getInt("product_id"));
                            product.setName(rs.getString("product_name"));
                            product.setPrice((int) rs.getDouble("price"));

                            item.setProduct(product);
                            return item;
                        })
                        .list();

                order.setItems(items);
            }

            return order;
        });
    }

    // Tạo đơn hàng mới
    public int createOrder(Order order) {
        return get().withHandle(h -> {
            // Insert order
            h.createUpdate("""
                INSERT INTO orders (user_id, total_amount, shipping_address, 
                                  phone_number, email, status, payment_method, 
                                  payment_status, notes)
                VALUES (:userId, :totalAmount, :shippingAddress, 
                        :phoneNumber, :email, :status, :paymentMethod, 
                        :paymentStatus, :notes)
            """)
                    .bind("userId", order.getUserId())
                    .bind("totalAmount", order.getTotalAmount())
                    .bind("shippingAddress", order.getShippingAddress())
                    .bind("phoneNumber", order.getPhoneNumber())
                    .bind("email", order.getEmail())
                    .bind("status", order.getStatus())
                    .bind("paymentMethod", order.getPaymentMethod())
                    .bind("paymentStatus", order.getPaymentStatus())
                    .bind("notes", order.getNotes())
                    .execute();

            // Lấy ID vừa tạo
            int orderId = h.createQuery("SELECT LAST_INSERT_ID()")
                    .mapTo(Integer.class)
                    .one();

            // Insert order items
            for (OrderItem item : order.getItems()) {
                h.createUpdate("""
                    INSERT INTO order_items (order_id, product_id, quantity, 
                                           unit_price, subtotal)
                    VALUES (:orderId, :productId, :quantity, 
                            :unitPrice, :subtotal)
                """)
                        .bind("orderId", orderId)
                        .bind("productId", item.getProductId())
                        .bind("quantity", item.getQuantity())
                        .bind("unitPrice", item.getUnitPrice())
                        .bind("subtotal", item.getSubtotal())
                        .execute();
            }

            return orderId;
        });
    }

    // Hủy đơn hàng (chỉ hủy được khi ở trạng thái pending)
    public boolean cancelOrder(int orderId, int userId) {
        return get().withHandle(h -> {
            int rows = h.createUpdate("""
                    UPDATE orders 
                    SET status = 'cancelled', updated_at = CURRENT_TIMESTAMP
                    WHERE id = :orderId AND user_id = :userId AND status = 'pending'
                """)
                    .bind("orderId", orderId)
                    .bind("userId", userId)
                    .execute();

            return rows > 0;
        });
    }

    // Đếm số đơn hàng của user
    public int countOrdersByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery("SELECT COUNT(*) FROM orders WHERE user_id = :userId")
                        .bind("userId", userId)
                        .mapTo(Integer.class)
                        .one()
        );
    }
}
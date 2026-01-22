package vn.dao;

import vn.model.Order;
import vn.model.OrderItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDao {

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port() + "/" +
                DBProperties.dbname() + "?" + DBProperties.option();
        return DriverManager.getConnection(url, DBProperties.username(), DBProperties.password());
    }

    // Lưu Order + OrderItem
    public int insertOrder(Order order, List<OrderItem> items) {
        int orderId = -1;
        String sqlOrder = "INSERT INTO orders (user_id, full_name, phone, address, shipping_method, payment_method, note, total_amount, status, created_at) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        String sqlItem = "INSERT INTO order_items (order_id, product_id, product_name, price, quantity) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement psOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getUserId());
                psOrder.setString(2, order.getFullName());
                psOrder.setString(3, order.getPhone());
                psOrder.setString(4, order.getAddress());
                psOrder.setString(5, order.getShippingMethod());
                psOrder.setString(6, order.getPaymentMethod());
                psOrder.setString(7, order.getNote());
                psOrder.setLong(8, order.getTotalAmount());
                psOrder.setString(9, order.getStatus());

                psOrder.executeUpdate();

                ResultSet rs = psOrder.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            // Insert OrderItems
            try (PreparedStatement psItem = conn.prepareStatement(sqlItem)) {
                for (OrderItem item : items) {
                    psItem.setInt(1, orderId);
                    psItem.setInt(2, item.getProductId());
                    psItem.setString(3, item.getProductName());
                    psItem.setLong(4, item.getPrice());
                    psItem.setInt(5, item.getQuantity());
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderId;
    }

    // Lấy danh sách order của user
    public List<Order> getListOrderByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setUserId(rs.getInt("user_id"));
                o.setFullName(rs.getString("full_name"));
                o.setPhone(rs.getString("phone"));
                o.setAddress(rs.getString("address"));
                o.setShippingMethod(rs.getString("shipping_method"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setNote(rs.getString("note"));
                o.setTotalAmount(rs.getLong("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setCreatedAt(rs.getString("created_at"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

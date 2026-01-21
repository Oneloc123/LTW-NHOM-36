package vn.dao;

import vn.model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port()
                + "/" + DBProperties.dbname() + "?" + DBProperties.option();
        return DriverManager.getConnection(url,
                DBProperties.username(),
                DBProperties.password());
    }

    // LẤY GIỎ HÀNG CHƯA CHECKOUT
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> list = new ArrayList<>();

        String sql = """
            SELECT c.product_id, p.name, p.image, c.price, c.quantity
            FROM cart c
            JOIN product p ON c.product_id = p.id
            WHERE c.user_id = ? AND c.status = 'ACTIVE'
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductId(rs.getInt("product_id"));
                item.setName(rs.getString("name"));
                item.setImage(rs.getString("image"));
                item.setPrice((int) rs.getDouble("price")); // FIX LỖI double → int
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // UPDATE SỐ LƯỢNG
    public void updateQuantity(int userId, int productId, int quantity) {
        String sql = """
            UPDATE cart
            SET quantity = ?
            WHERE user_id = ? AND product_id = ? AND status = 'ACTIVE'
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // REMOVE ITEM
    public void removeItem(int userId, int productId) {
        String sql = """
            DELETE FROM cart
            WHERE user_id = ? AND product_id = ? AND status = 'ACTIVE'
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // CHECKOUT – CHUẨN CÁCH 2
    public void checkout(int userId) {
        String sql = """
            UPDATE cart
            SET status = 'CHECKED_OUT'
            WHERE user_id = ? AND status = 'ACTIVE'
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

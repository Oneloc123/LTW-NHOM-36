package vn.dao;

import vn.model.CartItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDao {

    // ================== CONNECTION ==================
    private Connection getConnection() throws SQLException {
        String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port()
                + "/" + DBProperties.dbname() + "?" + DBProperties.option();

        return DriverManager.getConnection(
                url,
                DBProperties.username(),
                DBProperties.password()
        );
    }

    // ================== GET CART WITH ALL INFO ==================
    public List<CartItem> getCartByUserId(int userId) {
        List<CartItem> list = new ArrayList<>();

        String sql = """
            SELECT 
                c.product_id,
                p.name,
                p.image,
                c.price,
                c.quantity
            FROM cart c
            JOIN product p ON c.product_id = p.id
            WHERE c.user_id = ?
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
                item.setPrice(rs.getDouble("price"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ================== ADD TO CART (CHỈNH SỬA - CHỈ 2 THAM SỐ) ==================
    public void addToCart(int userId, int productId) {

        String checkSql = "SELECT quantity FROM cart WHERE user_id=? AND product_id=?";
        String updateSql = "UPDATE cart SET quantity = quantity + 1 WHERE user_id=? AND product_id=?";
        String insertSql = "INSERT INTO cart(user_id, product_id, quantity, price) VALUES (?, ?, 1, ?)";

        try (Connection conn = getConnection()) {

            // 1. CHECK
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setInt(1, userId);
            checkPs.setInt(2, productId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // 2. UPDATE
                PreparedStatement updatePs = conn.prepareStatement(updateSql);
                updatePs.setInt(1, userId);
                updatePs.setInt(2, productId);
                updatePs.executeUpdate();
            } else {
                // 3. GET PRICE
                double price = 0;
                PreparedStatement psPrice = conn.prepareStatement("SELECT price FROM product WHERE id=?");
                psPrice.setInt(1, productId);
                ResultSet rsPrice = psPrice.executeQuery();
                if (rsPrice.next()) {
                    price = rsPrice.getDouble("price");
                }

                // 4. INSERT
                PreparedStatement insertPs = conn.prepareStatement(insertSql);
                insertPs.setInt(1, userId);
                insertPs.setInt(2, productId);
                insertPs.setDouble(3, price);
                insertPs.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================== UPDATE QUANTITY ==================
    public void updateQuantity(int userId, int productId, int quantity) {

        String sql = """
            UPDATE cart
            SET quantity = ?
            WHERE user_id = ? AND product_id = ?
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

    // ================== REMOVE ITEM ==================
    public void removeItem(int userId, int productId) {

        String sql = "DELETE FROM cart WHERE user_id=? AND product_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================== CLEAR CART ==================
    public void clearCart(int userId) {

        String sql = "DELETE FROM cart WHERE user_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================== GET CART TOTAL ==================
    public double getCartTotal(int userId) {
        String sql = """
            SELECT SUM(c.price * c.quantity) as total
            FROM cart c
            WHERE c.user_id = ?
        """;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ================== GET CART COUNT ==================
    public int getCartItemCount(int userId) {
        String sql = "SELECT SUM(quantity) as count FROM cart WHERE user_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            System.out.println("DEBUG getCartItemCount - User ID: " + userId); // ADD THIS

            if (rs.next()) {
                int count = rs.getInt("count");
                System.out.println("DEBUG getCartItemCount - Result: " + count); // ADD THIS
                return count;
            } else {
                System.out.println("DEBUG getCartItemCount - No result"); // ADD THIS
                return 0;
            }

        } catch (Exception e) {
            System.err.println("ERROR getCartItemCount: " + e.getMessage()); // ADD THIS
            e.printStackTrace();
            return 0;
        }
    }

    // ================== CHECK IF PRODUCT IN CART ==================
    public boolean isProductInCart(int userId, int productId) {
        String sql = "SELECT 1 FROM cart WHERE user_id=? AND product_id=? LIMIT 1";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ================== GET ITEM QUANTITY ==================
    public int getItemQuantity(int userId, int productId) {
        String sql = "SELECT quantity FROM cart WHERE user_id=? AND product_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("quantity");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ================== GET ITEM TOTAL ==================
    public double getItemTotal(int userId, int productId) {
        String sql = "SELECT price * quantity as total FROM cart WHERE user_id=? AND product_id=?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}
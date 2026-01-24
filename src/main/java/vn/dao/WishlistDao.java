package vn.dao;

import vn.model.Wishlist;
import vn.model.Product;
import java.util.List;
import java.util.Map;

public class WishlistDao extends BaseDao {

    // Thêm sản phẩm vào wishlist
    public boolean addToWishlist(int userId, int productId) {
        try {
            get().useHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO wishlist (user_id, product_id, added_date) " +
                                            "VALUES (:userId, :productId, NOW())"
                            )
                            .bind("userId", userId)
                            .bind("productId", productId)
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa sản phẩm khỏi wishlist
    public boolean removeFromWishlist(int userId, int productId) {
        return get().withHandle(h ->
                h.createUpdate(
                                "DELETE FROM wishlist " +
                                        "WHERE user_id = :userId AND product_id = :productId"
                        )
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .execute() > 0
        );
    }

    // Kiểm tra xem sản phẩm đã có trong wishlist chưa
    public boolean isProductInWishlist(int userId, int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM wishlist " +
                                        "WHERE user_id = :userId AND product_id = :productId"
                        )
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    // Lấy tất cả sản phẩm trong wishlist của user
    public List<Product> getWishlistProducts(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT p.* FROM products p " +
                                        "INNER JOIN wishlist w ON p.id = w.product_id " +
                                        "WHERE w.user_id = :userId " +
                                        "ORDER BY w.added_date DESC"
                        )
                        .bind("userId", userId)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    // Lấy thông tin wishlist (bao gồm cả ngày thêm)
    public List<Map<String, Object>> getWishlistWithDetails(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT w.id as wishlist_id, w.added_date, " +
                                        "p.id as product_id, p.name, p.price, p.short_description, " +
                                        "p.category_id, p.is_featured " +
                                        "FROM wishlist w " +
                                        "INNER JOIN products p ON w.product_id = p.id " +
                                        "WHERE w.user_id = :userId " +
                                        "ORDER BY w.added_date DESC"
                        )
                        .bind("userId", userId)
                        .mapToMap()
                        .list()
        );
    }

    // Lấy số lượng sản phẩm trong wishlist
    public int getWishlistCount(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM wishlist " +
                                        "WHERE user_id = :userId"
                        )
                        .bind("userId", userId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // Xóa tất cả sản phẩm khỏi wishlist
    public boolean clearWishlist(int userId) {
        return get().withHandle(h ->
                h.createUpdate(
                                "DELETE FROM wishlist " +
                                        "WHERE user_id = :userId"
                        )
                        .bind("userId", userId)
                        .execute() > 0
        );
    }

    // Lấy wishlist item theo ID
    public Wishlist getWishlistItemById(int wishlistId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id, product_id, added_date " +
                                        "FROM wishlist WHERE id = :id"
                        )
                        .bind("id", wishlistId)
                        .mapToBean(Wishlist.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // Lấy tất cả wishlist items của user
    public List<Wishlist> getUserWishlistItems(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id, product_id, added_date " +
                                        "FROM wishlist WHERE user_id = :userId"
                        )
                        .bind("userId", userId)
                        .mapToBean(Wishlist.class)
                        .list()
        );
    }

    // Lấy danh sách sản phẩm trong wishlist với phân trang
    public List<Product> getWishlistProductsPaginated(int userId, int page, int pageSize) {
        int offset = (page - 1) * pageSize;

        return get().withHandle(h ->
                h.createQuery(
                                "SELECT p.* FROM products p " +
                                        "INNER JOIN wishlist w ON p.id = w.product_id " +
                                        "WHERE w.user_id = :userId " +
                                        "ORDER BY w.added_date DESC " +
                                        "LIMIT :limit OFFSET :offset"
                        )
                        .bind("userId", userId)
                        .bind("limit", pageSize)
                        .bind("offset", offset)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    // Kiểm tra xem user có wishlist không
    public boolean hasWishlist(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM wishlist " +
                                        "WHERE user_id = :userId"
                        )
                        .bind("userId", userId)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    // Lấy danh sách sản phẩm gợi ý dựa trên wishlist
    public List<Product> getRecommendedProducts(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT DISTINCT p.* FROM products p " +
                                        "WHERE p.category_id IN (" +
                                        "    SELECT DISTINCT p2.category_id FROM products p2 " +
                                        "    INNER JOIN wishlist w ON p2.id = w.product_id " +
                                        "    WHERE w.user_id = :userId" +
                                        ") " +
                                        "AND p.id NOT IN (" +
                                        "    SELECT product_id FROM wishlist " +
                                        "    WHERE user_id = :userId" +
                                        ") " +
                                        "LIMIT 6"
                        )
                        .bind("userId", userId)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    // Thêm nhiều sản phẩm vào wishlist cùng lúc
    public boolean addMultipleToWishlist(int userId, List<Integer> productIds) {
        try {
            get().useHandle(h -> {
                for (Integer productId : productIds) {
                    h.createUpdate(
                                    "INSERT INTO wishlist (user_id, product_id, added_date) " +
                                            "VALUES (:userId, :productId, NOW())"
                            )
                            .bind("userId", userId)
                            .bind("productId", productId)
                            .execute();
                }
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy wishlist của nhiều users (cho admin)
    public List<Map<String, Object>> getAllWishlists() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT w.id, u.username, u.email, p.name as product_name, " +
                                        "p.price, w.added_date " +
                                        "FROM wishlist w " +
                                        "INNER JOIN users u ON w.user_id = u.id " +
                                        "INNER JOIN products p ON w.product_id = p.id " +
                                        "ORDER BY w.added_date DESC"
                        )
                        .mapToMap()
                        .list()
        );
    }

    // Lấy wishlist theo khoảng thời gian
    public List<Wishlist> getWishlistByDateRange(int userId, String startDate, String endDate) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id, product_id, added_date " +
                                        "FROM wishlist " +
                                        "WHERE user_id = :userId " +
                                        "AND DATE(added_date) BETWEEN :startDate AND :endDate " +
                                        "ORDER BY added_date DESC"
                        )
                        .bind("userId", userId)
                        .bind("startDate", startDate)
                        .bind("endDate", endDate)
                        .mapToBean(Wishlist.class)
                        .list()
        );
    }

    // Xóa wishlist item theo ID
    public boolean removeWishlistItemById(int wishlistId) {
        return get().withHandle(h ->
                h.createUpdate(
                                "DELETE FROM wishlist WHERE id = :id"
                        )
                        .bind("id", wishlistId)
                        .execute() > 0
        );
    }

    // Lấy tổng giá trị wishlist
    public int getWishlistTotalValue(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COALESCE(SUM(p.price), 0) " +
                                        "FROM wishlist w " +
                                        "INNER JOIN products p ON w.product_id = p.id " +
                                        "WHERE w.user_id = :userId"
                        )
                        .bind("userId", userId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // Kiểm tra và thêm vào wishlist (tránh trùng lặp)
    public boolean addToWishlistIfNotExists(int userId, int productId) {
        // Kiểm tra xem đã có chưa
        boolean exists = isProductInWishlist(userId, productId);

        if (!exists) {
            return addToWishlist(userId, productId);
        }
        return false; // Đã tồn tại
    }
}
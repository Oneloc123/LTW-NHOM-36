package vn.services;

import vn.dao.WishlistDao;
import vn.dao.ImageDao;
import vn.model.Product;
import java.util.List;
import java.util.Map;

public class WishlistService {
    private WishlistDao wishlistDao = new WishlistDao();
    private ImageDao imageDao = new ImageDao();

    // Thêm vào wishlist
    public boolean addToWishlist(int userId, int productId) {
        return wishlistDao.addToWishlist(userId, productId);
    }

    // Thêm vào wishlist nếu chưa tồn tại
    public boolean addToWishlistIfNotExists(int userId, int productId) {
        return wishlistDao.addToWishlistIfNotExists(userId, productId);
    }

    // Xóa khỏi wishlist
    public boolean removeFromWishlist(int userId, int productId) {
        return wishlistDao.removeFromWishlist(userId, productId);
    }

    // Kiểm tra có trong wishlist không
    public boolean isInWishlist(int userId, int productId) {
        return wishlistDao.isProductInWishlist(userId, productId);
    }

    // Lấy danh sách sản phẩm trong wishlist với hình ảnh
    public List<Product> getWishlistProducts(int userId) {
        List<Product> products = wishlistDao.getWishlistProducts(userId);


        return products;
    }

    // Lấy wishlist với chi tiết
    public List<Map<String, Object>> getWishlistWithDetails(int userId) {
        return wishlistDao.getWishlistWithDetails(userId);
    }

    // Lấy số lượng sản phẩm trong wishlist
    public int getWishlistCount(int userId) {
        return wishlistDao.getWishlistCount(userId);
    }

    // Xóa tất cả khỏi wishlist
    public boolean clearWishlist(int userId) {
        return wishlistDao.clearWishlist(userId);
    }

    // Lấy wishlist có phân trang
    public List<Product> getWishlistProductsPaginated(int userId, int page, int pageSize) {
        List<Product> products = wishlistDao.getWishlistProductsPaginated(userId, page, pageSize);


        return products;
    }

    // Lấy sản phẩm gợi ý dựa trên wishlist
    public List<Product> getRecommendedProducts(int userId) {
        List<Product> products = wishlistDao.getRecommendedProducts(userId);


        return products;
    }

    // Lấy tổng giá trị wishlist
    public int getWishlistTotalValue(int userId) {
        return wishlistDao.getWishlistTotalValue(userId);
    }

    // Lấy tất cả wishlists (admin)
    public List<Map<String, Object>> getAllWishlists() {
        return wishlistDao.getAllWishlists();
    }
}
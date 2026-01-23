package vn.services;

import vn.dao.CartDao;
import vn.model.CartItem;

import java.util.List;

public class CartService {

    private CartDao cartDao = new CartDao();

    // ================== LẤY GIỎ HÀNG ==================
    public List<CartItem> getCartByUserId(int userId) {
        return cartDao.getCartByUserId(userId);
    }

    // ================== THÊM VÀO GIỎ ==================
    public void addToCart(int userId, int productId, int quantity) {
        for (int i = 0; i < quantity; i++) {
            cartDao.addToCart(userId, productId);
        }
    }

    // ================== CẬP NHẬT SỐ LƯỢNG ==================
    public void updateQuantity(int userId, int productId, int quantity) {
        cartDao.updateQuantity(userId, productId, quantity);
    }

    // ================== XOÁ 1 SẢN PHẨM ==================
    public void removeItem(int userId, int productId) {
        cartDao.removeItem(userId, productId);
    }

    // ================== XOÁ TOÀN BỘ GIỎ ==================
    public void clearCart(int userId) {
        cartDao.clearCart(userId);
    }

    // ================== TÍNH TỔNG TIỀN ==================
    public double getTotalPrice(int userId) {
        List<CartItem> items = cartDao.getCartByUserId(userId);
        double total = 0;
        for (CartItem item : items) {
            total += item.getTotal();
        }
        return total;
    }

    // ================== TÍNH TỔNG SỐ LƯỢNG ==================
    public int getTotalQuantity(int userId) {
        List<CartItem> items = cartDao.getCartByUserId(userId);
        int total = 0;
        for (CartItem item : items) {
            total += item.getQuantity();
        }
        return total;
    }
}

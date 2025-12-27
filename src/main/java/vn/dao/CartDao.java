package vn.dao;

import vn.model.CartItem;

import java.util.ArrayList;
import java.util.List;

public class CartDao {

    // Giỏ hàng demo (fake data)
    private static final List<CartItem> cart = new ArrayList<>();

    static {
        cart.add(new CartItem(
                1,
                "4URPC sạc không dây",
                "/assets/img/Cart/4urpc.png",
                999000,
                2
        ));

        cart.add(new CartItem(
                2,
                "ChargeStick",
                "/assets/img/Cart/ChargeStick.png",
                1290000,
                1
        ));
    }

    // Lấy danh sách giỏ hàng
    public List<CartItem> getCart() {
        return cart;
    }

    // Xóa sản phẩm khỏi giỏ
    public void remove(int productId) {
        cart.removeIf(item -> item.getProductId() == productId);
    }

    // Tính tổng tiền
    public int getTotal() {
        int total = 0;
        for (CartItem item : cart) {
            total += item.getTotal();
        }
        return total;
    }
}

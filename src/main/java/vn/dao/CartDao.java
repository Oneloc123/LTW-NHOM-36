package vn.dao;

import vn.model.CartItem;

import java.util.ArrayList;
import java.util.List;

public class CartDao {

    private static final List<CartItem> cart = new ArrayList<>();

    static {
        cart.add(new CartItem(1, "Camera Canon R10", 500000, 2));
        cart.add(new CartItem(2, "Lens Sigma 35mm", 300000, 2));
    }

    public List<CartItem> getCart() {
        return cart;
    }

    public void remove(int productId) {
        cart.removeIf(p -> p.getProductId() == productId);
    }
}

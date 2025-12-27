package vn.services;

import vn.model.CartItem;
import java.util.ArrayList;
import java.util.List;

public class CartService {

    public List<CartItem> getDemoCart() {
        List<CartItem> cart = new ArrayList<>();

        cart.add(new CartItem(
                1,
                "4URPC sạc không dây",
                "../assets/img/Cart/4urpc.png",
                999000,
                1
        ));

        cart.add(new CartItem(
                2,
                "ChargeStick",
                "../assets/img/Cart/ChargeStick.png",
                1290000,
                1
        ));

        return cart;
    }

    public int getTotalPrice(List<CartItem> cart) {
        int total = 0;
        for (CartItem c : cart) {
            total += c.getTotal();
        }
        return total;
    }
}

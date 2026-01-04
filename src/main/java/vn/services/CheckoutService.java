package vn.services;

import jakarta.servlet.http.HttpSession;
import vn.model.CartItem;

import java.util.List;

public class CheckoutService {

    public double calculateTotal(HttpSession session) {
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null) return 0;

        double total = 0;
        for (CartItem item : cart) {
            total += item.getTotal();
        }
        return total;
    }

    public boolean checkoutDemo(HttpSession session) {
        // Demo thanh toán thành công
        return true;
    }
}

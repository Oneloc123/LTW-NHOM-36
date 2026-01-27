package vn.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;
import vn.model.Product;
import vn.services.ProductService;

import java.io.IOException;

@WebServlet(name = "UpdateCartServlet", value = "/cart-update")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart != null && quantity > 0) {
                // Cần implement phương thức update trong Cart.java
                // Tạm thời xóa rồi thêm lại với số lượng mới
                cart.delItem(productId);
                ProductService ps = new ProductService();
                Product product = ps.getProductById(productId);
                if (product != null) {
                    cart.addItem(product, quantity);
                }
            }

            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
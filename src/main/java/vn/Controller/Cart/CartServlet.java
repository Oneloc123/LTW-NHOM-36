package vn.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;
import vn.cart.CartItem;
import vn.services.ImageService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Debug: kiểm tra cart có tồn tại không
        System.out.println("Cart in session: " + (cart != null));

        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        List<CartItem> cartItems = cart.getItems();

        // Debug: kiểm tra số lượng items
        System.out.println("Number of items in cart: " + cartItems.size());

        // Lấy thông tin ảnh cho từng sản phẩm
        ImageService imageService = new ImageService();

        for (CartItem item : cartItems) {
            if (item.getProduct() != null) {
                String firstImage = imageService.getFirstImageUrl(item.getProduct().getId());
                if (firstImage != null) {
                    // Đặt vào request attribute để JSP có thể truy cập
                    request.setAttribute("image_" + item.getProduct().getId(), firstImage);
                }
                // Debug: in thông tin sản phẩm
                System.out.println("Product in cart: " + item.getProduct().getName() +
                        ", Quantity: " + item.getQuantity() +
                        ", Price: " + item.getPrice());
            }
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", cart.getTotal());
        request.setAttribute("totalQuantity", cart.getTotalQuantity());

        request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
    }
}
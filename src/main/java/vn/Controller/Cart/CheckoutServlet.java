package vn.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;
import vn.cart.CartItem;
import vn.model.Order;
import vn.services.ImageService;
import vn.services.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutServlet", value = "/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        // Kiểm tra đăng nhập
        Integer userId = (Integer) session.getAttribute("id");
        if (userId == null) {
            // Lưu URL hiện tại để redirect lại sau khi đăng nhập
            session.setAttribute("redirectAfterLogin", "/checkout");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Kiểm tra giỏ hàng có sản phẩm không
        if (cart == null || cart.getItems().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        List<CartItem> cartItems = cart.getItems();

        // Lấy thông tin ảnh cho sản phẩm
        ImageService imageService = new ImageService();
        for (CartItem item : cartItems) {
            if (item.getProduct() != null) {
                String firstImage = imageService.getFirstImageUrl(item.getProduct().getId());
                if (firstImage != null) {
                    request.setAttribute("image_" + item.getProduct().getId(), firstImage);
                }
            }
        }

        // Lấy thông tin người dùng từ session hoặc database
        String userEmail = (String) session.getAttribute("userEmail");
        String userName = (String) session.getAttribute("userName");
        String userPhone = (String) session.getAttribute("userPhone");

        // Đặt thông tin mặc định cho form
        request.setAttribute("defaultName", userName != null ? userName : "");
        request.setAttribute("defaultEmail", userEmail != null ? userEmail : "");
        request.setAttribute("defaultPhone", userPhone != null ? userPhone : "");

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", cart.getTotal());
        request.setAttribute("totalQuantity", cart.getTotalQuantity());

        request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý khi form thanh toán được submit
        doGet(request, response);
    }
}
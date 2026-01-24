package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.services.WishlistService;
import vn.services.ProductService;
import vn.model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistController extends HttpServlet {

    private WishlistService wishlistService = new WishlistService();
    private ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");

        // Kiểm tra đăng nhập
        if (userId == null) {
            // Lưu URL hiện tại để redirect sau khi đăng nhập
            String redirectUrl = request.getRequestURI();
            session.setAttribute("redirectAfterLogin", redirectUrl);

            session.setAttribute("message", "Vui lòng đăng nhập để xem wishlist!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy danh sách sản phẩm trong wishlist
        List<Product> wishlistProducts = wishlistService.getWishlistProducts(userId);
        int wishlistCount = wishlistService.getWishlistCount(userId);

        // Set attributes
        request.setAttribute("wishlistProducts", wishlistProducts);
        request.setAttribute("wishlistCount", wishlistCount);
        request.setAttribute("currentPage", "wishlist");

        request.getRequestDispatcher("/pages/wishlist.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");
        String action = request.getParameter("action");

        // Kiểm tra đăng nhập
        if (userId == null) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Vui lòng đăng nhập!\"}");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            if ("add".equals(action)) {
                boolean success = wishlistService.addToWishlist(userId, productId);
                if (success) {
                    response.getWriter().write("{\"status\":\"success\",\"message\":\"Đã thêm vào wishlist!\"}");
                } else {
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"Sản phẩm đã có trong wishlist!\"}");
                }
            }
            else if ("remove".equals(action)) {
                boolean success = wishlistService.removeFromWishlist(userId, productId);
                if (success) {
                    response.getWriter().write("{\"status\":\"success\",\"message\":\"Đã xóa khỏi wishlist!\"}");
                } else {
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"Xóa thất bại!\"}");
                }
            }
            else if ("clear".equals(action)) {
                boolean success = wishlistService.clearWishlist(userId);
                if (success) {
                    response.getWriter().write("{\"status\":\"success\",\"message\":\"Đã xóa tất cả khỏi wishlist!\"}");
                } else {
                    response.getWriter().write("{\"status\":\"error\",\"message\":\"Xóa thất bại!\"}");
                }
            }

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\",\"message\":\"ID sản phẩm không hợp lệ!\"}");
        }
    }
}
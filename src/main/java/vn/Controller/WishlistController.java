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
            session.setAttribute("redirectAfterLogin", "/wishlist");
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
            session.setAttribute("error", "Vui lòng đăng nhập để thực hiện thao tác này!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            if ("remove".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                boolean success = wishlistService.removeFromWishlist(userId, productId);

                if (success) {
                    session.setAttribute("message", "Đã xóa sản phẩm khỏi wishlist!");
                } else {
                    session.setAttribute("error", "Xóa sản phẩm thất bại!");
                }
            }
            else if ("clear".equals(action)) {
                boolean success = wishlistService.clearWishlist(userId);

                if (success) {
                    session.setAttribute("message", "Đã xóa tất cả sản phẩm khỏi wishlist!");
                } else {
                    session.setAttribute("error", "Xóa wishlist thất bại!");
                }
            }
            else if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                boolean success = wishlistService.addToWishlist(userId, productId);

                if (success) {
                    session.setAttribute("message", "Đã thêm vào wishlist!");
                } else {
                    session.setAttribute("error", "Sản phẩm đã có trong wishlist!");
                }

                // Quay lại trang trước
                String referer = request.getHeader("Referer");
                response.sendRedirect(referer != null ? referer : request.getContextPath() + "/products");
                return;
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID sản phẩm không hợp lệ!");
        } catch (Exception e) {
            session.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
        }

        // Sau khi xử lý POST, redirect về trang wishlist
        response.sendRedirect(request.getContextPath() + "/wishlist");
    }
}
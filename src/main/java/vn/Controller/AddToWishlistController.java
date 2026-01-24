package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.services.WishlistService;

import java.io.IOException;

@WebServlet("/add-to-wishlist")
public class AddToWishlistController extends HttpServlet {

    private WishlistService wishlistService = new WishlistService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("id");

        // Kiểm tra đăng nhập
        if (userId == null) {
            session.setAttribute("redirectAfterLogin", request.getHeader("Referer"));
            session.setAttribute("message", "Vui lòng đăng nhập để thêm vào wishlist!");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("id"));

            // Thêm vào wishlist
            boolean success = wishlistService.addToWishlist(userId, productId);

            if (success) {
                session.setAttribute("message", "Đã thêm vào danh sách yêu thích!");
            } else {
                session.setAttribute("error", "Sản phẩm đã có trong wishlist!");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID sản phẩm không hợp lệ!");
        }

        // Quay lại trang trước đó
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/products");
    }
}
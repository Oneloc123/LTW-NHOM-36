package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.dao.CartDao;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "AddToCartServlet", value = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private CartDao cartDao;

    @Override
    public void init() throws ServletException {
        cartDao = new CartDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            out.print("{\"success\": false, \"message\": \"Vui lòng đăng nhập\"}");
            out.flush();
            return;
        }

        try {
            int userId = (int) session.getAttribute("id");
            int productId = Integer.parseInt(request.getParameter("productId"));

            // THÊM VÀO GIỎ HÀNG - KHÔNG CẦN BIẾN SUCCESS
            cartDao.addToCart(userId, productId);

            // Tính toán lại giỏ hàng
            int cartCount = cartDao.getCartItemCount(userId);
            double cartTotal = cartDao.getCartTotal(userId);

            // Cập nhật session
            session.setAttribute("cartCount", cartCount);

            out.print("{\"success\": true, \"message\": \"Đã thêm vào giỏ hàng\", " +
                    "\"cartCount\": " + cartCount + ", " +
                    "\"cartTotal\": " + cartTotal + "}");

        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Dữ liệu không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra\"}");
        }

        out.flush();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }
}
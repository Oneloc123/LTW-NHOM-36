package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.dao.CartDao;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CartUpdateServlet", value = "/cart-update")
public class CartUpdateServlet extends HttpServlet {
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
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            // Kiểm tra số lượng hợp lệ
            if (quantity <= 0) {
                // Nếu quantity <= 0, xóa sản phẩm
                cartDao.removeItem(userId, productId);
                int cartCount = cartDao.getCartItemCount(userId);
                session.setAttribute("cartCount", cartCount);
                out.print("{\"success\": true, \"message\": \"Đã xóa sản phẩm\", " +
                        "\"cartCount\": " + cartCount + "}");
            } else {
                // Cập nhật số lượng - KHÔNG TRẢ VỀ GIÁ TRỊ
                cartDao.updateQuantity(userId, productId, quantity);

                int cartCount = cartDao.getCartItemCount(userId);
                double itemTotal = cartDao.getItemTotal(userId, productId);
                double cartTotal = cartDao.getCartTotal(userId);

                // Update session
                session.setAttribute("cartCount", cartCount);

                out.print("{\"success\": true, \"message\": \"Đã cập nhật\", " +
                        "\"cartCount\": " + cartCount + ", " +
                        "\"itemTotal\": " + itemTotal + ", " +
                        "\"cartTotal\": " + cartTotal + "}");
            }

        } catch (NumberFormatException e) {
            out.print("{\"success\": false, \"message\": \"Dữ liệu không hợp lệ\"}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Có lỗi xảy ra\"}");
        }

        out.flush();
    }
}
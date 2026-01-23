package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.dao.CartDao;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "CartRemoveServlet", value = "/cart-remove")
public class CartRemoveServlet extends HttpServlet {
    private CartDao cartDao;

    @Override
    public void init() throws ServletException {
        cartDao = new CartDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int userId = (int) session.getAttribute("id");
            int productId = Integer.parseInt(request.getParameter("productId"));

            // Xóa sản phẩm khỏi giỏ hàng - KHÔNG TRẢ VỀ GIÁ TRỊ
            cartDao.removeItem(userId, productId);

            // Cập nhật số lượng giỏ hàng trong session
            int cartCount = cartDao.getCartItemCount(userId);
            session.setAttribute("cartCount", cartCount);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect về trang giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
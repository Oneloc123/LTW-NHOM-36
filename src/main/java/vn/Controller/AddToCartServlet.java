package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.dao.CartDao;

import java.io.IOException;

@WebServlet(name = "add-to-cart", value = "/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String referer = request.getHeader("Referer");
        session.setAttribute("redirectAfterLogin", referer);

        // CHƯA ĐĂNG NHẬP → ĐÁ LOGIN
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("id");
        int productId = Integer.parseInt(request.getParameter("productId"));

        CartDao cartDao = new CartDao();
        cartDao.addToCart(userId, productId);

      // QUAY LẠI TRANG TRƯỚC
      response.sendRedirect(request.getHeader("Referer"));
    }
}

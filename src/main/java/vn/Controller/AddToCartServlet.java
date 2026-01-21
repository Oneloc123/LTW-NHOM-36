package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.dao.CartDao;

import java.io.IOException;
@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {

    private CartDao cartDao = new CartDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (int) session.getAttribute("id");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        for (int i = 0; i < quantity; i++) {
            cartDao.addToCart(userId, productId);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}

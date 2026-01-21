package vn.Controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.dao.CartDao;
import java.io.IOException;

@WebServlet("/cart-update")
public class CartUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        int productId = Integer.parseInt(req.getParameter("productId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        new CartDao().updateQuantity(userId, productId, quantity);
        resp.sendRedirect("cart");
    }
}

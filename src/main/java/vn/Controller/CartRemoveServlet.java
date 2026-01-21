package vn.Controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.dao.CartDao;

import java.io.IOException;
@WebServlet("/cart-remove")
public class CartRemoveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int userId = (int) req.getSession().getAttribute("userId");
        int productId = Integer.parseInt(req.getParameter("productId"));

        new CartDao().removeItem(userId, productId);
        resp.sendRedirect("cart");
    }
}


package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.dao.CartDao;

import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("id");

        request.setAttribute("cartItems", cartDao.getCartItems(userId));
        request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
    }
}

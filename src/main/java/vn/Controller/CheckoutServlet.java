package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.dao.CartDao;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao cartDao = new CartDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect("login");
            return;
        }

        int userId = (int) session.getAttribute("id");

        // CHUẨN: KHÔNG XOÁ – CHỈ ĐỔI STATUS
        cartDao.checkout(userId);

        response.sendRedirect("order-history");
    }
}

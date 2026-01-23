package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.dao.CartDao;
import vn.model.CartItem;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("id");

        // 👉 LẤY GIỎ HÀNG TỪ DB
        List<CartItem> cartItems = cartDao.getCartByUserId(userId);

        // 👉 GỬI SANG JSP
        request.setAttribute("cartItems", cartItems);

        request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
    }
}


package vn.Controller;


import vn.model.CartItem;
import vn.model.Order;
import vn.model.OrderItem;
import vn.services.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.dao.CartDao;

import java.io.IOException;
import java.util.ArrayList;

import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {


    private final OrderService orderService = new OrderService();

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

        // Redirect thành công
        response.sendRedirect("order-success.jsp?orderId=" + orderId);

    }
}

package vn.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Order;
import vn.services.OrderService;

import java.io.IOException;

@WebServlet(name = "CheckoutSuccessServlet", value = "/checkout-success")
public class CheckoutSuccessServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam);

            // Lấy thông tin đơn hàng
            Order order = orderService.getOrderDetail(orderId, userId);

            if (order == null) {
                // Đơn hàng không tồn tại hoặc không thuộc về user này
                response.sendRedirect(request.getContextPath() + "/account/orders");
                return;
            }

            request.setAttribute("order", order);
            request.setAttribute("orderId", orderId);
            request.setAttribute("orderDate", order.getOrderDate());
            request.setAttribute("total", order.getTotalAmount());

            request.getRequestDispatcher("/pages/checkout-success.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
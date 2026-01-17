package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Order;
import vn.services.OrderService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryServlet", value = "/orders")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Chưa đăng nhập
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Lấy userId trực tiếp từ session
        int userId = (int) session.getAttribute("id");

        // Lấy danh sách đơn hàng
        OrderService orderService = new OrderService();
        List<Order> list = orderService.getListOrderByUserId(userId);

        // Truyền dữ liệu sang JSP
        request.setAttribute("list", list);
        request.setAttribute("currentPage", "orders");

        request.getRequestDispatcher("/pages/order-history.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // chưa dùng
    }
}

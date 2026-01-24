package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.model.Order;
import vn.model.User;
import vn.services.OrderService;
import vn.services.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet({
        "/user/orders",
        "/user/order-detail",
        "/user/cancel-order"
})
public class OrderServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = Integer.parseInt(session.getAttribute("id").toString());
        User user = userService.getUserById(userId);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getServletPath();

        try {
            switch (action) {
                case "/user/orders":
                    listUserOrders(request, response, user);
                    break;

                case "/user/order-detail":
                    viewOrderDetail(request, response, user);
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = Integer.parseInt(session.getAttribute("id").toString());
        User user = userService.getUserById(userId);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getServletPath();

        try {
            switch (action) {
                case "/user/cancel-order":
                    cancelOrder(request, response, user);
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    // ================== METHODS ==================

    // Danh sách đơn hàng của user
    private void listUserOrders(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        List<Order> orders = orderService.getUserOrders(user.getId());
        int totalOrders = orderService.countUserOrders(user.getId());

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", totalOrders);
        request.getRequestDispatcher("/pages/orders.jsp").forward(request, response);
    }

    // Chi tiết đơn hàng
    private void viewOrderDetail(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            Order order = orderService.getOrderDetail(orderId, user.getId());

            if (order == null) {
                request.setAttribute("error", "Không tìm thấy đơn hàng");
                listUserOrders(request, response, user);
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/pages/order-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã đơn hàng không hợp lệ");
            listUserOrders(request, response, user);
        }
    }

    // Hủy đơn hàng
    private void cancelOrder(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {

        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            boolean success = orderService.cancelOrder(orderId, user.getId());

            if (success) {
                request.setAttribute("message", "Đã hủy đơn hàng thành công");
            } else {
                request.setAttribute("error", "Không thể hủy đơn hàng (đơn không ở trạng thái chờ)");
            }

            listUserOrders(request, response, user);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã đơn hàng không hợp lệ");
            listUserOrders(request, response, user);
        }
    }
}

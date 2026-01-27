package vn.Controller.admin;

import vn.model.Order;
import vn.model.User;
import vn.services.OrderService;
import vn.services.UserService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private OrderService orderService;
    private UserService userService;

    @Override
    public void init() {
        orderService = new OrderService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("id") == null || session.getAttribute("role") == null) {
            resp.sendRedirect("../pages/login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if (action == null) {
            listOrders(req, resp);
            return;
        }

        switch (action) {
            case "view":
                viewOrder(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Order editOrder = orderService.getOrderDetail(id, 0); // 0 means admin access
                if (editOrder != null) {
                    User user = userService.getUserById(editOrder.getUserId());
                    req.setAttribute("user", user);
                }
                req.setAttribute("editOrder", editOrder);
                listOrders(req, resp);
                break;
            case "delete":
                deleteOrder(req, resp);
                break;
            default:
                listOrders(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            editOrder(req, resp);
        } else if ("updateStatus".equals(action)) {
            updateOrderStatus(req, resp);
        }
    }

    // ===== METHODS =====

    private void listOrders(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");
        String paymentStatus = req.getParameter("paymentStatus");
        String userId = req.getParameter("userId");

        List<Order> orders;

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasStatus = status != null && !status.isEmpty();
        boolean hasPaymentStatus = paymentStatus != null && !paymentStatus.isEmpty();
        boolean hasUserId = userId != null && !userId.isEmpty();

        if (hasKeyword || hasStatus || hasPaymentStatus || hasUserId) {
            // Tìm kiếm + lọc
            orders = orderService.searchOrders(keyword, status, paymentStatus, userId);
        } else {
            // Lấy tất cả
            orders = orderService.getAllOrders();
        }

        // Lấy thông tin user cho mỗi đơn hàng
        for (Order order : orders) {
            User user = userService.getUserById(order.getUserId());
            if (user != null) {
                order.setUserId(user.getId());
                // Có thể set thêm thông tin user vào request nếu cần
            }
        }

        req.setAttribute("orders", orders);
        req.setAttribute("orderStatuses", orderService.getOrderStatuses());
        req.setAttribute("paymentStatuses", new String[]{"unpaid", "paid", "refunded"});
        req.getRequestDispatcher("/admin/admin-orders.jsp").forward(req, resp);
    }

    private void viewOrder(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Order order = orderService.getOrderDetail(id, 0); // 0 for admin access

        if (order != null) {
            User user = userService.getUserById(order.getUserId());
            req.setAttribute("user", user);
            req.setAttribute("order", order);
        }

        req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);
    }

    private void editOrder(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            Order order = new Order();
            order.setId(Integer.parseInt(req.getParameter("id")));
            order.setUserId(Integer.parseInt(req.getParameter("userId")));
            order.setShippingAddress(req.getParameter("shippingAddress"));
            order.setPhoneNumber(req.getParameter("phoneNumber"));
            order.setEmail(req.getParameter("email"));
            order.setTotalAmount(Double.parseDouble(req.getParameter("totalAmount")));
            order.setStatus(req.getParameter("status"));
            order.setPaymentMethod(req.getParameter("paymentMethod"));
            order.setPaymentStatus(req.getParameter("paymentStatus"));
            order.setNotes(req.getParameter("notes"));

            // Update order (cần implement trong OrderService)
            orderService.updateOrder(order);

        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect("orders");
    }

    private void updateOrderStatus(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String status = req.getParameter("status");

        // Update order status (cần implement trong OrderService)
        orderService.updateOrderStatus(orderId, status);

        resp.sendRedirect("orders?action=view&id=" + orderId);
    }

    private void deleteOrder(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        // Delete order (cần implement trong OrderService)
        orderService.deleteOrder(id);
        resp.sendRedirect("orders");
    }
}
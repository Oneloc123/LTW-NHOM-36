package vn.Controller.admin;

import vn.model.Order;
import vn.model.Product;
import vn.model.User;
import vn.services.OrderService;
import vn.services.ProductService;
import vn.services.UserService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashBoard")
public class AdminDashBoardServlet extends HttpServlet {

    private OrderService orderService;
    private ProductService productService;
    private UserService userService;

    @Override
    public void init() {
        orderService = new OrderService();
        productService = new ProductService();
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

        // Lấy thống kê
        DashboardStats stats = getDashboardStats();

        // Lấy đơn hàng gần đây (5 đơn mới nhất)
        List<Order> recentOrders = getRecentOrders(5);

        // Lấy doanh thu theo tháng
        Map<String, Double> monthlyRevenue = getMonthlyRevenue();

        // Đưa dữ liệu vào request
        req.setAttribute("stats", stats);
        req.setAttribute("recentOrders", recentOrders);
        req.setAttribute("monthlyRevenue", monthlyRevenue);

        req.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }

    // ===== METHODS =====

    private DashboardStats getDashboardStats() {
        DashboardStats stats = new DashboardStats();

        // Tổng số sản phẩm
        List<Product> allProducts = productService.getAllProducts();
        stats.setTotalProducts(allProducts.size());

        // Tổng số người dùng
        List<User> allUsers = userService.getAllUsers();
        stats.setTotalUsers(allUsers.size());

        // Tổng số đơn hàng
        List<Order> allOrders = orderService.getAllOrders();
        stats.setTotalOrders(allOrders.size());

        // Doanh thu tháng hiện tại
        double monthlyRevenue = calculateMonthlyRevenue();
        stats.setMonthlyRevenue(monthlyRevenue);

        // Doanh thu tổng
        double totalRevenue = calculateTotalRevenue();
        stats.setTotalRevenue(totalRevenue);

        // Số đơn hàng trong tháng
        int monthlyOrders = getMonthlyOrdersCount();
        stats.setMonthlyOrders(monthlyOrders);

        // Số đơn hàng thành công
        int successfulOrders = getSuccessfulOrdersCount();
        stats.setSuccessfulOrders(successfulOrders);

        // Số đơn hàng đang xử lý
        int pendingOrders = getPendingOrdersCount();
        stats.setPendingOrders(pendingOrders);

        return stats;
    }

    private double calculateMonthlyRevenue() {
        try {
            // Lấy tháng hiện tại
            LocalDateTime now = LocalDateTime.now();
            int currentYear = now.getYear();
            int currentMonth = now.getMonthValue();

            // Tính doanh thu tháng hiện tại (đã giao và đã thanh toán)
            List<Order> allOrders = orderService.getAllOrders();
            double monthlyRevenue = 0.0;

            for (Order order : allOrders) {
                if (order.getStatus().equals("delivered") &&
                        order.getPaymentStatus().equals("paid")) {

                    Timestamp orderDate = order.getOrderDate();
                    LocalDateTime orderDateTime = orderDate.toInstant()
                            .atZone(ZoneId.systemDefault())
                            .toLocalDateTime();

                    if (orderDateTime.getYear() == currentYear &&
                            orderDateTime.getMonthValue() == currentMonth) {
                        monthlyRevenue += order.getTotalAmount();
                    }
                }
            }

            return monthlyRevenue;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    private double calculateTotalRevenue() {
        try {
            List<Order> allOrders = orderService.getAllOrders();
            double totalRevenue = 0.0;

            for (Order order : allOrders) {
                if (order.getStatus().equals("delivered") &&
                        order.getPaymentStatus().equals("paid")) {
                    totalRevenue += order.getTotalAmount();
                }
            }

            return totalRevenue;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    private int getMonthlyOrdersCount() {
        try {
            LocalDateTime now = LocalDateTime.now();
            int currentYear = now.getYear();
            int currentMonth = now.getMonthValue();

            List<Order> allOrders = orderService.getAllOrders();
            int count = 0;

            for (Order order : allOrders) {
                Timestamp orderDate = order.getOrderDate();
                LocalDateTime orderDateTime = orderDate.toInstant()
                        .atZone(ZoneId.systemDefault())
                        .toLocalDateTime();

                if (orderDateTime.getYear() == currentYear &&
                        orderDateTime.getMonthValue() == currentMonth) {
                    count++;
                }
            }

            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getSuccessfulOrdersCount() {
        try {
            List<Order> allOrders = orderService.getAllOrders();
            int count = 0;

            for (Order order : allOrders) {
                if (order.getStatus().equals("delivered")) {
                    count++;
                }
            }

            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private int getPendingOrdersCount() {
        try {
            List<Order> allOrders = orderService.getAllOrders();
            int count = 0;

            for (Order order : allOrders) {
                if (order.getStatus().equals("pending") ||
                        order.getStatus().equals("processing")) {
                    count++;
                }
            }

            return count;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    private List<Order> getRecentOrders(int limit) {
        try {
            List<Order> allOrders = orderService.getAllOrders();

            // Sắp xếp theo ngày đặt mới nhất
            allOrders.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));

            // Lấy số lượng giới hạn
            if (allOrders.size() > limit) {
                return allOrders.subList(0, limit);
            }

            return allOrders;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private Map<String, Double> getMonthlyRevenue() {
        // Đây là ví dụ, bạn cần implement logic thực tế
        // Có thể lấy doanh thu 12 tháng gần nhất

        // Tạm thời trả về null, sẽ implement sau
        return null;
    }

    // ===== INNER CLASS FOR STATS =====

    public static class DashboardStats {
        private int totalProducts;
        private int totalUsers;
        private int totalOrders;
        private int monthlyOrders;
        private double monthlyRevenue;
        private double totalRevenue;
        private int successfulOrders;
        private int pendingOrders;

        // Getters and Setters
        public int getTotalProducts() {
            return totalProducts;
        }

        public void setTotalProducts(int totalProducts) {
            this.totalProducts = totalProducts;
        }

        public int getTotalUsers() {
            return totalUsers;
        }

        public void setTotalUsers(int totalUsers) {
            this.totalUsers = totalUsers;
        }

        public int getTotalOrders() {
            return totalOrders;
        }

        public void setTotalOrders(int totalOrders) {
            this.totalOrders = totalOrders;
        }

        public int getMonthlyOrders() {
            return monthlyOrders;
        }

        public void setMonthlyOrders(int monthlyOrders) {
            this.monthlyOrders = monthlyOrders;
        }

        public double getMonthlyRevenue() {
            return monthlyRevenue;
        }

        public void setMonthlyRevenue(double monthlyRevenue) {
            this.monthlyRevenue = monthlyRevenue;
        }

        public double getTotalRevenue() {
            return totalRevenue;
        }

        public void setTotalRevenue(double totalRevenue) {
            this.totalRevenue = totalRevenue;
        }

        public int getSuccessfulOrders() {
            return successfulOrders;
        }

        public void setSuccessfulOrders(int successfulOrders) {
            this.successfulOrders = successfulOrders;
        }

        public int getPendingOrders() {
            return pendingOrders;
        }

        public void setPendingOrders(int pendingOrders) {
            this.pendingOrders = pendingOrders;
        }
    }
}
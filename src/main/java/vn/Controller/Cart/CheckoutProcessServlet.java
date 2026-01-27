package vn.Controller.Cart;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;
import vn.cart.CartItem;
import vn.model.Order;
import vn.services.OrderService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "CheckoutProcessServlet", value = "/checkout-process")
public class CheckoutProcessServlet extends HttpServlet {

    private OrderService orderService = new OrderService();
    private Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> result = new HashMap<>();

        try {
            HttpSession session = request.getSession();

            // Kiểm tra đăng nhập
            Integer userId = (Integer) session.getAttribute("userId");
            if (userId == null) {
                result.put("success", false);
                result.put("message", "Vui lòng đăng nhập để thanh toán");
                result.put("redirect", request.getContextPath() + "/login");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            Cart cart = (Cart) session.getAttribute("cart");

            if (cart == null || cart.getItems().isEmpty()) {
                result.put("success", false);
                result.put("message", "Giỏ hàng trống");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            // Lấy thông tin từ form
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String paymentMethod = request.getParameter("paymentMethod");
            String notes = request.getParameter("notes");

            // Validation cơ bản
            if (fullName == null || fullName.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "Vui lòng nhập họ và tên");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            if (phone == null || phone.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "Vui lòng nhập số điện thoại");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            if (address == null || address.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "Vui lòng nhập địa chỉ giao hàng");
                response.getWriter().write(gson.toJson(result));
                return;
            }

            // Tạo đối tượng Order
            Order order = new Order();
            order.setUserId(userId);
            order.setTotalAmount(cart.getTotal());
            order.setShippingAddress(address + ", " + district + ", " + city);
            order.setPhoneNumber(phone);
            order.setEmail(email != null ? email : "");
            order.setStatus("pending"); // Chờ xác nhận
            order.setPaymentMethod(paymentMethod != null ? paymentMethod : "cod");
            order.setPaymentStatus("unpaid"); // Chưa thanh toán
            order.setNotes(notes != null ? notes : "");

            // Lưu order và order details
            int orderId = orderService.createOrder(order, cart.getItems());

            if (orderId > 0) {
                // Xóa giỏ hàng sau khi đặt hàng thành công
                session.removeAttribute("cart");

                result.put("success", true);
                result.put("orderId", orderId);
                result.put("message", "Đặt hàng thành công!");
                result.put("redirect", request.getContextPath() + "/checkout-success?orderId=" + orderId);
            } else {
                result.put("success", false);
                result.put("message", "Có lỗi xảy ra khi tạo đơn hàng");
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "Lỗi hệ thống: " + e.getMessage());
        }

        PrintWriter out = response.getWriter();
        out.print(gson.toJson(result));
        out.flush();
    }
}
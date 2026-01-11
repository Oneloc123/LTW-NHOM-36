package vn.controller;

import vn.model.CartItem;
import vn.model.Order;
import vn.model.OrderItem;
import vn.services.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final OrderService orderService = new OrderService();

    // GET: hiển thị form checkout
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("/pages/cart.jsp"); // giỏ hàng trống
            return;
        }

        request.setAttribute("total", cart.stream().mapToInt(CartItem::getTotal).sum());
        request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
    }

    // POST: xử lý thanh toán
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("/pages/cart.jsp");
            return;
        }

        // Tạo Order
        Order order = new Order();
        order.setUserId((int) session.getAttribute("userId")); // giả sử lưu userId trong session
        order.setFullName(request.getParameter("fullName"));
        order.setPhone(request.getParameter("phone"));
        order.setAddress(request.getParameter("address"));
        order.setShippingMethod(request.getParameter("shippingMethod"));
        order.setPaymentMethod(request.getParameter("paymentMethod"));
        order.setNote(request.getParameter("note"));
        order.setTotalAmount(cart.stream().mapToLong(CartItem::getTotal).sum());
        order.setStatus("PENDING");

        // CartItem → OrderItem
        List<OrderItem> items = new ArrayList<>();
        for (CartItem c : cart) {
            OrderItem i = new OrderItem();
            i.setProductId(c.getProductId());
            i.setProductName(c.getName());
            i.setPrice(c.getPrice());
            i.setQuantity(c.getQuantity());
            items.add(i);
        }

        int orderId = orderService.placeOrder(order, items);

        // Xóa giỏ hàng
        session.removeAttribute("cart");

        // Redirect thành công
        response.sendRedirect("order-success.jsp?orderId=" + orderId);
    }
}

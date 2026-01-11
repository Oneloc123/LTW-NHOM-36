package vn.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.model.CartItem;
import vn.services.CheckoutService;

import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Nếu chưa đăng nhập → về login
        if (session == null || session.getAttribute("cart") == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Lấy cart từ session
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        CheckoutService service = new CheckoutService();
        double total = service.calculateTotal(session);

        // Đẩy dữ liệu sang JSP
        request.setAttribute("cart", cart);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/pages/checkout.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Lấy thông tin form
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        String note = request.getParameter("note");

        // DEMO: chưa insert DB
        CheckoutService service = new CheckoutService();
        boolean success = service.checkoutDemo(session);

        if (success) {
            // Clear cart sau khi thanh toán
            session.removeAttribute("cart");

            response.sendRedirect(
                    request.getContextPath() + "/pages/checkout-success.jsp"
            );
        } else {
            request.setAttribute("error", "Thanh toán thất bại, vui lòng thử lại");
            request.getRequestDispatcher("/pages/checkout.jsp")
                    .forward(request, response);
        }
    }
}

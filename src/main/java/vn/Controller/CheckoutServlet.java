package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDao cartDao = new CartDao();

    // ✅ FIX LỖI GET NOT SUPPORTED
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Hiển thị trang checkout
        request.getRequestDispatcher("/WEB-INF/pages/checkout.jsp")
                .forward(request, response);
    }

    // Xử lý khi nhấn nút "Thanh toán"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Clear cart sau khi thanh toán
        cartDao.clearCart(userId);

        request.setAttribute("message", "Thanh toán thành công!");

        request.getRequestDispatcher("/WEB-INF/pages/checkout-success.jsp")
                .forward(request, response);
    }
}

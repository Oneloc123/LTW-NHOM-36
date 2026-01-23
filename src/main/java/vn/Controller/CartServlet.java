package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.CartItem;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy giỏ hàng từ session
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        List<CartItem> cartItems = new ArrayList<>();
        double cartTotal = 0.0;
        int cartCount = 0;

        if (cart != null && !cart.isEmpty()) {
            cartItems = new ArrayList<>(cart.values());

            // Tính tổng
            for (CartItem item : cartItems) {
                cartTotal += item.getTotal();
                cartCount += item.getQuantity();
            }
        }

        // API endpoint cho mini cart (nếu cần)
        if ("mini".equals(request.getParameter("type"))) {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            if (cartItems.isEmpty()) {
                out.print("<p class='muted'>Giỏ hàng trống</p>");
            } else {
                out.print("<ul class='cart-items'>");
                for (CartItem item : cartItems) {
                    out.print("<li class='cart-item'>");
                    out.print("<img src='" + item.getImage() + "' alt='' width='80'>");
                    out.print("<div class='cart-info'>");
                    out.print("<strong>" + item.getName() + "</strong>");
                    out.print("<span class='muted'>" + item.getQuantity() + " x " +
                            String.format("%,.0f", item.getPrice()) + "₫</span>");
                    out.print("</div>");
                    out.print("<div class='cart-actions'>");
                    out.print("<a href='cart-remove?productId=" + item.getProductId() +
                            "' class='link-more'>Xóa</a>");
                    out.print("</div>");
                    out.print("</li>");
                }
                out.print("</ul>");
                out.print("<script>document.getElementById('cartTotal').textContent = '" +
                        String.format("%,.0f", cartTotal) + "₫';</script>");
            }

            // Update session count
            session.setAttribute("cartCount", cartCount);
            return;
        }

        // Set attributes cho JSP
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("cartCount", cartCount);

        request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý clear cart
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("clear".equals(request.getParameter("action"))) {
            // Xóa toàn bộ giỏ hàng
            session.removeAttribute("cart");
            session.setAttribute("cartCount", 0);
            session.setAttribute("cartTotal", 0.0);
            session.setAttribute("success", "Đã xóa toàn bộ giỏ hàng");
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
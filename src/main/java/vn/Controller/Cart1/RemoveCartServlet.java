package vn.Controller.Cart1;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;

import java.io.IOException;

@WebServlet(name = "RemoveCartServlet", value = "/cart-remove")
public class RemoveCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart != null) {
                cart.delItem(productId);
            }

            response.sendRedirect(request.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}
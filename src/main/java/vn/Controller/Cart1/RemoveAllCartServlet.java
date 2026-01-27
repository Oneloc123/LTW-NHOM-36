package vn.Controller.Cart1;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;

import java.io.IOException;

@WebServlet(name = "RemoveAllCartServlet", value = "/cart-remove-all")
public class RemoveAllCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            cart.delAll();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
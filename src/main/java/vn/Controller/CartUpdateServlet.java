package vn.Controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.dao.CartDao;
import java.io.IOException;

@WebServlet("/cart-update")
public class CartUpdateServlet extends HttpServlet {
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        int productId = Integer.parseInt(request.getParameter("productId"));
//        int quantity = Integer.parseInt(request.getParameter("quantity"));
//
//        HttpSession session = request.getSession();
//        Map<Integer, CartItem> cart =
//                CartService.getCart(session.getAttribute("cart"));
//
//        CartService.updateItem(cart, productId, quantity);
//        session.setAttribute("cart", cart);
//
//        response.sendRedirect(request.getContextPath() + "/cart");
//    }
}


package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.dao.ProductDao;
import vn.model.CartItem;
import vn.model.Product;
import vn.services.CartService;

import java.io.IOException;
import java.util.Map;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        int productId = Integer.parseInt(request.getParameter("productId"));
//
//        ProductDao productDao = new ProductDao();
//        Product product = productDao.findById(productId);
//
//        HttpSession session = request.getSession();
//        Map<Integer, CartItem> cart =
//                CartService.getCart(session.getAttribute("cart"));
//
//        CartService.addToCart(cart, product, 1);
//
//        session.setAttribute("cart", cart);
//
//        response.sendRedirect(request.getContextPath() + "/cart");
//    }
}

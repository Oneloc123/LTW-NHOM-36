package vn.Controller.Cart;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.cart.Cart;
import vn.model.Product;
import vn.services.ProductService;

import java.io.IOException;

@WebServlet(name = "AddCart", value = "/add-cart")
public class AddCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idRaw = request.getParameter("id");
            String qRaw  = request.getParameter("q");

            if (idRaw == null || idRaw.isBlank() ||
                    qRaw == null || qRaw.isBlank()) {

                System.out.println("❌ Missing id or quantity");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }

            int id = Integer.parseInt(idRaw);
            int quantity = Integer.parseInt(qRaw);

            ProductService ps = new ProductService();
            Product product = ps.getProductById(id);


            String referer = request.getHeader("Referer");


            if(product == null){
                response.sendRedirect(referer);
                return;
            }

            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");

            System.out.println("Cart in session before: " + (cart != null));
            if(cart == null){
                cart = new Cart();
                System.out.println("Created new cart");
            } else {
                System.out.println("Using existing cart");
                System.out.println("Items in cart before add: " + cart.getItems().size());
            }

            // THÊM SẢN PHẨM VÀO CART
            System.out.println("Adding product to cart...");
            cart.addItem(product, quantity);

            // LƯU CART VÀO SESSION
            session.setAttribute("cart", cart);

            // KIỂM TRA KẾT QUẢ
            System.out.println("Items in cart after add: " + cart.getItems().size());
            System.out.println("Total quantity in cart: " + cart.getTotalQuantity());

            System.out.println("=== ADD CART END ===");

            response.sendRedirect(referer);
        } catch (NumberFormatException e) {
            System.out.println("ERROR: Invalid number format");
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            System.out.println("ERROR: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_OK);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
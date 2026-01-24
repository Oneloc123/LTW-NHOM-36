package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Product;
import vn.model.Review;
import vn.services.ProductService;
import vn.services.ReviewService;

import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendRedirect("products");
            return;
        }
        int id = Integer.parseInt(idParam);


        ProductService ps  = new ProductService();
        Product p = ps.getProductById(id);
        ReviewService rs = new ReviewService();
        List<Review> reviews = rs.findByProductId(id);


        if (p == null) {
            response.sendRedirect("products");
            return;
        }
        request.setAttribute("p", p );
        request.setAttribute("reviews", reviews);
        request.setAttribute("currentPage", "products");

        request.getRequestDispatcher("/pages/product-detail.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
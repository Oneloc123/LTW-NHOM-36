package vn.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Product;
import vn.services.ProductService;

import java.io.IOException;

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

        if (p == null) {
            response.sendRedirect("products");
            return;
        }
        request.setAttribute("p", p);

        request.getRequestDispatcher("/pages/product-detail.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
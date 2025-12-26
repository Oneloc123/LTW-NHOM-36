package vn.controller;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Product;
import vn.services.ProductSevice;

@WebServlet("/products")
public class ListProductController extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductSevice ps = new ProductSevice();
        List<Product> list = ps.getListProduct();
        request.setAttribute("list", list);

        request.getRequestDispatcher("/pages/products.jsp").forward(request,response);


    }

    public void destroy() {
    }
}
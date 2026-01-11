package vn.controller.shop;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.model.Product;
import vn.services.ProductService;

import java.io.IOException;
import java.util.List;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        ProductService ps = new ProductService();
        List<Product> list = ps.getListProduct();
        request.setAttribute("list", list);
        request.setAttribute("currentPage", "shop");
        request.getRequestDispatcher("/pages/shop.jsp").forward(request,response);


    }

}

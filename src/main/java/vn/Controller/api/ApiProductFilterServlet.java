package vn.Controller.api;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.google.gson.Gson;
import vn.model.Product;
import vn.services.ProductService;

@WebServlet("/api/products/filter")
public class ApiProductFilterServlet extends HttpServlet {

    private final ProductService ps = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        String keyword = req.getParameter("keyword");
        String sort = req.getParameter("sort");
        Integer minPrice = parseInt(req.getParameter("minPrice"));
        Integer maxPrice = parseInt(req.getParameter("maxPrice"));
        Integer categoryId = parseInt(req.getParameter("category"));

        List<Product> list = ps.filterAjax(keyword, categoryId, minPrice, maxPrice, sort);

        resp.getWriter().write(new Gson().toJson(list));
    }

    private Integer parseInt(String v) {
        try { return (v == null || v.isBlank()) ? null : Integer.parseInt(v); }
        catch (Exception e) { return null; }
    }
}

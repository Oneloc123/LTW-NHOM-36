package vn.Controller.api;

import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import vn.model.PageResult;
import vn.model.Product;
import vn.services.ProductService;

@WebServlet("/api/products/filter")
public class ApiProductFilterServlet extends HttpServlet {

    private final ProductService ps = new ProductService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");

        // ===== 1. PARAMS =====
        String keyword = req.getParameter("keyword");
        String sort = req.getParameter("sort");

        Integer categoryId = parseInt(req.getParameter("category"));
        Integer minPrice = parseInt(req.getParameter("minPrice"));
        Integer maxPrice = parseInt(req.getParameter("maxPrice"));

        // 👉 phân trang
        int page = parseInt(req.getParameter("page"), 1);
        int size = parseInt(req.getParameter("size"), 20);

        // ===== 2. SERVICE =====
        PageResult<Product> result = ps.filterAjaxPaging(
                keyword,
                categoryId,
                minPrice,
                maxPrice,
                sort,
                page,
                size
        );

        // ===== 3. JSON =====
        resp.getWriter().write(gson.toJson(result));
    }

    // ===== UTILS =====
    private Integer parseInt(String v) {
        try {
            return (v == null || v.isBlank()) ? null : Integer.parseInt(v);
        } catch (Exception e) {
            return null;
        }
    }

    private int parseInt(String v, int defaultValue) {
        try {
            return (v == null || v.isBlank()) ? defaultValue : Integer.parseInt(v);
        } catch (Exception e) {
            return defaultValue;
        }
    }
}

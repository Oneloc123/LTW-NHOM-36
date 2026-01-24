package vn.Controller;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Product;
import vn.services.ProductService;

@WebServlet("/products")
public class ListProductController extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ProductService ps = new ProductService();

        // Get filter parameters
        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String featured = request.getParameter("featured");

        // Get sort parameter
        String sort = request.getParameter("sort");

        List<Product> list;

        // Apply filters if parameters exist
        if ((keyword != null && !keyword.trim().isEmpty()) ||
                (category != null && !category.trim().isEmpty()) ||
                (featured != null && !featured.trim().isEmpty())) {

            list = ps.filterProducts(keyword, category, featured);

            // Pass filter parameters back to JSP
            request.setAttribute("keyword", keyword);
            request.setAttribute("category", category);
            request.setAttribute("featured", featured);

        } else {
            // Get all products
            list = ps.getListProduct();
        }

        // Apply sorting if specified
        if (sort != null && !sort.trim().isEmpty()) {
            sortProducts(list, sort);
            request.setAttribute("sort", sort);
        }

        List<Product> newArrivalsList = ps.getNewArrivalsList();

        request.setAttribute("list", list);
        request.setAttribute("newArrivalsList", newArrivalsList);
        request.setAttribute("currentPage", "products");

        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    private void sortProducts(List<Product> products, String sortBy) {
        switch (sortBy) {
            case "price_asc":
                products.sort((p1, p2) -> Integer.compare(p1.getPrice(), p2.getPrice()));
                break;
            case "price_desc":
                products.sort((p1, p2) -> Integer.compare(p2.getPrice(), p1.getPrice()));
                break;
            case "name":
                products.sort((p1, p2) -> p1.getName().compareToIgnoreCase(p2.getName()));
                break;
            case "newest":
            default:
                // Already sorted by newest in DAO
                break;
        }
    }
}
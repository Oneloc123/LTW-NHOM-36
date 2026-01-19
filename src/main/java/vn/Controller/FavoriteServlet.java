package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.model.FavoriteProduct;
import vn.services.FavoriteService;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorites")
public class FavoriteServlet extends HttpServlet {

    private final FavoriteService service = new FavoriteService();
    private static final int PAGE_SIZE = 3;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String status = req.getParameter("status");

        int page = 1;
        if (req.getParameter("page") != null) {
            page = Integer.parseInt(req.getParameter("page"));
        }

        List<FavoriteProduct> filtered = service.filter(keyword, status);

        int totalPages = (int) Math.ceil((double) filtered.size() / PAGE_SIZE);
        int from = (page - 1) * PAGE_SIZE;
        int to = Math.min(from + PAGE_SIZE, filtered.size());

        List<FavoriteProduct> pageList = filtered.subList(from, to);

        req.setAttribute("favorites", pageList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/pages/favorites.jsp").forward(req, resp);


    }
}

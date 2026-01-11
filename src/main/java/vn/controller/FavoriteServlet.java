package vn.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.FavoriteProduct;
import vn.model.User;
import vn.services.FavoriteService;
import vn.services.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "favorites", value = "/favorites")
public class FavoriteServlet extends HttpServlet {

    FavoriteService favoriteService = new FavoriteService();
    UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("login");
            return;
        }

        String username = (String) session.getAttribute("username");
        User user = userService.getUserByUserName(username);

        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        int page = request.getParameter("page") == null ? 1 :
                Integer.parseInt(request.getParameter("page"));
        int pageSize = 6;

        List<FavoriteProduct> favorites =
                favoriteService.getFavorites(user.getId(), keyword, status, page, pageSize);

        int total = favoriteService.countFavorites(user.getId(), keyword, status);
        int totalPages = (int) Math.ceil((double) total / pageSize);

        request.setAttribute("favorites", favorites);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/pages/favorite.jsp").forward(request, response);
    }
}

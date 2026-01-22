package vn.Controller.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.model.Blog;
import vn.services.BlogService;

import java.io.IOException;

@WebServlet("/blog-detail")
public class BlogDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idRaw = request.getParameter("id");

        // 1. Check thiếu id
        if (idRaw == null) {
            response.sendRedirect(request.getContextPath() + "/blog");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idRaw);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/blog");
            return;
        }

        // 2. Gọi service
        BlogService blogService = new BlogService();
        Blog blog = blogService.getBlogById(id);

        // 3. Không tìm thấy blog
        if (blog == null) {
            response.sendRedirect(request.getContextPath() + "/blog");
            return;
        }

        // 4. Set attribute & forward
        request.setAttribute("blog", blog);
        request.setAttribute("currentPage", "blog");
        request.getRequestDispatcher("/pages/blog/blog-detail.jsp").forward(request, response);
    }
}

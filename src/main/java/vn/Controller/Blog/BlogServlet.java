package vn.Controller.Blog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.model.Blog;
import vn.services.BlogService;

import java.io.IOException;
import java.util.List;

@WebServlet("/blog")
public class BlogServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BlogService blogService = new BlogService();
        List<Blog> list = blogService.getAllBlog();
        List<Blog> featureList = blogService.getFeature();

        request.setAttribute("blogs", list);
        request.setAttribute("featureList", featureList);
        request.setAttribute("currentPage", "blog");
        request.getRequestDispatcher("/pages/blog/blog.jsp").forward(request, response);
    }
}


package vn.Controller.admin;

import vn.model.Blog;
import vn.services.BlogService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/blogs")
public class AdminBlogServlet extends HttpServlet {

    private BlogService blogService;
    private DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    @Override
    public void init() {
        blogService = new BlogService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if (action == null) {
            handleListRequest(req, resp);
            return;
        }

        switch (action) {
            case "view":
                handleViewRequest(req, resp);
                break;
            case "delete":
                handleDeleteRequest(req, resp);
                break;
            case "edit":
                handleEditRequest(req, resp);
                break;
            default:
                handleListRequest(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            handleAddRequest(req, resp);
        } else if ("edit".equals(action)) {
            handleUpdateRequest(req, resp);
        } else {
            resp.sendRedirect("blogs");
        }
    }

    // ===== HANDLER METHODS =====

    private void handleListRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        List<Blog> blogs;

        if (keyword != null && !keyword.trim().isEmpty()) {
            blogs = blogService.searchByTitle(keyword);
        } else {
            blogs = blogService.getAllBlogs();
        }

        req.setAttribute("blogs", blogs);
        req.getRequestDispatcher("/admin/admin-blogs.jsp").forward(req, resp);
    }

    private void handleViewRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Blog blog = blogService.getBlogById(id);

        req.setAttribute("blog", blog);
        req.getRequestDispatcher("/admin/blog-detail.jsp").forward(req, resp);
    }

    private void handleEditRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Blog editBlog = blogService.getBlogById(id);

        // Giữ lại kết quả tìm kiếm nếu có
        String keyword = req.getParameter("keyword");
        List<Blog> blogs = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            blogs = blogService.searchByTitle(keyword);
        }

        req.setAttribute("editBlog", editBlog);
        if (blogs != null) {
            req.setAttribute("blogs", blogs);
        }

        req.getRequestDispatcher("/admin/admin-blogs.jsp").forward(req, resp);
    }

    private void handleAddRequest(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String title = req.getParameter("Title");
        String thumbnail = req.getParameter("Thumbnail");
        String summary = req.getParameter("Summary");
        String content = req.getParameter("Content");
        String author = req.getParameter("Author");

        if (title == null || title.trim().isEmpty()) {
            req.setAttribute("error", "Tiêu đề bài viết không được để trống");
            handleListRequest(req, resp);
            return;
        }

        Blog blog = new Blog();
        blog.setTitle(title.trim());
        blog.setThumbnail(thumbnail != null ? thumbnail.trim() : null);
        blog.setSummary(summary != null ? summary.trim() : null);
        blog.setContent(content != null ? content.trim() : null);
        blog.setAuthor(author != null ? author.trim() : "Admin");
        blog.setCreatedAt(LocalDateTime.now().toString());

        boolean success = blogService.addBlog(blog);

        if (success) {
            resp.sendRedirect("blogs");
        } else {
            req.setAttribute("error", "Có lỗi xảy ra khi thêm bài viết");
            handleListRequest(req, resp);
        }
    }

    private void handleUpdateRequest(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("Title");
        String thumbnail = req.getParameter("Thumbnail");
        String summary = req.getParameter("Summary");
        String content = req.getParameter("Content");
        String author = req.getParameter("Author");

        if (title == null || title.trim().isEmpty()) {
            req.setAttribute("error", "Tiêu đề bài viết không được để trống");
            handleListRequest(req, resp);
            return;
        }

        Blog blog = new Blog();
        blog.setId(id);
        blog.setTitle(title.trim());
        blog.setThumbnail(thumbnail != null ? thumbnail.trim() : null);
        blog.setSummary(summary != null ? summary.trim() : null);
        blog.setContent(content != null ? content.trim() : null);
        blog.setAuthor(author != null ? author.trim() : "Admin");

        boolean success = blogService.updateBlog(blog);

        if (success) {
            resp.sendRedirect("blogs");
        } else {
            req.setAttribute("error", "Có lỗi xảy ra khi cập nhật bài viết");
            handleListRequest(req, resp);
        }
    }

    private void handleDeleteRequest(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        blogService.deleteBlogById(id);
        resp.sendRedirect("blogs");
    }
}
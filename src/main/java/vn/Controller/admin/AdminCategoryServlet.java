package vn.Controller.admin;

import vn.services.CategoryService;
import vn.model.Category;
import vn.services.CategoryService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryService categoryService;

    @Override
    public void init() {
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("id") == null || session.getAttribute("role") == null) {
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            return;
        }

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
            resp.sendRedirect("categories");
        }
    }

    // ===== HANDLER METHODS =====

    private void handleListRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        List<Category> categories;

        if (keyword != null && !keyword.trim().isEmpty()) {
            categories = categoryService.searchByName(keyword);
        } else {
            categories = categoryService.getAllCategories();
        }

        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/admin/admin-categories.jsp").forward(req, resp);
    }

    private void handleViewRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Category category = categoryService.getCategoryById(id);
        int productCount = categoryService.countProductsInCategory(id);

        req.setAttribute("category", category);
        req.setAttribute("productCount", productCount);
        req.getRequestDispatcher("/admin/category-detail.jsp").forward(req, resp);
    }

    private void handleEditRequest(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // CHỈ lấy category để edit, KHÔNG load lại danh sách
        int id = Integer.parseInt(req.getParameter("id"));
        Category editCategory = categoryService.getCategoryById(id);

        // Lấy danh sách categories HIỆN TẠI (nếu có)
        String keyword = req.getParameter("keyword");
        List<Category> categories = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            categories = categoryService.searchByName(keyword);
        }

        req.setAttribute("editCategory", editCategory);
        if (categories != null) {
            req.setAttribute("categories", categories);
        }

        req.getRequestDispatcher("/admin/admin-categories.jsp").forward(req, resp);
    }

    private void handleAddRequest(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String name = req.getParameter("Name");
        String description = req.getParameter("Description");
        String imageURL = req.getParameter("ImageURL");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống");
            handleListRequest(req, resp);
            return;
        }

        Category category = new Category();
        category.setName(name.trim());
        category.setDescription(description != null ? description.trim() : null);
        category.setImageURL(imageURL != null ? imageURL.trim() : null);

        boolean success = categoryService.addCategory(category);

        if (success) {
            resp.sendRedirect("categories");
        } else {
            req.setAttribute("error", "Tên danh mục đã tồn tại");
            handleListRequest(req, resp);
        }
    }

    private void handleUpdateRequest(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("Name");
        String description = req.getParameter("Description");
        String imageURL = req.getParameter("ImageURL");

        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Tên danh mục không được để trống");
            handleListRequest(req, resp);
            return;
        }

        Category category = new Category();
        category.setId(id);
        category.setName(name.trim());
        category.setDescription(description != null ? description.trim() : null);
        category.setImageURL(imageURL != null ? imageURL.trim() : null);

        boolean success = categoryService.updateCategory(category);

        if (success) {
            resp.sendRedirect("categories");
        } else {
            req.setAttribute("error", "Tên danh mục đã tồn tại");
            handleListRequest(req, resp);
        }
    }

    private void handleDeleteRequest(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int id = Integer.parseInt(req.getParameter("id"));

        if (!categoryService.canDeleteCategory(id)) {
            req.setAttribute("error", "Không thể xóa danh mục có chứa sản phẩm");
            handleListRequest(req, resp);
            return;
        }

        categoryService.deleteCategoryById(id);
        resp.sendRedirect("categories");
    }
}
package vn.Controller.admin;

import vn.model.User;
import vn.services.UserService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
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
            listUsers(req, resp);
            return;
        }

        switch (action) {
            case "view":
                viewUser(req, resp);
                break;
            case "delete":
                deleteUser(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                User editUser = userService.getUserById(id);
                req.setAttribute("editUser", editUser);
                listUsers(req, resp);
                break;
            default:
                listUsers(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addUser(req, resp);
        } else if ("edit".equals(action)) {
            editUser(req, resp);
        }
    }

    // ===== METHODS =====

    private void listUsers(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String role = req.getParameter("role");
        String status = req.getParameter("status");

        List<User> users;

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasRole = role != null && !role.isEmpty();
        boolean hasStatus = status != null && !status.isEmpty();

        if (hasKeyword || hasRole || hasStatus) {
            // search + filter
            users = userService.filterUsers(keyword, role, status);
        } else {
            // load all
            users = userService.getAllUsers();
        }

        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/admin-users.jsp").forward(req, resp);
    }


    private void viewUser(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        User user = userService.getUserById(id);

        req.setAttribute("user", user);
        req.getRequestDispatcher("/admin/user-detail.jsp").forward(req, resp);
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        User u = new User();
        u.setUsername(req.getParameter("UserName"));
        u.setFullName(req.getParameter("FullName"));
        u.setEmail(req.getParameter("Email"));
        u.setPassword(req.getParameter("Password"));
        u.setPhoneNumber(req.getParameter("Phone"));
        u.setRole(req.getParameter("Role"));
        u.setActive("1".equals(req.getParameter("IsActive")));

        userService.registerUser(u);
        resp.sendRedirect("users");
    }

    private void editUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        User u = new User();
        u.setId(Integer.parseInt(req.getParameter("id")));
        u.setUsername(req.getParameter("UserName"));
        u.setFullName(req.getParameter("FullName"));
        u.setEmail(req.getParameter("Email"));
        u.setPhoneNumber(req.getParameter("Phone"));
        u.setRole(req.getParameter("Role"));
        u.setActive("1".equals(req.getParameter("IsActive")));

        userService.updateUser(u);
        resp.sendRedirect("users");
    }

    private void deleteUser(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        userService.deleteUserById(id);
        resp.sendRedirect("users");
    }
}
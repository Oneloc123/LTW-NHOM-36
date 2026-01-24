package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("id") == null) {
            request.getRequestDispatcher("/pages/login.jsp")
                    .forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null) {
            request.getRequestDispatcher("/pages/login.jsp")
                    .forward(request, response);
            return;
        }

        UserService userService = new UserService();
        boolean check = userService.checkUserNameAndPassword(username, password);

        if (check) {
            User user = userService.getUserByUserName(username);
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("id", user.getId());


            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("/pages/login.jsp")
                    .forward(request, response);
        }
    }
}

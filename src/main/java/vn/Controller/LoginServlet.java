package vn.controller;

import com.mysql.cj.Session;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {
    UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }else{
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username == null || password == null){
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
        boolean check = userService.checkUserNameAndPassword(username, password);
        if(check){
            UserService userService = new UserService();
            User user = userService.getUserByUserName(username);
            HttpSession session = request.getSession();
            session.setAttribute("id", user.getId());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }else{
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
}
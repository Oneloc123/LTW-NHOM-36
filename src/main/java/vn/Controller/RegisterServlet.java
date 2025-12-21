package vn.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("username") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
        }else{
            request.getRequestDispatcher("/pages/register.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("userName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        if(password.equals(confirmPassword)){
            UserService us = new UserService();
            User u = new User();
            u.setFullName(fullname);
            u.setEmail(email);
            u.setPassword(password);
            u.setUsername(username);
            u.setPhoneNumber(phone);
            u.setActive(true);
            u.setImgURL("/images/default.jpg");
            u.setRole("USER");
            u.setCreatAt("0/0/0");
            us.registerUser(u);
        }
    }
}
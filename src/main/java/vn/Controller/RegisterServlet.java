package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Password;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Date;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("id") != null) {
            response.sendRedirect(request.getContextPath() + "/home");
        }else{
            request.getRequestDispatcher("/pages/register.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullname = request.getParameter("fullName");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String username = request.getParameter("userName");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if(password.equals(confirmPassword)){
            UserService us = new UserService();
            if(us.getUserByUserName(username) != null){
                response.sendRedirect("../login");
            }
            User u = new User();
            u.setFullName(fullname);
            u.setAddress(address);
            u.setEmail(email);
            u.setPassword(Password.hashPassword(password));
            u.setUsername(username);
            u.setPhoneNumber(phone);
            u.setActive(true);
            u.setImgURL("/images/default.jpg");
            u.setRole("USER");
            u.setCreateAt(LocalDate.now().toString());
            us.registerUser(u);
            response.sendRedirect("../login");
        }
    }
}
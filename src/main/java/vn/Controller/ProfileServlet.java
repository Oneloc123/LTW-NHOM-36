package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "ProfileServlet", value = "/Profile/*")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        User u = us.getUserByUserName(request.getParameter("username"));
        if(u!=null){
            request.setAttribute("user",u);

        }
        request.getRequestDispatcher("/pages/profile.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
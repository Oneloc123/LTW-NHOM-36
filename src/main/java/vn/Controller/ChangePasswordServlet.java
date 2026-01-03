package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "ChangPasswordServlet", value = "/changePassword")
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        }else{
            User u = us.getUserById(Integer.parseInt(session.getAttribute("id").toString()));
            if(u!=null){
                request.setAttribute("user",u);
            }
            request.getRequestDispatcher("/pages/changePassword.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int id  = Integer.parseInt(session.getAttribute("id").toString());
        UserService us =new UserService();
        User u = us.getUserById(id);
        String oldPassword = request.getParameter("oldPass");
        String newPassword = request.getParameter("newPass");
        if(oldPassword.equals(u.getPassword())){
            UserService usr = new UserService();
            usr.updatePassword(id,newPassword);
            response.sendRedirect("/Profile");
        }
    }
}
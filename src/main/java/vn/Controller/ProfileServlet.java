package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.User;
import vn.services.AddressService;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "ProfileServlet", value = "/profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        }else{
            // lấy thông tin User
            User u = us.getUserById(Integer.parseInt(session.getAttribute("id").toString()));
            request.setAttribute("user",u);
            // chuyển hướng
            request.getRequestDispatcher("/pages/profile.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if("save".equals(action)){
            // tạo service
            UserService us =new UserService();
            // truy vấn user
            HttpSession session = request.getSession(false);
            int id = Integer.parseInt(session.getAttribute("id").toString());
            User u = us.getUserById(id);
            // lấy thông tin gửi từ client
            String nameFirstModal = request.getParameter("modalFirstName");
            String nameLastModal = request.getParameter("modalLastName");
            String emailModal = request.getParameter("modalEmail");
            String phoneModal = request.getParameter("modalPhone");
            // kiểm tra các thông tin

            // thực hiện update User
            u.setFirstName(nameFirstModal);
            u.setLastName(nameLastModal) ;
            u.setEmail(emailModal);
            u.setPhoneNumber(phoneModal);
            //
            us.updateUser(u);
            request.removeAttribute("user");
            request.setAttribute("user",u);
            request.getRequestDispatcher("/pages/profile.jsp").forward(request,response);
        }
        if(action.equals("deny")){

        }
    }
}
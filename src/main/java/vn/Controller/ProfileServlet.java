package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Address;
import vn.model.User;
import vn.services.AddressService;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "ProfileServlet", value = "/Profile")
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        AddressService as =new AddressService();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
        }else{
            User u = us.getUserByUserName(session.getAttribute("username").toString());
//            Address ad = as.getAddressById(u.getId());
//            if(ad==null){
//
//            }
            if(u!=null){
                request.setAttribute("user",u);
            }
//            if(ad!=null){
//                request.setAttribute("address",ad);
//            }
            request.getRequestDispatcher("/pages/profile.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action.equals("save")){
            UserService us =new UserService();
            AddressService as = new AddressService();
            HttpSession session = request.getSession(false);
            String name = session.getAttribute("username").toString();
            User u = us.getUserByUserName(request.getParameter("username"));
            String nameFirstModal = request.getParameter("modalFirstName");
            String nameLastModal = request.getParameter("modalLastName");
            String emailModal = request.getParameter("modalEmail");
            String phoneModal = request.getParameter("modalPhone");
            String addressModal = request.getParameter("modalAddress");
            u.setFullName(nameFirstModal+" "+nameLastModal);
            u.setEmail(emailModal);
            u.setPhoneNumber(phoneModal);
            us.updateUser(u);
            as.updateAdress(u.getId(),addressModal);
        }
        if(action.equals("deny")){

        }
    }
}
package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Password;
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
        HttpSession session = request.getSession();
        UserService us =new UserService();

        User user = us.getUserById(Integer.parseInt(session.getAttribute("id").toString()));

        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String otp = request.getParameter("otp");

        String sessionOtp = (String) session.getAttribute("OTP");

        try {
            if (sessionOtp == null || !sessionOtp.equals(otp)) {
                throw new Exception("Mã xác thực không hợp lệ hoặc đã hết hạn");
            }

            if (!Password.checkPassword(oldPass, user.getPassword())) {
                throw new Exception("Mật khẩu cũ không đúng");
            }

            if (newPass.length() < 8) {
                throw new Exception("Mật khẩu mới phải ít nhất 8 ký tự");
            }

            user.setPassword(Password.hashPassword(newPass));
            us.updateUser(user);

            session.removeAttribute("OTP");
            request.setAttribute("success", "Đổi mật khẩu thành công");

        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }

        request.getRequestDispatcher("/pages/changePassword.jsp").forward(request, response);

    }
}
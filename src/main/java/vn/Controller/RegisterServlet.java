package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.EmailUtil;
import vn.model.Password;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService us =new UserService();
        HttpSession session = request.getSession(false);

        if(request.getAttribute("message") != null){
            request.removeAttribute("message");
        }

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

        // Kiểm tra mật khẩu khớp
        if(!password.equals(confirmPassword)){
            request.setAttribute("error", "Mật khẩu xác nhận không khớp");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra username/email đã tồn tại
        UserService us = new UserService();
        if(us.getUserByUserName(username) != null){
            request.setAttribute("error", "Tên đăng nhập đã tồn tại");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }

        if(us.getUserByEmail(email) != null){
            request.setAttribute("error", "Email đã được sử dụng");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
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
        HttpSession session = request.getSession();
        session.setAttribute("REGISTER_USER", u);

        // Tạo OTP mới
        String otp = String.valueOf((int)(Math.random() * 900000 + 100000));
        session.setAttribute("OTP", otp);
        session.setAttribute("OTP_TIME", System.currentTimeMillis());

        //
        String emailforlogin = u.getEmail();
        String body = """
                    <div style="font-family:Arial,sans-serif">
                    <h2 style="color:#004a99">TechX - Xác thực đăng ký</h2>
                    <p>Mã xác thực của bạn là:</p>
                    <h1 style="letter-spacing:4px">%s</h1>
                    <p>Mã có hiệu lực trong 5 phút.</p>
                    <hr>
                    <small>Nếu bạn không yêu cầu, hãy bỏ qua email này.</small>
                    </div>
                    """.formatted(otp);

        // Gửi mail
        EmailUtil.send(
                emailforlogin,
                "Xác thực đăng ký",
                body
        );
        response.sendRedirect(request.getContextPath() + "/register-otp");
    }
}
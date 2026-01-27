package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.EmailUtil;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "OTPForLogin", value = "/send-otp-forLogin")
public class OTPForLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String loginState = (String) session.getAttribute("loginState");

        if (!"checkOTP".equals(loginState)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String username = (String) session.getAttribute("username");
        UserService us = new UserService();
        User user = us.getUserByUserName(username);

        // Tạo OTP mới
        String otp = String.valueOf((int)(Math.random() * 900000 + 100000));
        session.setAttribute("OTP", otp);
        session.setAttribute("OTP_TIME", System.currentTimeMillis());

        //
        String email = user.getEmail();
        String body = """
                    <div style="font-family:Arial,sans-serif">
                    <h2 style="color:#004a99">TechX - Xác thực đăng nhập</h2>
                    <p>Mã xác thực của bạn là:</p>
                    <h1 style="letter-spacing:4px">%s</h1>
                    <p>Mã có hiệu lực trong 5 phút.</p>
                    <hr>
                    <small>Nếu bạn không yêu cầu, hãy bỏ qua email này.</small>
                    </div>
                    """.formatted(otp);

        // Gửi mail
        EmailUtil.send(
                email,
                "Xác thực đăng nhập",
                body
        );

        //  AJAX request
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("""
            {
              "status": "success",
              "message": "Mã OTP đã được gửi lại tới email."
            }
        """);
            return;
        }

        // Request thường
        request.setAttribute("success", "Mã OTP đã được gửi tới email.");
        request.getRequestDispatcher("/pages/OTPforLogin.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String otp = request.getParameter("otp");
        String otpSession = (String) request.getSession().getAttribute("OTP");

        if (otp != null && otp.equals(otpSession)) {
            HttpSession session = request.getSession();
            UserService us = new UserService();
            String username = session.getAttribute("username").toString();
            User user = us.getUserByUserName(username);
            session.setAttribute("id", user.getId());
            session.removeAttribute("loginState");
            if(user.getRole().equalsIgnoreCase("admin")){
                session.setAttribute("role", "admin");
                response.sendRedirect("/admin/dashBoard");
            }else{
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "OTP không đúng hoặc đã hết hạn");
            request.getRequestDispatcher("/pages/OTPforLogin.jsp").forward(request, response);
        }
    }
}
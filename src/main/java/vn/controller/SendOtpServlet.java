package vn.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.EmailUtil;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet("/send-otp")
public class SendOtpServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String otp = String.valueOf((int)(Math.random() * 900000 + 100000));

        session.setAttribute("OTP", otp);
        session.setMaxInactiveInterval(300); // 5 phút

        int id = Integer.parseInt(session.getAttribute("id").toString()) ;
        UserService  userService = new UserService();
        User user = userService.getUserById(id);
        String email = user.getEmail();

        String body = """
        <div style="font-family:Arial,sans-serif">
        <h2 style="color:#004a99">TechX - Xác thực đổi mật khẩu</h2>
        <p>Mã xác thực của bạn là:</p>
        <h1 style="letter-spacing:4px">%s</h1>
        <p>Mã có hiệu lực trong 5 phút.</p>
        <hr>
        <small>Nếu bạn không yêu cầu, hãy bỏ qua email này.</small>
        </div>
        """.formatted(otp);

        EmailUtil.send(email,
                "Xác thực đổi mật khẩu",
                body);

        request.setAttribute("success", "Mã xác thực đã được gửi tới email.");
        request.getRequestDispatcher("/pages/changePassword.jsp").forward(request, response);
    }
}
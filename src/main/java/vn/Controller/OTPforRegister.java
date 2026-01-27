package vn.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.EmailUtil;
import vn.model.User;
import vn.services.UserService;

import java.io.IOException;

@WebServlet(name = "OTPforRegister", value = "/register-otp")
public class OTPforRegister extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("REGISTER_USER") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        request.getRequestDispatcher("/pages/RegisterOTP.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String inputOtp = request.getParameter("otp");
        String otpSession = (String) session.getAttribute("OTP");
        Long time = (Long) session.getAttribute("REGISTER_OTP_TIME");


        if (!inputOtp.equals(otpSession)) {
            request.setAttribute("error", "OTP không đúng");
            request.getRequestDispatcher("/pages/RegisterOTP.jsp").forward(request, response);
            return;
        }

        // ==== OTP ĐÚNG → TẠO USER ====
        User user = (User) session.getAttribute("REGISTER_USER");
        UserService us = new UserService();
        us.registerUser(user);


        response.sendRedirect(request.getContextPath() + "/login");
    }
}
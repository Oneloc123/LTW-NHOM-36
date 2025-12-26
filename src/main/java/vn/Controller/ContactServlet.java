package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.services.ContactService;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/pages/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String message = req.getParameter("message");

        boolean success = contactService.saveContact(name, email, message);

        if (success) {
            req.setAttribute("success", "Gửi liên hệ thành công!");
        } else {
            req.setAttribute("error", "Gửi liên hệ thất bại!");
        }

        req.getRequestDispatcher("/pages/contact.jsp")
                .forward(req, resp);
    }
}

package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import vn.model.Contact;
import vn.services.ContactService;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {

    private ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/WEB-INF/views/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        Contact contact = new Contact(name, email, message);
        contactService.saveContact(contact);

        request.setAttribute("success", "Gửi liên hệ thành công!");
        request.getRequestDispatcher("/WEB-INF/views/contact.jsp")
                .forward(request, response);
    }
}

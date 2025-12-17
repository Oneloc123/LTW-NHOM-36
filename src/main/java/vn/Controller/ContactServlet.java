package vn.Controller;

import vn.dao.ContactDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactDao contactDao = new ContactDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        boolean success = ContactDao.insert(name, email, subject, message);

        if (success) {
            resp.sendRedirect("pages/contact.jsp?success=1");
        } else {
            resp.sendRedirect("pages/contact.jsp?error=1");
        }
    }
}

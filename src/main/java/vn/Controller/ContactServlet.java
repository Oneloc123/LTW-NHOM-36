package vn.controller;

import vn.dao.ContactDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.services.ContactService;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactDao contactDao = new ContactDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gán hàm kiểm tra đang ở trang nào thì nó lỗi ở dòng dưới, với lại dòng dưới không thay đường dẫn trang
        //response.sendRedirect("pages/contact.jsp");
        request.setAttribute("currentPage", "contact");
        request.getRequestDispatcher("/pages/contact.jsp").forward(request, response);

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        ContactService cs  = new ContactService();

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");

        System.out.println("name: " + name);
        boolean success = cs.saveContact(name,email,subject,message);



        if (success) {
            resp.sendRedirect("pages/contact.jsp");
        } else {
            resp.sendRedirect("pages/contact.jsp");
        }
    }
}

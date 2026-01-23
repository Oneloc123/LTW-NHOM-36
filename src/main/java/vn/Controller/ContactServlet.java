package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.services.ContactService;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // dùng cho header active menu
        request.setAttribute("currentPage", "contact");

        request.getRequestDispatcher("/pages/contact.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 1. đảm bảo tiếng Việt
        req.setCharacterEncoding("UTF-8");

        // 2. lấy dữ liệu từ form
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String message = req.getParameter("message");

        // 3. validate cơ bản
        if (name == null || email == null || message == null ||
                name.isBlank() || email.isBlank() || message.isBlank()) {

            req.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            req.getRequestDispatcher("/pages/contact.jsp").forward(req, resp);
            return;
        }

        // 4. gọi service
        boolean success = contactService.saveContact(name, email, message);

        // 5. trả kết quả về view
        if (success) {
            req.setAttribute("success", "Gửi liên hệ thành công!");
        } else {
            req.setAttribute("error", "Hệ thống đang bận, vui lòng thử lại.");
        }

        req.getRequestDispatcher("/pages/contact.jsp")
                .forward(req, resp);
    }
}

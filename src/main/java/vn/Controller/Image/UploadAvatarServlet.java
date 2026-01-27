package vn.Controller.Image;

import jakarta.mail.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.model.User;
import vn.services.UserService;

import java.io.File;
import java.io.IOException;

@WebServlet("/upload-avatar")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 2 * 1024 * 1024,    // 2MB
        maxRequestSize = 5 * 1024 * 1024
)
public class UploadAvatarServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy file
        Part filePart = request.getPart("avatar");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect("profile?error=nofile");
            return;
        }

        // 2. Lấy tên file gốc
        String fileName = PathUtil.getFileName(filePart);

        // 3. Thư mục lưu ảnh
        String uploadPath = getServletContext().getRealPath("/uploads/avatar");

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 4. Tạo tên file mới (tránh trùng)
        String newFileName = System.currentTimeMillis() + "_" + fileName;

        // 5. Ghi file
        filePart.write(uploadPath + File.separator + newFileName);

        // 6. Lưu đường dẫn vào DB (VD)
        String avatarUrl = "uploads/avatar/" + newFileName;

        UserService us =new UserService();
        HttpSession session = request.getSession(false);
        int userId = Integer.parseInt(session.getAttribute("id").toString());


        // TODO: update avatarUrl vào bảng USER theo userId
        userService.updateAvatar(userId, avatarUrl);

        // 7. Redirect
        response.sendRedirect("profile");
    }
}

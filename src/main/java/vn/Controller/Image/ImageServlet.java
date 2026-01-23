package vn.Controller.Image;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String path = req.getParameter("path");

        File file = new File(path);
        if (!file.exists()) {
            resp.sendError(404);
            return;
        }

        resp.setContentType(getServletContext().getMimeType(file.getName()));
        Files.copy(file.toPath(), resp.getOutputStream());
    }
}

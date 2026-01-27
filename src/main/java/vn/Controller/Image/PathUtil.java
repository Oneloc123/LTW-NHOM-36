package vn.Controller.Image;

import jakarta.servlet.http.Part;

public class PathUtil {
    public static String getFileName(Part part) {
        String content = part.getHeader("content-disposition");
        for (String s : content.split(";")) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
    }
}

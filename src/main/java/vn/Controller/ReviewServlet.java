package vn.Controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.model.Review;
import vn.model.User;
import vn.services.ReviewService;

import java.io.IOException;

@WebServlet("/rate")
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int userId = user.getId(); // AN TOÀN

        Review review = new Review();
        review.setUserId(userId);
        review.setProductId(Integer.parseInt(req.getParameter("productId")));
        review.setRating(Integer.parseInt(req.getParameter("rating")));
        review.setComment(req.getParameter("comment"));

        ReviewService service = new ReviewService();
        service.rateProduct(review);

        System.out.println("SESSION = " + req.getSession(false));
        System.out.println("USER = " + req.getSession(false).getAttribute("user"));

        resp.sendRedirect("product?id=" + review.getProductId());
    }
}

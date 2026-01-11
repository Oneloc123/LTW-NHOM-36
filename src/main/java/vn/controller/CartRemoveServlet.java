package vn.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.dao.CartDao;

import java.io.IOException;

@WebServlet("/cart-remove")
public class CartRemoveServlet extends HttpServlet {

    private final CartDao cartDao = new CartDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        cartDao.remove(id);

        response.sendRedirect("cart");
    }
}

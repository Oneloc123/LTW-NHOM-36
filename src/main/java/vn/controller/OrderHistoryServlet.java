package vn.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.model.Order;
import vn.model.User;
import vn.services.OrderService;
import vn.services.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryServlet", value = "/orders")
public class OrderHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);

        }else{
            UserService userService = new UserService();
            User u = userService.getUserByUserName(session.getAttribute("username").toString());
            int uid = u.getId();
            OrderService os = new OrderService();
            List<Order> list = os.getListOrderById(uid);
            request.setAttribute("list", list);
            request.setAttribute("currentPage", "orders");
            request.getRequestDispatcher("/pages/order-history.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
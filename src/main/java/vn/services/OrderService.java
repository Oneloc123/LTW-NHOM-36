package vn.services;

import vn.dao.OrderDao;
import vn.model.Order;
import vn.model.OrderItem;

import java.util.List;

public class OrderService {

    private final OrderDao dao = new OrderDao();

    public int placeOrder(Order order, List<OrderItem> items) {
        return dao.insertOrder(order, items);
    }

    public List<Order> getListOrderByUserId(int userId) {
        return dao.getListOrderByUserId(userId);
    }
}

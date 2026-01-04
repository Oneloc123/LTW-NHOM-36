package vn.services;

import vn.dao.OrderDao;
import vn.model.Order;
import java.util.List;

public class OrderService {

    private final OrderDao orderDao = new OrderDao();

    public List<Order> getListOrderByUserId(int userId) {
        return orderDao.getListByUserId(userId);
    }
}

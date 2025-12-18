package vn.services;

import vn.dao.OrderDao;
import vn.model.Order;

import java.util.List;

public class OrderService {
    OrderDao orderDao = new OrderDao();
    public List<Order> getListOrderById(int id){
        return orderDao.getListOrderById(id);
    }


}

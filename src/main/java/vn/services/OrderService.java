package vn.services;

import vn.model.Order;

import java.util.ArrayList;
import java.util.List;

public class OrderService {

    public List<Order> getOrdersByUser(int userId) {

        List<Order> list = new ArrayList<>();

        list.add(new Order(1001, userId, "DELIVERED", "14/10/2025", 12480000));
        list.add(new Order(1002, userId, "SHIPPING", "20/10/2025", 6490000));
        list.add(new Order(1003, userId, "CANCELED", "22/10/2025", 2000000));

        return list;
    }
}

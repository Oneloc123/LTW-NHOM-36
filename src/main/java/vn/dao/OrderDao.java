package vn.dao;

import vn.model.Order;

import java.util.List;

public class OrderDao extends BaseDao{
    public List<Order> getListByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id, address_id, order_status, created_at " +
                                        "FROM orders " +
                                        "WHERE user_id = :userId " +
                                        "ORDER BY created_at DESC"
                        )
                        .bind("userId", userId)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        OrderDao orderDao = new OrderDao();
        List<Order> orders = orderDao.getListByUserId(1);
        for (Order order : orders) {
            System.out.println(order.getOrderStatus());
        }
    }

}

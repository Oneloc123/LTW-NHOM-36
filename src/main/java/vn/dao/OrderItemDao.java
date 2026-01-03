package vn.dao;

import vn.model.OrderItem;

import java.util.List;

public class OrderItemDao extends BaseDao{
    public List<OrderItem> getListByOrderId(int orderId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, order_id, product_id, quantity " +
                                        "FROM order_items " +
                                        "WHERE order_id = :orderId"
                        )
                        .bind("orderId", orderId)
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        OrderItemDao orderItemDao = new OrderItemDao();
        List<OrderItem> list = orderItemDao.getListByOrderId(1);
        for (OrderItem orderItem : list) {
            System.out.println(orderItem.getProductId());
        }
    }
}

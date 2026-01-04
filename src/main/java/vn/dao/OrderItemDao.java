package vn.dao;

import vn.model.OrderItem;
import java.util.List;

public class OrderItemDao extends BaseDao {

    public List<OrderItem> getListByOrderId(int orderId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT " +
                                        "id, " +
                                        "order_id AS orderId, " +
                                        "product_id AS productId, " +
                                        "quantity " +
                                        "FROM order_items " +
                                        "WHERE order_id = :orderId"
                        )
                        .bind("orderId", orderId)
                        .mapToBean(OrderItem.class)
                        .list()
        );
    }

    // test nhanh
    public static void main(String[] args) {
        OrderItemDao dao = new OrderItemDao();
        List<OrderItem> list = dao.getListByOrderId(1);
        for (OrderItem i : list) {
            System.out.println(i.getProductId());
        }
    }
}

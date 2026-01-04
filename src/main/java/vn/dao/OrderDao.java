package vn.dao;

import vn.model.Order;
import java.util.List;

public class OrderDao extends BaseDao {

    public List<Order> getListByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT " +
                                        "id, " +
                                        "user_id AS userId, " +
                                        "order_status AS orderStatus, " +
                                        "created_at AS createAt, " +
                                        "total " +
                                        "FROM orders " +
                                        "WHERE user_id = :userId " +
                                        "ORDER BY created_at DESC"
                        )
                        .bind("userId", userId)
                        .mapToBean(Order.class)
                        .list()
        );
    }

    // test nhanh
    public static void main(String[] args) {
        OrderDao dao = new OrderDao();
        List<Order> list = dao.getListByUserId(1);
        for (Order o : list) {
            System.out.println(o.getId() + " | " + o.getOrderStatus());
        }
    }
}

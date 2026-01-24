package vn.dao;

import vn.model.Review;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class ReviewDao extends BaseDao {

    // Kiểm tra user đã rate chưa
    public boolean existsByUserAndProduct(int userId, int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT 1 FROM reviews WHERE user_id = :userId AND product_id = :productId"
                        )
                        .bind("userId", userId)
                        .bind("productId", productId)
                        .mapTo(Integer.class)
                        .findFirst()
                        .isPresent()
        );
    }



    // Thêm review
    public void insert(Review review) {
        get().useHandle(h ->
                h.createUpdate(
                                "INSERT INTO reviews (user_id, product_id, rating, comment) " +
                                        "VALUES (:userId, :productId, :rating, :comment)"
                        )
                        .bindBean(review)
                        .execute()
        );
    }



    // Lấy danh sách review theo product
    public List<Review> findByProductId(int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id AS userId, product_id AS productId, rating, comment, created_at AS createdAt " +
                                        "FROM reviews WHERE product_id = :productId ORDER BY created_at DESC"
                        )
                        .bind("productId", productId)
                        .mapToBean(Review.class)
                        .list()
        );
    }

}

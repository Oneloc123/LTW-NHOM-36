package vn.dao;

import vn.model.FavoriteProduct;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class FavoriteDao {

    // DEMO DATA (chạy trước khi có DB)
    static List<FavoriteProduct> data = new ArrayList<>();

    static {
        for (int i = 1; i <= 20; i++) {
            FavoriteProduct p = new FavoriteProduct();
            p.setId(i);
            p.setUserId(1);
            p.setProductId(i);
            p.setProductName("Camera " + i);
            p.setPrice(500000 + i * 10000);
            p.setStatus(i % 2 == 0 ? "AVAILABLE" : "RENTED");
            p.setImageUrl("assets/img/product/demo.png");
            p.setCreatedAt(new Date());
            data.add(p);
        }
    }

    public List<FavoriteProduct> getFavorites(
            int userId,
            String keyword,
            String status,
            int page,
            int pageSize
    ) {
        return data.stream()
                .filter(p -> p.getUserId() == userId)
                .filter(p -> keyword == null || keyword.isEmpty()
                        || p.getProductName().toLowerCase().contains(keyword.toLowerCase()))
                .filter(p -> status == null || status.isEmpty()
                        || p.getStatus().equals(status))
                .skip((long) (page - 1) * pageSize)
                .limit(pageSize)
                .collect(Collectors.toList());
    }

    public int countFavorites(int userId, String keyword, String status) {
        return (int) data.stream()
                .filter(p -> p.getUserId() == userId)
                .filter(p -> keyword == null || keyword.isEmpty()
                        || p.getProductName().toLowerCase().contains(keyword.toLowerCase()))
                .filter(p -> status == null || status.isEmpty()
                        || p.getStatus().equals(status))
                .count();
    }
}

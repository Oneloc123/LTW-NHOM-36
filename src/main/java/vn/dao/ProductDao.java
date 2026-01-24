package vn.dao;

import vn.model.Product;

import java.util.*;

public class ProductDao extends BaseDao {
    static Map<Integer, Product> data = new HashMap<Integer, Product>();

    /* getListProduct
     *   - Lấy dữ liệu từ DataBase ra sử dụng
     * */
//    public List<Product> getListProduct() {
//    return new ArrayList<>(data.values());
//    }
//    public List<Product> getListProduct() {
//        return get().withHandle(h ->
//                h.createQuery(
//                                "SELECT id, name, category_id, short_description, full_description, " +
//                                        "price, is_featured, created_at, updated_at " +
//                                        "FROM products"
//                        )
//                        .mapToBean(Product.class)
//                        .list()
//        );
//    }
    public List<Product> getListProduct() {
        return get().withHandle(h -> {

            String sql = """
                        SELECT p.id, p.name, p.category_id, p.short_description, p.full_description,
                               p.price, p.is_featured, p.created_at, p.updated_at,
                               pi.url AS image_url
                        FROM products p
                        LEFT JOIN product_images pi ON p.id = pi.product_id
                        ORDER BY p.id
                    """;

            // Map để gom sản phẩm theo id
            Map<Integer, Product> map = new LinkedHashMap<>();

            h.createQuery(sql).map((rs, ctx) -> {
                int productId = rs.getInt("id");

                // nếu chưa có product thì tạo mới
                Product p = map.get(productId);
                if (p == null) {
                    p = new Product();
                    p.setId(productId);
                    p.setName(rs.getString("name"));
                    p.setCategoryID(rs.getInt("category_id"));
                    p.setShortDescription(rs.getString("short_description"));
                    p.setFullDescription(rs.getString("full_description"));
                    p.setPrice(rs.getInt("price"));
                    p.setFeatured(rs.getBoolean("is_featured"));
                    p.setCreateAt(rs.getTimestamp("created_at").toString());
                    p.setUpdateAt(rs.getTimestamp("updated_at").toString());

                    p.setImages(new ArrayList<>()); // list ảnh rỗng
                    map.put(productId, p);
                }

                // add ảnh nếu có
                String imageUrl = rs.getString("image_url");
                if (imageUrl != null) {
                    p.getImages().add(imageUrl);
                }

                return null; // vì mình chỉ dùng để fill map
            }).list();

            return new ArrayList<>(map.values());
        });
    }

    public Product findById(int id) {
        return get().withHandle(h -> {

            String sql = """
                        SELECT p.id, p.name, p.category_id, p.short_description, p.full_description,
                               p.price, p.is_featured, p.created_at, p.updated_at,
                               p.avg_rating AS avgRating,
                               p.rating_count AS ratingCount,
                               pi.url AS image_url
                        FROM products p
                        LEFT JOIN product_images pi ON p.id = pi.product_id
                        WHERE p.id = :id
                    """;


            Map<Integer, Product> map = new LinkedHashMap<>();

            h.createQuery(sql)
                    .bind("id", id)
                    .map((rs, ctx) -> {
                        int productId = rs.getInt("id");

                        Product p = map.get(productId);
                        if (p == null) {
                            p = new Product();
                            p.setId(productId);
                            p.setName(rs.getString("name"));
                            p.setCategoryID(rs.getInt("category_id"));
                            p.setShortDescription(rs.getString("short_description"));
                            p.setFullDescription(rs.getString("full_description"));
                            p.setPrice(rs.getInt("price"));
                            p.setFeatured(rs.getBoolean("is_featured"));
                            p.setCreateAt(rs.getTimestamp("created_at").toString());
                            p.setUpdateAt(rs.getTimestamp("updated_at").toString());

                            p.setAvgRating(rs.getDouble("avgRating"));
                            p.setRatingCount(rs.getInt("ratingCount"));

                            p.setImages(new ArrayList<>());
                            map.put(productId, p);
                        }


                        String imageUrl = rs.getString("image_url");
                        if (imageUrl != null) {
                            p.getImages().add(imageUrl);
                        }

                        return null;
                    }).list();

            return map.values().stream().findFirst().orElse(null);
        });
    }

    public List<Product> getLatestProducts(int limit) {
        return get().withHandle(h -> {

            String sql = """
                        SELECT p.id, p.name, p.category_id, p.short_description, p.full_description,
                               p.price, p.is_featured, p.created_at, p.updated_at,
                               pi.url AS image_url
                        FROM (
                            SELECT *
                            FROM products
                            ORDER BY created_at DESC
                            LIMIT :limit
                        ) p
                        LEFT JOIN product_images pi ON p.id = pi.product_id
                        ORDER BY p.created_at DESC, p.id DESC
                    """;

            Map<Integer, Product> map = new LinkedHashMap<>();

            h.createQuery(sql)
                    .bind("limit", limit)
                    .map((rs, ctx) -> {

                        int productId = rs.getInt("id");

                        Product p = map.get(productId);
                        if (p == null) {
                            p = new Product();
                            p.setId(productId);
                            p.setName(rs.getString("name"));
                            p.setCategoryID(rs.getInt("category_id"));
                            p.setShortDescription(rs.getString("short_description"));
                            p.setFullDescription(rs.getString("full_description"));
                            p.setPrice(rs.getInt("price"));
                            p.setFeatured(rs.getBoolean("is_featured"));

                            if (rs.getTimestamp("created_at") != null) {
                                p.setCreateAt(rs.getTimestamp("created_at").toString());
                            }
                            if (rs.getTimestamp("updated_at") != null) {
                                p.setUpdateAt(rs.getTimestamp("updated_at").toString());
                            }

                            p.setImages(new ArrayList<>());
                            map.put(productId, p);
                        }

                        String imageUrl = rs.getString("image_url");
                        if (imageUrl != null) {
                            p.getImages().add(imageUrl);
                        }

                        return null;
                    })
                    .list();

            return new ArrayList<>(map.values());
        });
    }

    public void updateRating(int productId, int rating) {
        get().useHandle(h ->
                h.createUpdate(
                                "UPDATE products " +
                                        "SET avg_rating = (avg_rating * rating_count + :rating) / (rating_count + 1), " +
                                        "rating_count = rating_count + 1 " +
                                        "WHERE id = :productId"
                        )
                        .bind("rating", rating)
                        .bind("productId", productId)
                        .execute()
        );
    }


}

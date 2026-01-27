package vn.dao;

import vn.model.Product;
import vn.model.User;

import java.util.*;

public class ProductDao extends BaseDao {
    static Map<Integer, Product> data = new HashMap<Integer, Product>();

    public List<Product> getListProduct() {
        return get().withHandle(h -> {

            String sql = """
                        SELECT p.id,
                               p.name,
                               p.category_id,
                               p.short_description,
                               p.full_description,
                               p.price,
                               p.is_featured,
                               p.created_at,
                               p.updated_at,
                               p.avg_rating,
                               p.rating_count,
                               pi.url AS image_url
                        FROM products p
                        LEFT JOIN product_images pi ON p.id = pi.product_id
                        ORDER BY p.id
                    """;

            Map<Integer, Product> map = new LinkedHashMap<>();

            h.createQuery(sql).map((rs, ctx) -> {
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

                    // ⭐ THÊM RATE
                    p.setAvgRating(rs.getFloat("avg_rating"));
                    p.setRatingCount(rs.getInt("rating_count"));

                    p.setImages(new ArrayList<>());
                    map.put(productId, p);
                }

                String imageUrl = rs.getString("image_url");
                if (imageUrl != null) {
                    p.getImages().add(imageUrl);
                }

                return null;
            }).list();

            return new ArrayList<>(map.values());
        });
    }


    public List<Product> getAllProducts() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, category_id as categoryID, " +
                                        "short_description as shortDescription, " +
                                        "full_description as fullDescription, " +
                                        "price, is_featured as featured, " +
                                        "created_at as createAt, updated_at as updateAt " +
                                        "FROM products ORDER BY created_at DESC"
                        )
                        .mapToBean(Product.class)
                        .list()
        );
    }

    public Product findById(int id) {
        return get().withHandle(h -> {

            String sql = """
                      SELECT p.id, p.name, p.category_id, p.short_description, p.full_description,
                                                         p.spec,
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
                            p.setSpec(rs.getString("spec"));


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

    public boolean addProduct(Product product) {
        try {
            get().useHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO products (name, category_id, short_description, " +
                                            "full_description, price, is_featured) " +
                                            "VALUES (:name, :categoryID, :shortDescription, " +
                                            ":fullDescription, :price, :featured)"
                            )
                            .bind("name", product.getName())
                            .bind("categoryID", product.getCategoryID())
                            .bind("shortDescription", product.getShortDescription())
                            .bind("fullDescription", product.getFullDescription())
                            .bind("price", product.getPrice())
                            .bind("featured", product.isFeatured())
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateProduct(Product product) {
        get().useHandle(h ->
                h.createUpdate(
                                "UPDATE products SET " +
                                        "name = :name, " +
                                        "category_id = :categoryID, " +
                                        "short_description = :shortDescription, " +
                                        "full_description = :fullDescription, " +
                                        "price = :price, " +
                                        "is_featured = :featured " +
                                        "WHERE id = :id"
                        )
                        .bind("name", product.getName())
                        .bind("categoryID", product.getCategoryID())
                        .bind("shortDescription", product.getShortDescription())
                        .bind("fullDescription", product.getFullDescription())
                        .bind("price", product.getPrice())
                        .bind("featured", product.isFeatured())
                        .bind("id", product.getId())
                        .execute()
        );
    }

    public void deleteProductById(int id) {
        get().useHandle(h ->
                h.createUpdate("DELETE FROM products WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public List<Product> filterProducts(String keyword, String category, String featured) {
        return get().withHandle(h -> {

            String sql = "SELECT id, name, category_id as categoryID, " +
                    "short_description as shortDescription, " +
                    "full_description as fullDescription, " +
                    "price, is_featured as featured, " +
                    "created_at as createAt, updated_at as updateAt " +
                    "FROM products WHERE 1=1 ";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += "AND (name LIKE :keyword " +
                        "OR short_description LIKE :keyword " +
                        "OR full_description LIKE :keyword) ";
            }

            if (category != null && !category.isEmpty()) {
                sql += "AND category_id = :category ";
            }

            if (featured != null && !featured.isEmpty()) {
                sql += "AND is_featured = :featured ";
            }

            sql += "ORDER BY created_at DESC";

            var query = h.createQuery(sql);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.bind("keyword", "%" + keyword.trim() + "%");
            }

            if (category != null && !category.isEmpty()) {
                query.bind("category", Integer.parseInt(category));
            }

            if (featured != null && !featured.isEmpty()) {
                query.bind("featured", Integer.parseInt(featured));
            }

            return query.mapToBean(Product.class).list();
        });
    }

    public List<Product> searchByName(String keyword) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, category_id as categoryID, " +
                                        "short_description as shortDescription, " +
                                        "full_description as fullDescription, " +
                                        "price, is_featured as featured, " +
                                        "created_at as createAt, updated_at as updateAt " +
                                        "FROM products WHERE name LIKE :keyword ORDER BY created_at DESC"
                        )
                        .bind("keyword", "%" + keyword + "%")
                        .mapToBean(Product.class)
                        .list()
        );
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

    public int getLastInsertId() {
        return get().withHandle(h ->
                h.createQuery("SELECT LAST_INSERT_ID()")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public List<Product> findBykeyWord(String keyword) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, category_id, short_description, full_description, price, is_featured, created_at, updated_at " +
                                        "FROM products " +
                                        "WHERE name LIKE :keyword"
                        )
                        .bind("keyword", "%" + keyword + "%")
                        .mapToBean(Product.class)
                        .list()
        );
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

    public List<Product> filterAjax(
            String keyword,
            Integer categoryId,
            Integer minPrice,
            Integer maxPrice,
            String sort,
            int page,
            int size
    ) {
        int offset = (page - 1) * size;

        return get().withHandle(h -> {

            StringBuilder sql = new StringBuilder("""
            SELECT
                p.id,
                p.name,
                p.category_id AS categoryID,
                p.short_description AS shortDescription,
                p.full_description AS fullDescription,
                p.price,
                p.is_featured AS featured,
                p.created_at AS createAt,
                p.updated_at AS updateAt,
                p.avg_rating AS avgRating,
                p.rating_count AS ratingCount,
                pi.url AS image_url
            FROM products p
            LEFT JOIN product_images pi ON p.id = pi.product_id
            WHERE 1=1
        """);

            if (keyword != null && !keyword.isBlank()) {
                sql.append("""
                AND (p.name LIKE :kw
                     OR p.short_description LIKE :kw
                     OR p.full_description LIKE :kw)
            """);
            }

            if (categoryId != null) {
                sql.append(" AND p.category_id = :categoryId ");
            }

            if (minPrice != null) {
                sql.append(" AND p.price >= :minPrice ");
            }

            if (maxPrice != null) {
                sql.append(" AND p.price <= :maxPrice ");
            }

            sql.append(" GROUP BY p.id ");

            if ("asc".equals(sort)) {
                sql.append(" ORDER BY p.price ASC ");
            } else if ("desc".equals(sort)) {
                sql.append(" ORDER BY p.price DESC ");
            } else if ("new".equals(sort)) {
                sql.append(" ORDER BY p.created_at DESC ");
            } else {
                sql.append(" ORDER BY p.id DESC ");
            }

            // ✅ LIMIT PHẢI Ở CUỐI
            sql.append(" LIMIT :size OFFSET :offset ");

            var query = h.createQuery(sql.toString());

            if (keyword != null && !keyword.isBlank())
                query.bind("kw", "%" + keyword.trim() + "%");
            if (categoryId != null)
                query.bind("categoryId", categoryId);
            if (minPrice != null)
                query.bind("minPrice", minPrice);
            if (maxPrice != null)
                query.bind("maxPrice", maxPrice);

            query.bind("size", size);
            query.bind("offset", offset);

            Map<Integer, Product> map = new LinkedHashMap<>();

            query.map((rs, ctx) -> {
                int id = rs.getInt("id");
                Product p = map.get(id);

                if (p == null) {
                    p = new Product();
                    p.setId(id);
                    p.setName(rs.getString("name"));
                    p.setCategoryID(rs.getInt("categoryID"));
                    p.setShortDescription(rs.getString("shortDescription"));
                    p.setFullDescription(rs.getString("fullDescription"));
                    p.setPrice(rs.getInt("price"));
                    p.setFeatured(rs.getBoolean("featured"));
                    p.setAvgRating(rs.getDouble("avgRating"));
                    p.setRatingCount(rs.getInt("ratingCount"));
                    p.setCreateAt(rs.getTimestamp("createAt").toString());
                    p.setUpdateAt(rs.getTimestamp("updateAt").toString());
                    p.setImages(new ArrayList<>());
                    map.put(id, p);
                }

                String img = rs.getString("image_url");
                if (img != null) p.getImages().add(img);

                return null;
            }).list();

            return new ArrayList<>(map.values());
        });
    }

    public int countFilterAjax(
            String keyword,
            Integer categoryId,
            Integer minPrice,
            Integer maxPrice
    ) {
        return get().withHandle(h -> {

            StringBuilder sql = new StringBuilder("""
            SELECT COUNT(DISTINCT p.id)
            FROM products p
            WHERE 1=1
        """);

            if (keyword != null && !keyword.isBlank()) {
                sql.append("""
                AND (p.name LIKE :kw
                     OR p.short_description LIKE :kw
                     OR p.full_description LIKE :kw)
            """);
            }

            if (categoryId != null) sql.append(" AND p.category_id = :categoryId ");
            if (minPrice != null) sql.append(" AND p.price >= :minPrice ");
            if (maxPrice != null) sql.append(" AND p.price <= :maxPrice ");

            var q = h.createQuery(sql.toString());

            if (keyword != null && !keyword.isBlank())
                q.bind("kw", "%" + keyword.trim() + "%");
            if (categoryId != null)
                q.bind("categoryId", categoryId);
            if (minPrice != null)
                q.bind("minPrice", minPrice);
            if (maxPrice != null)
                q.bind("maxPrice", maxPrice);

            return q.mapTo(Integer.class).one();
        });
    }



}






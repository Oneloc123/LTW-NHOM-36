package vn.dao;

import vn.model.Image;

import java.util.List;

public class ImageDao extends BaseDao {

    public List<Image> getImagesByProductId(int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, url, product_id as productId " +
                                        "FROM product_images WHERE product_id = :productId"
                        )
                        .bind("productId", productId)
                        .mapToBean(Image.class)
                        .list()
        );
    }

    public List<String> getImageUrlsByProductId(int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT url FROM product_images WHERE product_id = :productId"
                        )
                        .bind("productId", productId)
                        .mapTo(String.class)
                        .list()
        );
    }

    public String getFirstImageUrl(int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT url FROM product_images WHERE product_id = :productId LIMIT 1"
                        )
                        .bind("productId", productId)
                        .mapTo(String.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean addImage(Image image) {
        try {
            get().useHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO product_images (url, product_id) VALUES (:url, :productId)"
                            )
                            .bind("url", image.getUrl())
                            .bind("productId", image.getProductId())
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void deleteImagesByProductId(int productId) {
        get().useHandle(h ->
                h.createUpdate("DELETE FROM product_images WHERE product_id = :productId")
                        .bind("productId", productId)
                        .execute()
        );
    }

    public void deleteImageById(int id) {
        get().useHandle(h ->
                h.createUpdate("DELETE FROM product_images WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    // Thêm nhiều ảnh cùng lúc
    public void addMultipleImages(List<Image> images) {
        get().useHandle(h -> {
            var batch = h.prepareBatch(
                    "INSERT INTO product_images (url, product_id) VALUES (:url, :productId)"
            );

            for (Image img : images) {
                batch.bind("url", img.getUrl())
                        .bind("productId", img.getProductId())
                        .add();
            }

            batch.execute();
        });
    }
}
package vn.dao;

import vn.model.Image;

import java.util.List;

public class ImageDao extends BaseDao{

    public List<Image> getImagesByProductId(int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, url, product_id " +
                                        "FROM product_images " +
                                        "WHERE product_id = :productId"
                        )
                        .bind("productId", productId)
                        .mapToBean(Image.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        ImageDao imageDao = new ImageDao();
        List<Image> list = imageDao.getImagesByProductId(1);
        for(Image image:list){
            System.out.println(image.getId());
        }
    }

}

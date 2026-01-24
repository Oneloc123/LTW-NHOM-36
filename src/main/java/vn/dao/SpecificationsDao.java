package vn.dao;

import vn.model.ProductAttribute;

import java.util.List;

public class SpecificationsDao extends BaseDao{

    public List<ProductAttribute> getByProductId(int productId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, product_id, name, value " +
                                        "FROM product_attributes " +
                                        "WHERE product_id = :productId"
                        )
                        .bind("productId", productId)
                        .mapToBean(ProductAttribute.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        SpecificationsDao specificationsDao = new SpecificationsDao();
        for (ProductAttribute pr : specificationsDao.getByProductId(1)) {
            System.out.println(pr.getName()+"\t "+pr.getValue());
        }
    }

}

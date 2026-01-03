package vn.dao;

import vn.model.Product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProductDao extends BaseDao{
    static Map<Integer,Product> data=new HashMap<Integer,Product>();
    static {
//        data.put(1,new Product(1,"Đèn Gundam LED phát sáng","https://i.etsystatic.com/45671320/r/il/124aa2/6574637043/il_fullxfull.6574637043_a9b5.jpg?utm_source=chatgpt.com",100000));
//        data.put(2,new Product(2,"Skull Speaker","https://m.media-amazon.com/images/I/61Ta8laLvhL.jpg?utm_source=chatgpt.com",200000));
//        data.put(3,new Product(3,"Humanoid Robot Toy","https://cdn11.bigcommerce.com/s-76o5u/images/stencil/1280x1280/products/76/828/ROBOTISMINI_THUM_BANNER_Ver1520_1__85710.1434949066.jpg?c=2&utm_source=chatgpt.com",250000));
//        data.put(4,new Product(4,"Đèn bàn Cyberpunk Neon RGB","https://m.media-amazon.com/images/I/911P29mIXTL._UF350%2C350_QL80_.jpg?utm_source=chatgpt.com",1000000));
//        data.put(5,new Product(5,"Máy chiếu mini hình TV retro","https://m.media-amazon.com/images/I/61BmY0i3jAL._AC_UF894%2C1000_QL80_.jpg?utm_source=chatgpt.com",40000));
//        data.put(6,new Product(6,"Đèn mặt nạ Oni Nhật Bản","https://hirosarts.com/wp-content/uploads/2024/06/japanese-demon-mask-resin-lamp-ver-3-4.jpg?utm_source=chatgpt.com",400000));
//        data.put(7,new Product(7,"Quả cầu plasma","https://m.media-amazon.com/images/I/71dcztrsqqL.jpg?utm_source=chatgpt.com",500000));
//        data.put(8,new Product(8,"Loa đèn lửa Flame Bluetooth Speaker","https://m.media-amazon.com/images/I/71cIKLE5TgL.jpg?utm_source=chatgpt.com",980000));
    }




    /* getListProduct
    *   - Lấy dữ liệu từ DataBase ra sử dụng
    * */
//    public List<Product> getListProduct() {
//    return new ArrayList<>(data.values());
//    }


    public List<Product> getListProduct() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, category_id, short_description, full_description, " +
                                        "price, is_featured, created_at, updated_at " +
                                        "FROM products"
                        )
                        .mapToBean(Product.class)
                        .list()
        );
    }


    public Product findById(int id) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, category_id, short_description, full_description, " +
                                        "price, is_featured, created_at, updated_at " +
                                        "FROM products " +
                                        "WHERE id = :id"
                        )
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        List<Product> list=dao.getListProduct();
        for(Product p:list){
            System.out.println(p.getId());
        }
        System.out.println(dao.findById(1).getName());
    }

}

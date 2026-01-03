package vn.dao;

import vn.model.Category;

import java.util.List;

public class CategoryDao extends BaseDao {

    public List<Category> getList() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, description, image_url " +
                                        "FROM categories"
                        )
                        .mapToBean(Category.class)
                        .list()
        );
    }

    public static void main(String[] args) {
        CategoryDao categoryDao = new CategoryDao();
        List<Category> list = categoryDao.getList();
        for(Category category:list){
            System.out.println(category.getName());
        }
    }

}

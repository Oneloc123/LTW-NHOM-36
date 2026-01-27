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

    public List<Category> getAllCategories() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, description, image_url as imageURL " +
                                        "FROM categories ORDER BY name ASC"
                        )
                        .mapToBean(Category.class)
                        .list()
        );
    }

    public Category getCategoryById(int id) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, description, image_url as imageURL " +
                                        "FROM categories WHERE id = :id"
                        )
                        .bind("id", id)
                        .mapToBean(Category.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public Category getCategoryByName(String name) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, description, image_url as imageURL " +
                                        "FROM categories WHERE name = :name"
                        )
                        .bind("name", name)
                        .mapToBean(Category.class)
                        .findOne()
                        .orElse(null)
        );
    }

    public boolean addCategory(Category category) {
        try {
            get().useHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO categories (name, description, image_url) " +
                                            "VALUES (:name, :description, :imageURL)"
                            )
                            .bind("name", category.getName())
                            .bind("description", category.getDescription())
                            .bind("imageURL", category.getImageURL())
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateCategory(Category category) {
        get().useHandle(h ->
                h.createUpdate(
                                "UPDATE categories SET " +
                                        "name = :name, " +
                                        "description = :description, " +
                                        "image_url = :imageURL " +
                                        "WHERE id = :id"
                        )
                        .bind("name", category.getName())
                        .bind("description", category.getDescription())
                        .bind("imageURL", category.getImageURL())
                        .bind("id", category.getId())
                        .execute()
        );
    }

    public void deleteCategoryById(int id) {
        get().useHandle(h ->
                h.createUpdate("DELETE FROM categories WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public List<Category> searchByName(String keyword) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, name, description, image_url as imageURL " +
                                        "FROM categories WHERE name LIKE :keyword " +
                                        "OR description LIKE :keyword " +
                                        "ORDER BY name ASC"
                        )
                        .bind("keyword", "%" + keyword + "%")
                        .mapToBean(Category.class)
                        .list()
        );
    }

    public boolean existsByName(String name) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM categories WHERE name = :name"
                        )
                        .bind("name", name)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public boolean existsByNameExcludingId(String name, int excludeId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM categories WHERE name = :name AND id != :excludeId"
                        )
                        .bind("name", name)
                        .bind("excludeId", excludeId)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    public int countProductsInCategory(int categoryId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM products WHERE category_id = :categoryId"
                        )
                        .bind("categoryId", categoryId)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    public int getLastInsertId() {
        return get().withHandle(h ->
                h.createQuery("SELECT LAST_INSERT_ID()")
                        .mapTo(Integer.class)
                        .one()
        );
    }

}
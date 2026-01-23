package vn.services;

import vn.dao.CategoryDao;
import vn.model.Category;

import java.util.List;

public class CategoryService {

    private CategoryDao categoryDao = new CategoryDao();

    public List<Category> getAllCategories() {
        return categoryDao.getAllCategories();
    }

    public Category getCategoryById(int id) {
        return categoryDao.getCategoryById(id);
    }

    public Category getCategoryByName(String name) {
        return categoryDao.getCategoryByName(name);
    }

    public boolean addCategory(Category category) {
        // Kiểm tra tên danh mục đã tồn tại chưa
        if (categoryDao.existsByName(category.getName())) {
            return false; // Tên danh mục đã tồn tại
        }

        boolean success = categoryDao.addCategory(category);
        if (success) {
            int categoryId = categoryDao.getLastInsertId();
            category.setId(categoryId);
        }
        return success;
    }

    public boolean updateCategory(Category category) {
        // Kiểm tra tên danh mục đã tồn tại (trừ chính nó)
        if (categoryDao.existsByNameExcludingId(category.getName(), category.getId())) {
            return false; // Tên danh mục đã tồn tại
        }

        categoryDao.updateCategory(category);
        return true;
    }

    public void deleteCategoryById(int id) {
        categoryDao.deleteCategoryById(id);
    }

    public List<Category> searchByName(String keyword) {
        return categoryDao.searchByName(keyword);
    }

    public int countProductsInCategory(int categoryId) {
        return categoryDao.countProductsInCategory(categoryId);
    }

    public boolean canDeleteCategory(int categoryId) {
        int productCount = countProductsInCategory(categoryId);
        return productCount == 0;
    }
}
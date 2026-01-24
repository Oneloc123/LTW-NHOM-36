package vn.services;

import vn.dao.ImageDao;
import vn.dao.ProductDao;
import vn.model.Image;
import vn.model.Product;

import java.util.List;

public class ProductService {
    ProductDao productDao = new ProductDao();
    private ImageDao imageDao = new ImageDao();

    public List<Product> getListProduct() {
        return productDao.getListProduct();
    }

    public List<Product> getNewArrivalsList() {
        return productDao.getLatestProducts(4);
    }

    public List<Product> filterProduct(String keyword) {
        return productDao.findBykeyWord(keyword);
    }

    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }

    public Product getProductById(int id) {
        return productDao.findById(id);
    }

    public boolean addProduct(Product product) {
        boolean success = productDao.addProduct(product);
        if (success) {
            // Lấy ID sản phẩm vừa thêm
            int productId = productDao.getLastInsertId();
            product.setId(productId);
        }
        return success;
    }

    // Phương thức thêm sản phẩm cùng với ảnh
    public boolean addProductWithImages(Product product, List<String> imageUrls) {
        boolean productAdded = addProduct(product);

        if (productAdded && imageUrls != null && !imageUrls.isEmpty()) {
            for (String url : imageUrls) {
                if (url != null && !url.trim().isEmpty()) {
                    Image img = new Image();
                    img.setProductId(product.getId());
                    img.setUrl(url.trim());
                    imageDao.addImage(img);
                }
            }
        }

        return productAdded;
    }

    public List<Product> filterAjax(
            String keyword,
            Integer categoryId,
            Integer minPrice,
            Integer maxPrice,
            String sort
    ){        return productDao.filterAjax(keyword, categoryId, minPrice, maxPrice, sort);
    }

    public void updateProduct(Product product) {
        productDao.updateProduct(product);
    }

    public void deleteProductById(int id) {
        // Xóa ảnh trước
        imageDao.deleteImagesByProductId(id);
        // Xóa sản phẩm
        productDao.deleteProductById(id);
    }

    public List<Product> filterProducts(String keyword, String category, String featured) {
        return productDao.filterProducts(keyword, category, featured);
    }

    public List<Product> searchByName(String keyword) {
        return productDao.searchByName(keyword);
    }

    public String getFirstImageUrl(int productId) {
        return imageDao.getFirstImageUrl(productId);
    }
}
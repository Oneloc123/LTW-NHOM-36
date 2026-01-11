package vn.services;

import vn.dao.ProductDao;
import vn.model.Product;

import java.util.List;

public class ProductService {
    ProductDao pdao = new ProductDao();

    public List<Product> getListProduct() {
    return pdao.getListProduct();
    }

    public Product getProductById(int id) {
        return pdao.findById(id);
    }
}
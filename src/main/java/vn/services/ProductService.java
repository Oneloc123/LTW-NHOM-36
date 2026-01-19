package vn.services;

import vn.dao.ProductDao;
import vn.model.Product;

import java.util.List;

public class ProductService {
    ProductDao pdao = new ProductDao();

    public List<Product> getListProduct() {
    return pdao.getListProduct();
    }
    public List<Product> getNewArrivalsList() {return pdao.getLatestProducts(4);}
    public Product getProductById(int id) {
        return pdao.findById(id);
    }
}
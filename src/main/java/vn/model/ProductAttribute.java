package vn.model;

import java.io.Serializable;

public class ProductAttribute implements Serializable {

    private int id;
    private int productId;
    private String name;
    private String value;

    public ProductAttribute(String value, String name, int productId, int id) {
        this.value = value;
        this.name = name;
        this.productId = productId;
        this.id = id;
    }

    public ProductAttribute(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}

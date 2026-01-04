package vn.dao;

import vn.model.FavoriteProduct;

import java.util.ArrayList;
import java.util.List;

public class FavoriteDao {

    // DEMO – không DB
    public List<FavoriteProduct> getAll() {
        List<FavoriteProduct> list = new ArrayList<>();

        list.add(new FavoriteProduct(
                1,
                "Camera Canon R5",
                "assets/img/canon-r5.jpg",
                500000,
                "AVAILABLE"
        ));

        list.add(new FavoriteProduct(
                2,
                "Sony A7 III",
                "assets/img/sony-a7.jpg",
                450000,
                "RENTED"
        ));

        list.add(new FavoriteProduct(
                3,
                "Nikon Z6",
                "assets/img/nikon-z6.jpg",
                400000,
                "AVAILABLE"
        ));

        list.add(new FavoriteProduct(
                4,
                "Fujifilm XT4",
                "assets/img/fuji-xt4.jpg",
                420000,
                "AVAILABLE"
        ));

        return list;
    }
}

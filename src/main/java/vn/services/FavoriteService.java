package vn.services;

import vn.dao.FavoriteDao;
import vn.model.FavoriteProduct;

import java.util.List;
import java.util.stream.Collectors;

public class FavoriteService {

    private final FavoriteDao dao = new FavoriteDao();

    public List<FavoriteProduct> filter(String keyword, String status) {
        List<FavoriteProduct> list = dao.getAll();

        if (keyword != null && !keyword.isEmpty()) {
            list = list.stream()
                    .filter(p -> p.getProductName().toLowerCase()
                            .contains(keyword.toLowerCase()))
                    .collect(Collectors.toList());
        }

        if (status != null && !status.isEmpty()) {
            list = list.stream()
                    .filter(p -> p.getStatus().equalsIgnoreCase(status))
                    .collect(Collectors.toList());
        }

        return list;
    }
}

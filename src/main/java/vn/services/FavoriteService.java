package vn.services;

import vn.dao.FavoriteDao;
import vn.model.FavoriteProduct;

import java.util.List;

public class FavoriteService {
    FavoriteDao dao = new FavoriteDao();

    public List<FavoriteProduct> getFavorites(
            int userId,
            String keyword,
            String status,
            int page,
            int pageSize
    ) {
        return dao.getFavorites(userId, keyword, status, page, pageSize);
    }

    public int countFavorites(int userId, String keyword, String status) {
        return dao.countFavorites(userId, keyword, status);
    }
}

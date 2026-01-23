package vn.services;

import vn.dao.BannerDao;
import vn.model.Banner;

import java.util.List;

public class BannerService {
    BannerDao bannerDao = new BannerDao();

    public List<Banner> getBanner() {
        return bannerDao.getList();

    }
    public List<Banner> getAllBanners() {
        return bannerDao.getAllBanners();
    }

    public Banner getBannerById(int id) {
        return bannerDao.getBannerById(id);
    }

    public boolean addBanner(Banner banner) {
        boolean success = bannerDao.addBanner(banner);
        if (success) {
            int bannerId = bannerDao.getLastInsertId();
            banner.setId(bannerId);
        }
        return success;
    }

    public void updateBanner(Banner banner) {
        bannerDao.updateBanner(banner);
    }

    public void deleteBannerById(int id) {
        bannerDao.deleteBannerById(id);
    }

    public List<Banner> filterBanners(String keyword, String status) {
        return bannerDao.filterBanners(keyword, status);
    }

    public List<Banner> searchByTitle(String keyword) {
        return bannerDao.searchByTitle(keyword);
    }

    // Lấy banners đang hoạt động và trong khoảng thời gian hiệu lực
    public List<Banner> getActiveBanners() {
        return bannerDao.getActiveBanners();
    }

}

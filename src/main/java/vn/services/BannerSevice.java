package vn.services;

import vn.dao.BannerDao;
import vn.model.Banner;

import java.util.List;

public class BannerSevice {
    BannerDao bdao = new BannerDao();

    public List<Banner> getBanner()
    {
        return bdao.banners;

    }
}

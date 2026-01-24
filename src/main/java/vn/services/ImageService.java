package vn.services;

import vn.dao.ImageDao;
import vn.model.Image;

import java.util.List;

public class ImageService {

    private ImageDao imageDao = new ImageDao();

    public List<Image> getImagesByProductId(int productId) {
        return imageDao.getImagesByProductId(productId);
    }

    public List<String> getImageUrlsByProductId(int productId) {
        return imageDao.getImageUrlsByProductId(productId);
    }

    public String getFirstImageUrl(int productId) {
        return imageDao.getFirstImageUrl(productId);
    }

    public boolean addImage(Image image) {
        return imageDao.addImage(image);
    }

    public void deleteImagesByProductId(int productId) {
        imageDao.deleteImagesByProductId(productId);
    }

    public void deleteImageById(int id) {
        imageDao.deleteImageById(id);
    }
}
package vn.services;

import vn.dao.ProductDao;
import vn.dao.ReviewDao;
import vn.model.Review;

import java.util.List;

public class ReviewService {

    private final ReviewDao reviewDAO = new ReviewDao();
    private final ProductDao productDAO = new ProductDao();

    public boolean rateProduct(Review review) {
        if (reviewDAO.existsByUserAndProduct(
                review.getUserId(),
                review.getProductId()
        )) {
            return false;
        }

        reviewDAO.insert(review);
        productDAO.updateRating(review.getProductId(), review.getRating());
        return true;
    }
    public List<Review> findByProductId(int productId){
        return  reviewDAO.findByProductId(productId);
    }
}

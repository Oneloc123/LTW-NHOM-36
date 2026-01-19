package vn.services;

import vn.dao.BlogDao;
import vn.model.Blog;

import java.util.List;

public class BlogService {
 BlogDao blogDao;
    public BlogService() {
        this.blogDao = new BlogDao();
    }
    public Blog getBlogById(int blogId){
        return blogDao.getBlogById(blogId);
    }
    public List<Blog> getAllBlog(){
        return blogDao.getAllBlogs();
    }
    public List<Blog> getFeature(){return blogDao.getFeaturedBlogs();}
}

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
    public List<Blog> getAllBlogs() {
        return blogDao.getAllBlogs();
    }
    public boolean addBlog(Blog blog) {
        boolean success = blogDao.addBlog(blog);
        if (success) {
            int blogId = blogDao.getLastInsertId();
            blog.setId(blogId);
        }
        return success;
    }
    public boolean updateBlog(Blog blog) {
        blogDao.updateBlog(blog);
        return true;
    }
    public void deleteBlogById(int id) {
        blogDao.deleteBlogById(id);
    }
    public List<Blog> searchByTitle(String keyword) {
        return blogDao.searchByTitle(keyword);
    }
    public List<Blog> getLatestBlogs(int limit) {
        return blogDao.getLatestBlogs(limit);
    }
}
package vn.dao;

import vn.model.Blog;


import java.util.List;

public class BlogDao extends BaseDao {

    public List<Blog> getAllBlogs() {

        String sql = "SELECT * FROM blogs ORDER BY created_at DESC";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            Blog b = new Blog();
                            b.setId(rs.getInt("id"));
                            b.setTitle(rs.getString("title"));
                            b.setThumbnail(rs.getString("thumbnail"));
                            b.setSummary(rs.getString("summary"));
                            b.setAuthor(rs.getString("author"));
                            b.setCreatedAt(rs.getString("created_at"));
                            return b;
                        })
                        .list()
        );
    }


    public Blog getBlogById(int id) {

        String sql = "SELECT * FROM blogs WHERE id = :id";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            Blog b = new Blog();
                            b.setId(rs.getInt("id"));
                            b.setTitle(rs.getString("title"));
                            b.setThumbnail(rs.getString("thumbnail"));
                            b.setSummary(rs.getString("summary"));
                            b.setContent(rs.getString("content"));
                            b.setAuthor(rs.getString("author"));
                            b.setCreatedAt(rs.getString("created_at"));
                            return b;
                        })
                        .findOne()
                        .orElse(null)
        );
    }
    public List<Blog> getFeaturedBlogs() {
        String sql = "SELECT * FROM blogs ORDER BY created_at DESC LIMIT 3";

        return get().withHandle(handle ->
                handle.createQuery(sql)
                        .map((rs, ctx) -> {
                            Blog b = new Blog();
                            b.setId(rs.getInt("id"));
                            b.setTitle(rs.getString("title"));
                            b.setThumbnail(rs.getString("thumbnail"));
                            b.setCreatedAt(rs.getString("created_at"));
                            return b;
                        })
                        .list()
        );
    }


}

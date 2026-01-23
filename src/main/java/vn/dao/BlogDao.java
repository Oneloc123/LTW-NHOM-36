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
    public boolean addBlog(Blog blog) {
        try {
            get().useHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO blogs (title, thumbnail, summary, " +
                                            "content, author, created_at) " +
                                            "VALUES (:title, :thumbnail, :summary, " +
                                            ":content, :author, :createdAt)"
                            )
                            .bind("title", blog.getTitle())
                            .bind("thumbnail", blog.getThumbnail())
                            .bind("summary", blog.getSummary())
                            .bind("content", blog.getContent())
                            .bind("author", blog.getAuthor())
                            .bind("createdAt", blog.getCreatedAt())
                            .execute()
            );
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateBlog(Blog blog) {
        get().useHandle(h ->
                h.createUpdate(
                                "UPDATE blogs SET " +
                                        "title = :title, " +
                                        "thumbnail = :thumbnail, " +
                                        "summary = :summary, " +
                                        "content = :content, " +
                                        "author = :author " +
                                        "WHERE id = :id"
                        )
                        .bind("title", blog.getTitle())
                        .bind("thumbnail", blog.getThumbnail())
                        .bind("summary", blog.getSummary())
                        .bind("content", blog.getContent())
                        .bind("author", blog.getAuthor())
                        .bind("id", blog.getId())
                        .execute()
        );
    }

    public void deleteBlogById(int id) {
        get().useHandle(h ->
                h.createUpdate("DELETE FROM blogs WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public List<Blog> searchByTitle(String keyword) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, title, thumbnail, summary, " +
                                        "content, author, created_at as createdAt " +
                                        "FROM blogs WHERE title LIKE :keyword " +
                                        "OR summary LIKE :keyword " +
                                        "OR content LIKE :keyword " +
                                        "ORDER BY created_at DESC"
                        )
                        .bind("keyword", "%" + keyword + "%")
                        .mapToBean(Blog.class)
                        .list()
        );
    }

    public List<Blog> getLatestBlogs(int limit) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, title, thumbnail, summary, " +
                                        "content, author, created_at as createdAt " +
                                        "FROM blogs ORDER BY created_at DESC LIMIT :limit"
                        )
                        .bind("limit", limit)
                        .mapToBean(Blog.class)
                        .list()
        );
    }

    public int getLastInsertId() {
        return get().withHandle(h ->
                h.createQuery("SELECT LAST_INSERT_ID()")
                        .mapTo(Integer.class)
                        .one()
        );
    }

}

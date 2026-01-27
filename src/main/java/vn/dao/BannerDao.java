package vn.dao;

import vn.model.Banner;
import org.jdbi.v3.core.mapper.reflect.BeanMapper;
import org.jdbi.v3.core.result.ResultBearing;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import java.util.*;

public class BannerDao extends BaseDao{

    public List<Banner> getList() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, title, image_url, link_url, alt_text, " +
                                        "start_date, end_date, sort_order, status, created_at, updated_at " +
                                        "FROM banners " +
                                        "ORDER BY sort_order ASC"
                        )
                        .mapToBean(Banner.class)
                        .list()
        );
    }
    public List<Banner> getAllBanners() {
        return get().withHandle(h -> {
            return h.createQuery(
                            "SELECT id, title, image_url as imageURL, link_url as linkURL, " +
                                    "alt_text as altText, start_date as startDate, end_date as endDate, " +
                                    "sort_order as sortOrder, status, created_at as createAt, " +
                                    "updated_at as updateAt " +
                                    "FROM banners ORDER BY sort_order ASC, created_at DESC"
                    )
                    .registerRowMapper(BeanMapper.factory(Banner.class))
                    .map((rs, ctx) -> {
                        Banner banner = new Banner();
                        banner.setId(rs.getInt("id"));
                        banner.setTitle(rs.getString("title"));
                        banner.setImageURL(rs.getString("imageURL"));
                        banner.setLinkURL(rs.getString("linkURL"));
                        banner.setAltText(rs.getString("altText"));

                        // Map LocalDate
                        if (rs.getDate("startDate") != null) {
                            banner.setStartDate(rs.getDate("startDate").toLocalDate());
                        }
                        if (rs.getDate("endDate") != null) {
                            banner.setEndDate(rs.getDate("endDate").toLocalDate());
                        }

                        banner.setSortOrder(rs.getInt("sortOrder"));
                        banner.setStatus(rs.getInt("status"));

                        // Map LocalDateTime
                        if (rs.getTimestamp("createAt") != null) {
                            banner.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                        }
                        if (rs.getTimestamp("updateAt") != null) {
                            banner.setUpdateAt(rs.getTimestamp("updateAt").toLocalDateTime());
                        }

                        return banner;
                    })
                    .list();
        });
    }

    public Banner getBannerById(int id) {
        return get().withHandle(h -> {
            return h.createQuery(
                            "SELECT id, title, image_url as imageURL, link_url as linkURL, " +
                                    "alt_text as altText, start_date as startDate, end_date as endDate, " +
                                    "sort_order as sortOrder, status, created_at as createAt, " +
                                    "updated_at as updateAt " +
                                    "FROM banners WHERE id = :id"
                    )
                    .bind("id", id)
                    .registerRowMapper(BeanMapper.factory(Banner.class))
                    .map((rs, ctx) -> {
                        Banner banner = new Banner();
                        banner.setId(rs.getInt("id"));
                        banner.setTitle(rs.getString("title"));
                        banner.setImageURL(rs.getString("imageURL"));
                        banner.setLinkURL(rs.getString("linkURL"));
                        banner.setAltText(rs.getString("altText"));

                        if (rs.getDate("startDate") != null) {
                            banner.setStartDate(rs.getDate("startDate").toLocalDate());
                        }
                        if (rs.getDate("endDate") != null) {
                            banner.setEndDate(rs.getDate("endDate").toLocalDate());
                        }

                        banner.setSortOrder(rs.getInt("sortOrder"));
                        banner.setStatus(rs.getInt("status"));

                        if (rs.getTimestamp("createAt") != null) {
                            banner.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                        }
                        if (rs.getTimestamp("updateAt") != null) {
                            banner.setUpdateAt(rs.getTimestamp("updateAt").toLocalDateTime());
                        }

                        return banner;
                    })
                    .findOne()
                    .orElse(null);
        });
    }

    public boolean addBanner(Banner banner) {
        try {
            get().useHandle(h -> {
                h.createUpdate(
                                "INSERT INTO banners (title, image_url, link_url, alt_text, " +
                                        "start_date, end_date, sort_order, status) " +
                                        "VALUES (:title, :imageURL, :linkURL, :altText, " +
                                        ":startDate, :endDate, :sortOrder, :status)"
                        )
                        .bind("title", banner.getTitle())
                        .bind("imageURL", banner.getImageURL())
                        .bind("linkURL", banner.getLinkURL())
                        .bind("altText", banner.getAltText())
                        .bind("startDate", banner.getStartDate())
                        .bind("endDate", banner.getEndDate())
                        .bind("sortOrder", banner.getSortOrder())
                        .bind("status", banner.getStatus())
                        .execute();
            });
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateBanner(Banner banner) {
        get().useHandle(h -> {
            h.createUpdate(
                            "UPDATE banners SET " +
                                    "title = :title, " +
                                    "image_url = :imageURL, " +
                                    "link_url = :linkURL, " +
                                    "alt_text = :altText, " +
                                    "start_date = :startDate, " +
                                    "end_date = :endDate, " +
                                    "sort_order = :sortOrder, " +
                                    "status = :status " +
                                    "WHERE id = :id"
                    )
                    .bind("title", banner.getTitle())
                    .bind("imageURL", banner.getImageURL())
                    .bind("linkURL", banner.getLinkURL())
                    .bind("altText", banner.getAltText())
                    .bind("startDate", banner.getStartDate())
                    .bind("endDate", banner.getEndDate())
                    .bind("sortOrder", banner.getSortOrder())
                    .bind("status", banner.getStatus())
                    .bind("id", banner.getId())
                    .execute();
        });
    }

    public void deleteBannerById(int id) {
        get().useHandle(h -> {
            h.createUpdate("DELETE FROM banners WHERE id = :id")
                    .bind("id", id)
                    .execute();
        });
    }

    public List<Banner> filterBanners(String keyword, String status) {
        return get().withHandle(h -> {

            String sql = "SELECT id, title, image_url as imageURL, link_url as linkURL, " +
                    "alt_text as altText, start_date as startDate, end_date as endDate, " +
                    "sort_order as sortOrder, status, created_at as createAt, " +
                    "updated_at as updateAt " +
                    "FROM banners WHERE 1=1 ";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += "AND (title LIKE :keyword " +
                        "OR alt_text LIKE :keyword) ";
            }

            if (status != null && !status.isEmpty()) {
                sql += "AND status = :status ";
            }

            sql += "ORDER BY sort_order ASC, created_at DESC";

            var query = h.createQuery(sql);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.bind("keyword", "%" + keyword.trim() + "%");
            }

            if (status != null && !status.isEmpty()) {
                query.bind("status", Integer.parseInt(status));
            }

            return query
                    .registerRowMapper(BeanMapper.factory(Banner.class))
                    .map((rs, ctx) -> {
                        Banner banner = new Banner();
                        banner.setId(rs.getInt("id"));
                        banner.setTitle(rs.getString("title"));
                        banner.setImageURL(rs.getString("imageURL"));
                        banner.setLinkURL(rs.getString("linkURL"));
                        banner.setAltText(rs.getString("altText"));

                        if (rs.getDate("startDate") != null) {
                            banner.setStartDate(rs.getDate("startDate").toLocalDate());
                        }
                        if (rs.getDate("endDate") != null) {
                            banner.setEndDate(rs.getDate("endDate").toLocalDate());
                        }

                        banner.setSortOrder(rs.getInt("sortOrder"));
                        banner.setStatus(rs.getInt("status"));

                        if (rs.getTimestamp("createAt") != null) {
                            banner.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                        }
                        if (rs.getTimestamp("updateAt") != null) {
                            banner.setUpdateAt(rs.getTimestamp("updateAt").toLocalDateTime());
                        }

                        return banner;
                    })
                    .list();
        });
    }
    public List<Banner> searchByTitle(String keyword) {
        return get().withHandle(h -> {
            return h.createQuery(
                            "SELECT id, title, image_url as imageURL, link_url as linkURL, " +
                                    "alt_text as altText, start_date as startDate, end_date as endDate, " +
                                    "sort_order as sortOrder, status, created_at as createAt, " +
                                    "updated_at as updateAt " +
                                    "FROM banners " +
                                    "WHERE title LIKE :keyword " +
                                    "ORDER BY sort_order ASC, created_at DESC"
                    )
                    .bind("keyword", "%" + keyword + "%")
                    .registerRowMapper(BeanMapper.factory(Banner.class))
                    .map((rs, ctx) -> {
                        Banner banner = new Banner();
                        banner.setId(rs.getInt("id"));
                        banner.setTitle(rs.getString("title"));
                        banner.setImageURL(rs.getString("imageURL"));
                        banner.setLinkURL(rs.getString("linkURL"));
                        banner.setAltText(rs.getString("altText"));

                        // Map LocalDate
                        if (rs.getDate("startDate") != null) {
                            banner.setStartDate(rs.getDate("startDate").toLocalDate());
                        }
                        if (rs.getDate("endDate") != null) {
                            banner.setEndDate(rs.getDate("endDate").toLocalDate());
                        }

                        banner.setSortOrder(rs.getInt("sortOrder"));
                        banner.setStatus(rs.getInt("status"));

                        // Map LocalDateTime
                        if (rs.getTimestamp("createAt") != null) {
                            banner.setCreateAt(rs.getTimestamp("createAt").toLocalDateTime());
                        }
                        if (rs.getTimestamp("updateAt") != null) {
                            banner.setUpdateAt(rs.getTimestamp("updateAt").toLocalDateTime());
                        }

                        return banner;
                    })
                    .list();
        });
    }

    public int getLastInsertId() {
        return get().withHandle(h ->
                h.createQuery("SELECT LAST_INSERT_ID()")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // Lấy banners đang hoạt động và trong khoảng thời gian hiệu lực
    public List<Banner> getActiveBanners() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, title, image_url as imageURL, link_url as linkURL, " +
                                        "alt_text as altText, start_date as startDate, end_date as endDate, " +
                                        "sort_order as sortOrder, status, created_at as createAt, " +
                                        "updated_at as updateAt " +
                                        "FROM banners WHERE status = 1 " +
                                        "AND (start_date IS NULL OR start_date <= CURRENT_DATE) " +
                                        "AND (end_date IS NULL OR end_date >= CURRENT_DATE) " +
                                        "ORDER BY sort_order ASC, created_at DESC"
                        )
                        .mapToBean(Banner.class)
                        .list()
        );
    }

}
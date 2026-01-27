package vn.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Banner {
    private int id;
    private String title;
    private String imageURL;
    private String linkURL;
    private String altText;
    private LocalDate startDate;      // Thay Date bằng LocalDate
    private LocalDate endDate;        // Thay Date bằng LocalDate
    private int sortOrder;
    private int status;
    private LocalDateTime createAt;   // Thay Date bằng LocalDateTime
    private LocalDateTime updateAt;   // Thay Date bằng LocalDateTime

    // Constructors
    public Banner() {
    }

    public Banner(int id, String title, String imageURL, String linkURL,
                  String altText, LocalDate startDate, LocalDate endDate,
                  int sortOrder, int status, LocalDateTime createAt,
                  LocalDateTime updateAt) {
        this.id = id;
        this.title = title;
        this.imageURL = imageURL;
        this.linkURL = linkURL;
        this.altText = altText;
        this.startDate = startDate;
        this.endDate = endDate;
        this.sortOrder = sortOrder;
        this.status = status;
        this.createAt = createAt;
        this.updateAt = updateAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getLinkURL() {
        return linkURL;
    }

    public void setLinkURL(String linkURL) {
        this.linkURL = linkURL;
    }

    public String getAltText() {
        return altText;
    }

    public void setAltText(String altText) {
        this.altText = altText;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public LocalDateTime getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(LocalDateTime updateAt) {
        this.updateAt = updateAt;
    }

    // Helper methods để tương thích với JSP
    public java.util.Date getStartDateAsUtilDate() {
        return startDate != null ?
                java.sql.Date.valueOf(startDate) : null;
    }

    public java.util.Date getEndDateAsUtilDate() {
        return endDate != null ?
                java.sql.Date.valueOf(endDate) : null;
    }

    public java.util.Date getCreateAtAsUtilDate() {
        return createAt != null ?
                java.sql.Timestamp.valueOf(createAt) : null;
    }

    public java.util.Date getUpdateAtAsUtilDate() {
        return updateAt != null ?
                java.sql.Timestamp.valueOf(updateAt) : null;
    }
}
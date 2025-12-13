package vn.model;

import java.util.Date;

public class Banner {
    public int id;
    public String title;
    public String imageURL;
    public String linkURL;
    public String altText;
    public Date startDate;
    public Date endDate;
    public int sortOrder;
    public int status;
    public Date createAt;
    public Date updateAt;



    public Banner(int id, String title, String imageURL, String linkURL, String altText, Date startDate, Date endDate, int sortOrder, int status, Date createAt, Date updateAt) {
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
    public  Banner() {
    }

    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getImageURL() {
        return imageURL;
    }

    public String getLinkURL() {
        return linkURL;
    }

    public String getAltText() {
        return altText;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public int getStatus() {
        return status;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public Date getUpdateAt() {
        return updateAt;
    }
}

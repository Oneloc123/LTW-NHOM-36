package vn.model;

public class Blog {
        private int id;
        private String title;
        private String thumbnail;
        private String summary;
        private String content;
        private String author;
        private String createdAt;

        // Getter & Setter

    public Blog(int id, String title, String thumbnail, String summary, String content, String author, String createdAt) {
        this.id = id;
        this.title = title;
        this.thumbnail = thumbnail;
        this.summary = summary;
        this.content = content;
        this.author = author;
        this.createdAt = createdAt;
    }

    public Blog() {
    }

    public Blog(String title, String thumbnail, String summary,
                String content, String author) {
        this.title = title;
        this.thumbnail = thumbnail;
        this.summary = summary;
        this.content = content;
        this.author = author;
    }
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

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}

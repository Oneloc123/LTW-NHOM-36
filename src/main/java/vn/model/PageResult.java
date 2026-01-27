package vn.model;

import java.util.List;

public class PageResult<T> {
    private List<T> items;
    private int currentPage;
    private int totalPages;
    private int totalItems;

    public PageResult(List<T> items, int currentPage, int totalPages, int totalItems) {
        this.items = items;
        this.currentPage = currentPage;
        this.totalPages = totalPages;
        this.totalItems = totalItems;
    }

    public List<T> getItems() { return items; }
    public int getCurrentPage() { return currentPage; }
    public int getTotalPages() { return totalPages; }
    public int getTotalItems() { return totalItems; }
}

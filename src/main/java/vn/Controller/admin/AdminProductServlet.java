package vn.Controller.admin;

import vn.model.Image;
import vn.services.ProductService;
import vn.services.ImageService;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private ProductService productService;
    private ImageService imageService;

    @Override
    public void init() {
        productService = new ProductService();
        imageService = new ImageService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("id") == null || session.getAttribute("role") == null) {
            req.getRequestDispatcher("/pages/login.jsp").forward(req, resp);
            return;
        }

        String action = req.getParameter("action");

        if (action == null) {
            listProducts(req, resp);
            return;
        }

        switch (action) {
            case "view":
                viewProduct(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            case "edit":
                int id = Integer.parseInt(req.getParameter("id"));
                Product editProduct = productService.getProductById(id);
                List<Image> images = imageService.getImagesByProductId(id);
                editProduct.setImages(imageService.getImageUrlsByProductId(id));

                req.setAttribute("editProduct", editProduct);
                req.setAttribute("editImages", images);
                listProducts(req, resp);
                break;
            default:
                listProducts(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            addProduct(req, resp);
        } else if ("edit".equals(action)) {
            editProduct(req, resp);
        }
    }

    // ===== METHODS =====

    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");
        String featured = req.getParameter("featured");

        List<Product> products;

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasCategory = category != null && !category.isEmpty();
        boolean hasFeatured = featured != null && !featured.isEmpty();

        if (hasKeyword || hasCategory || hasFeatured) {
            products = productService.filterProducts(keyword, category, featured);
        } else {
            products = productService.getAllProducts();
        }

        // Lấy ảnh đầu tiên cho mỗi sản phẩm
        for (Product product : products) {
            String firstImage = imageService.getFirstImageUrl(product.getId());
            if (firstImage != null) {
                List<String> images = new ArrayList<>();
                images.add(firstImage);
                product.setImages(images);
            }
        }

        req.setAttribute("products", products);
        req.getRequestDispatcher("/admin/admin-products.jsp").forward(req, resp);
    }

    private void viewProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        Product product = productService.getProductById(id);
        List<Image> images = imageService.getImagesByProductId(id);

        product.setImages(imageService.getImageUrlsByProductId(id));

        req.setAttribute("product", product);
        req.setAttribute("images", images);
        req.getRequestDispatcher("/admin/product-detail.jsp").forward(req, resp);
    }

    // Trong phần addProduct của AdminProductServlet:
    private void addProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Product p = new Product();
        p.setName(req.getParameter("Name"));
        p.setCategoryID(Integer.parseInt(req.getParameter("CategoryID")));
        p.setShortDescription(req.getParameter("ShortDescription"));
        p.setFullDescription(req.getParameter("FullDescription"));
        p.setPrice(Integer.parseInt(req.getParameter("Price")));
        p.setFeatured("1".equals(req.getParameter("IsFeatured")));

        // Thêm sản phẩm và lấy ID
        boolean success = productService.addProduct(p);

        // Xử lý ảnh nếu có
        if (success) {
            String[] imageUrls = req.getParameterValues("ImageUrls");
            if (imageUrls != null) {
                for (String url : imageUrls) {
                    if (url != null && !url.trim().isEmpty()) {
                        Image img = new Image();
                        img.setProductId(p.getId()); // Sử dụng ID từ product vừa thêm
                        img.setUrl(url.trim());
                        imageService.addImage(img);
                    }
                }
            }
        }

        resp.sendRedirect("products");
    }

    private void editProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Product p = new Product();
        p.setId(Integer.parseInt(req.getParameter("id")));
        p.setName(req.getParameter("Name"));
        p.setCategoryID(Integer.parseInt(req.getParameter("CategoryID")));
        p.setShortDescription(req.getParameter("ShortDescription"));
        p.setFullDescription(req.getParameter("FullDescription"));
        p.setPrice(Integer.parseInt(req.getParameter("Price")));
        p.setFeatured("1".equals(req.getParameter("IsFeatured")));

        // Cập nhật sản phẩm
        productService.updateProduct(p);

        // Xóa ảnh cũ và thêm ảnh mới
        int productId = p.getId();
        imageService.deleteImagesByProductId(productId);

        String[] imageUrls = req.getParameterValues("ImageUrls");
        if (imageUrls != null) {
            for (String url : imageUrls) {
                if (url != null && !url.trim().isEmpty()) {
                    Image img = new Image();
                    img.setProductId(productId);
                    img.setUrl(url.trim());
                    imageService.addImage(img);
                }
            }
        }

        resp.sendRedirect("products");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        // Xóa ảnh trước
        imageService.deleteImagesByProductId(id);

        // Xóa sản phẩm
        productService.deleteProductById(id);

        resp.sendRedirect("products");
    }
}
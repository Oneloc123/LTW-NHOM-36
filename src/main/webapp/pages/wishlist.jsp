<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách yêu thích | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/wishlist.css">
</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main class="wishlist-page">
    <!-- Hero Section -->
    <section class="hero wishlist-hero">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="hero-title">Danh sách yêu thích</h1>
                    <p class="hero-subtitle">
                        Lưu những sản phẩm bạn yêu thích để xem lại sau này.
                        <span class="wishlist-count">${wishlistCount} sản phẩm</span>
                    </p>
                </div>
                <div class="col-md-4 text-end">
                    <c:if test="${wishlistCount > 0}">
                        <form action="${pageContext.request.contextPath}/wishlist" method="post" class="d-inline">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn btn-outline-danger"
                                    onclick="return confirm('Bạn có chắc chắn muốn xóa tất cả sản phẩm khỏi wishlist?')">
                                <i class="bi bi-trash me-2"></i>Xóa tất cả
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <!-- Wishlist Content -->
    <section class="wishlist-content py-5">
        <div class="container">
            <c:choose>
                <c:when test="${not empty wishlistProducts}">
                    <div class="row">
                        <!-- Wishlist Items -->
                        <div class="col-lg-8">
                            <div class="wishlist-items">
                                <c:forEach var="product" items="${wishlistProducts}">
                                    <div class="wishlist-item">
                                        <div class="row align-items-center">
                                            <!-- Product Image -->
                                            <div class="col-md-2 col-3">
                                                <a href="${pageContext.request.contextPath}/product?id=${product.id}">
                                                    <c:choose>
                                                        <c:when test="${not empty product.imagesTop}">
                                                            <img src="${product.imagesTop}"
                                                                 alt="${product.name}"
                                                                 class="wishlist-item-img">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/assets/img/default-product.jpg"
                                                                 alt="${product.name}"
                                                                 class="wishlist-item-img">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </div>

                                            <!-- Product Info -->
                                            <div class="col-md-5 col-6">
                                                <h5 class="wishlist-item-title">
                                                    <a href="${pageContext.request.contextPath}/product?id=${product.id}"
                                                       class="text-decoration-none text-dark">
                                                            ${product.name}
                                                    </a>
                                                </h5>
                                                <p class="wishlist-item-category small text-muted mb-1">
                                                    <c:choose>
                                                        <c:when test="${product.categoryID == 1}">Công nghệ mini</c:when>
                                                        <c:when test="${product.categoryID == 2}">Thiết bị AI</c:when>
                                                        <c:when test="${product.categoryID == 3}">Phụ kiện sáng tạo</c:when>
                                                        <c:when test="${product.categoryID == 4}">Đồ chơi công nghệ</c:when>
                                                        <c:otherwise>Danh mục khác</c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p class="wishlist-item-description small text-muted">
                                                        ${product.shortDescription}
                                                </p>
                                            </div>

                                            <!-- Price -->
                                            <div class="col-md-2 col-3">
                                                <div class="wishlist-item-price">
                                                    <fmt:formatNumber value="${product.price}"
                                                                      type="currency"
                                                                      currencySymbol="₫"
                                                                      maxFractionDigits="0"/>
                                                </div>
                                            </div>

                                            <!-- Actions -->
                                            <div class="col-md-3 col-12 mt-md-0 mt-3">
                                                <div class="wishlist-item-actions d-flex gap-2">
                                                    <!-- Add to Cart Form -->
                                                    <form action="${pageContext.request.contextPath}/add-cart"
                                                          method="post" class="flex-fill">
                                                        <input type="hidden" name="id" value="${product.id}">
                                                        <input type="hidden" name="q" value="1">
                                                        <button type="submit" class="btn btn-primary btn-sm w-100">
                                                            <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                                                        </button>
                                                    </form>

                                                    <!-- Remove from Wishlist Form -->
                                                    <form action="${pageContext.request.contextPath}/wishlist"
                                                          method="post" class="d-inline">
                                                        <input type="hidden" name="action" value="remove">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <button type="submit" class="btn btn-outline-danger btn-sm">
                                                            <i class="bi bi-heartbreak"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <hr class="my-3">
                                </c:forEach>
                            </div>
                        </div>

                        <!-- Summary Sidebar -->
                        <div class="col-lg-4">
                            <div class="wishlist-summary card border-0 shadow">
                                <div class="card-body">
                                    <h5 class="card-title mb-4">Tóm tắt Wishlist</h5>

                                    <div class="summary-item d-flex justify-content-between mb-3">
                                        <span>Tổng sản phẩm:</span>
                                        <strong>${wishlistCount}</strong>
                                    </div>

                                    <div class="summary-item d-flex justify-content-between mb-4">
                                        <span>Ước tính giá trị:</span>
                                        <strong class="text-primary">
                                            <c:set var="totalValue" value="0" />
                                            <c:forEach var="product" items="${wishlistProducts}">
                                                <c:set var="totalValue" value="${totalValue + product.price}" />
                                            </c:forEach>
                                            <fmt:formatNumber value="${totalValue}"
                                                              type="currency"
                                                              currencySymbol="₫"
                                                              maxFractionDigits="0"/>
                                        </strong>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/products"
                                           class="btn btn-outline-primary">
                                            <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                                        </a>
                                        <a href="${pageContext.request.contextPath}/cart"
                                           class="btn btn-success">
                                            <i class="bi bi-cart-check me-2"></i>Xem giỏ hàng
                                        </a>
                                    </div>

                                    <div class="mt-4">
                                        <h6 class="mb-3">Mẹo mua sắm:</h6>
                                        <ul class="list-unstyled small text-muted">
                                            <li class="mb-2">
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                Sản phẩm trong wishlist sẽ không bị thay đổi giá
                                            </li>
                                            <li class="mb-2">
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                Nhận thông báo khi sản phẩm có khuyến mãi
                                            </li>
                                            <li>
                                                <i class="bi bi-check-circle text-success me-2"></i>
                                                Chia sẻ wishlist với bạn bè
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- Empty Wishlist -->
                    <div class="empty-wishlist text-center py-5">
                        <div class="empty-icon mb-4">
                            <i class="bi bi-heart display-1 text-muted"></i>
                        </div>
                        <h3 class="mb-3">Wishlist của bạn đang trống</h3>
                        <p class="text-muted mb-4">
                            Thêm sản phẩm bạn yêu thích vào wishlist để xem lại sau này!
                        </p>
                        <div class="d-flex justify-content-center gap-3">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">
                                <i class="bi bi-shop me-2"></i>Mua sắm ngay
                            </a>
                            <a href="${pageContext.request.contextPath}/products?category=2" class="btn btn-outline-primary">
                                <i class="bi bi-robot me-2"></i>Xem thiết bị AI
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
</main>

<!-- Footer --><!-- ================= Footer ================= -->
<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container">
        <div class="row gy-4">
            <!-- Logo + Giới thiệu -->
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center mb-3 text-decoration-none">
                    <i class="bi bi-camera fs-3 text-primary me-2"></i>
                    <span class="fw-bold fs-5 text-primary">TechX</span>
                </a>
                <p class="text-muted">
                    Nơi bạn tìm thấy những thiết bị công nghệ độc đáo, hiện đại và sáng tạo.
                    Chúng tôi mang đến trải nghiệm mua sắm tiện lợi và đáng tin cậy.
                </p>
            </div>

            <!-- Danh mục -->
            <div class="col-md-2">
                <h6 class="fw-bold mb-3 text-uppercase">Danh mục</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/shop?category=1" class="footer-link">Công nghệ mini</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=2" class="footer-link">Thiết bị AI</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=3" class="footer-link">Phụ kiện sáng tạo</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=4" class="footer-link">Đồ chơi công nghệ</a></li>
                </ul>
            </div>

            <!-- Hỗ trợ -->
            <div class="col-md-2">
                <h6 class="fw-bold mb-3 text-uppercase">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/contact" class="footer-link">Liên hệ</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq" class="footer-link">Câu hỏi thường gặp</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart" class="footer-link">Giỏ hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/checkout" class="footer-link">Thanh toán</a></li>
                </ul>
            </div>

            <!-- Liên hệ -->
            <div class="col-md-4">
                <h6 class="fw-bold mb-3 text-uppercase">Liên hệ</h6>
                <p class="mb-1"><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP. Hồ Chí Minh</p>
                <p class="mb-1"><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
                <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@techx.vn</p>
                <div class="mt-3">
                    <a href="#" class="social-link me-2"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-link me-2"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-link me-2"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="social-link"><i class="bi bi-tiktok"></i></a>
                </div>
            </div>
        </div>

        <hr class="mt-4 mb-3">
        <div class="text-center small text-muted">
            © 2025 <strong>TechX</strong>. All rights reserved.
        </div>
    </div>
</footer>


<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
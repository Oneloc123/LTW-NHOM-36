<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Công nghệ độc lạ - TechX</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">

    <style>
        .product-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #eaeaea;
            border-radius: 10px;
            overflow: hidden;
            height: 100%;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .product-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .product-price {
            color: #dc3545;
            font-weight: bold;
            font-size: 1.2rem;
        }

        .product-name {
            font-size: 1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #333;
            height: 3rem;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-category {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 0.5rem;
        }

        .add-to-cart-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            width: 100%;
        }

        .add-to-cart-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .featured-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #ff4757;
            color: white;
            padding: 3px 8px;
            border-radius: 3px;
            font-size: 0.7rem;
            font-weight: bold;
        }

        .section-title {
            color: #333;
            font-weight: 700;
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 10px;
        }

        .section-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 3px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .shop-header {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)),
            url('https://images.unsplash.com/photo-1497366754035-f200968a6e72?ixlib=rb-1.2.1&auto=format&fit=crop&w=1600&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0;
            text-align: center;
            margin-bottom: 3rem;
        }

        .shop-header h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
        }

        .shop-header p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 0 auto 2rem;
        }

        .filter-section {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }

        .pagination {
            justify-content: center;
            margin-top: 3rem;
        }

        .page-link {
            color: #667eea;
            border: 1px solid #dee2e6;
        }

        .page-link:hover {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .page-item.active .page-link {
            background: #667eea;
            border-color: #667eea;
        }
    </style>
</head>

<body>
<!-- ================= Header ================= -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- Shop Header -->
<div class="shop-header">
    <div class="container">
        <h1>Cửa hàng TechX</h1>
        <p>Khám phá những thiết bị công nghệ độc đáo, hiện đại và sáng tạo</p>

        <!-- Search Form -->
        <form action="${pageContext.request.contextPath}/shop" method="get" class="row g-3 justify-content-center">
            <div class="col-md-6">
                <div class="input-group">
                    <input type="text" class="form-control form-control-lg"
                           name="keyword" placeholder="Tìm kiếm sản phẩm..."
                           value="${param.keyword}">
                    <button class="btn btn-primary btn-lg" type="submit">
                        <i class="bi bi-search"></i> Tìm kiếm
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Main Content -->
<main class="container py-4">
    <!-- Filter Section -->
    <div class="filter-section">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h4 class="mb-3">
                    <i class="bi bi-funnel me-2"></i>Lọc sản phẩm
                </h4>
                <form action="${pageContext.request.contextPath}/shop" method="get" class="row g-2">
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="keyword"
                               placeholder="Từ khóa" value="${param.keyword}">
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" name="category">
                            <option value="">Tất cả danh mục</option>
                            <option value="1" ${param.category == '1' ? 'selected' : ''}>Công nghệ mini</option>
                            <option value="2" ${param.category == '2' ? 'selected' : ''}>Thiết bị AI</option>
                            <option value="3" ${param.category == '3' ? 'selected' : ''}>Phụ kiện sáng tạo</option>
                            <option value="4" ${param.category == '4' ? 'selected' : ''}>Đồ chơi công nghệ</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <select class="form-select" name="featured">
                            <option value="">Tất cả</option>
                            <option value="true" ${param.featured == 'true' ? 'selected' : ''}>Sản phẩm nổi bật</option>
                        </select>
                    </div>
                    <div class="col-12 mt-2">
                        <button type="submit" class="btn btn-primary me-2">
                            <i class="bi bi-filter me-1"></i>Lọc
                        </button>
                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline-secondary">
                            <i class="bi bi-x-circle me-1"></i>Xóa bộ lọc
                        </a>
                    </div>
                </form>
            </div>
            <div class="col-md-6 text-end">
                <div class="d-flex align-items-center justify-content-end">
                    <span class="me-2">Sắp xếp:</span>
                    <select class="form-select w-auto" id="sortSelect">
                        <option value="newest">Mới nhất</option>
                        <option value="price_asc">Giá: Thấp đến cao</option>
                        <option value="price_desc">Giá: Cao đến thấp</option>
                        <option value="name">Tên A-Z</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Grid -->
    <div class="row mb-5">
        <div class="col-12">
            <h3 class="section-title">Tất cả sản phẩm</h3>

            <c:choose>
                <c:when test="${not empty list}">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                        <c:forEach var="product" items="${list}">
                            <div class="col">
                                <div class="product-card">
                                    <!-- Featured Badge -->
                                    <c:if test="${product.featured}">
                                        <span class="featured-badge">
                                            <i class="bi bi-star-fill me-1"></i>Nổi bật
                                        </span>
                                    </c:if>

                                    <!-- Product Image -->
                                    <a href="${pageContext.request.contextPath}/product?id=${product.id}">
                                        <c:choose>
                                            <c:when test="${not empty product.imagesTop}">
                                                <img src="${product.imagesTop}"
                                                     alt="${product.name}"
                                                     class="product-img">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/assets/img/default-product.jpg"
                                                     alt="${product.name}"
                                                     class="product-img">
                                            </c:otherwise>
                                        </c:choose>
                                    </a>

                                    <!-- Product Info -->
                                    <div class="p-3">
                                        <div class="product-category">
                                            <c:choose>
                                                <c:when test="${product.categoryID == 1}">Công nghệ mini</c:when>
                                                <c:when test="${product.categoryID == 2}">Thiết bị AI</c:when>
                                                <c:when test="${product.categoryID == 3}">Phụ kiện sáng tạo</c:when>
                                                <c:when test="${product.categoryID == 4}">Đồ chơi công nghệ</c:when>
                                                <c:otherwise>Danh mục khác</c:otherwise>
                                            </c:choose>
                                        </div>

                                        <h5 class="product-name">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.id}"
                                               class="text-decoration-none text-dark">
                                                    ${product.name}
                                            </a>
                                        </h5>

                                        <p class="product-price">
                                            <fmt:formatNumber value="${product.price}"
                                                              type="currency"
                                                              currencySymbol="₫"
                                                              maxFractionDigits="0"/>
                                        </p>

                                        <p class="small text-muted mb-3">
                                                ${product.shortDescription}
                                        </p>

                                        <!-- Add to Cart Form -->
                                        <form action="${pageContext.request.contextPath}/add-cart" method="get">
                                            <input type="hidden" name="id" value="${product.id}">
                                            <input type="hidden" name="q" value="1">
                                            <button type="submit" class="add-to-cart-btn">
                                                <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                                            </button>
                                        </form>
                                        <!-- Wishlist Button -->
                                        <c:set var="isInWishlist" value="false" />
                                        <c:if test="${not empty sessionScope.id}">
                                            <c:if test="${wishlistService.isInWishlist(sessionScope.id, product.id)}">
                                                <c:set var="isInWishlist" value="true" />
                                            </c:if>
                                        </c:if>

                                        <c:choose>
                                            <c:when test="${empty sessionScope.id}">
                                                <a href="${pageContext.request.contextPath}/login"
                                                   class="btn btn-outline-danger wishlist-btn"
                                                   title="Thêm vào wishlist">
                                                    <i class="bi bi-heart"></i>
                                                </a>
                                            </c:when>
                                            <c:when test="${isInWishlist}">
                                                <button class="btn btn-danger wishlist-btn" disabled>
                                                    <i class="bi bi-heart-fill"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <form action="${pageContext.request.contextPath}/add-to-wishlist" method="post" class="d-inline">
                                                    <input type="hidden" name="id" value="${product.id}">
                                                    <button type="submit" class="btn btn-outline-danger wishlist-btn"
                                                            title="Thêm vào wishlist">
                                                        <i class="bi bi-heart"></i>
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- No Products Found -->
                    <div class="text-center py-5">
                        <i class="bi bi-search display-1 text-muted mb-3"></i>
                        <h4 class="text-muted mb-3">Không tìm thấy sản phẩm nào</h4>
                        <p class="text-muted mb-4">Hãy thử tìm kiếm với từ khóa khác hoặc xóa bộ lọc</p>
                        <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">
                            <i class="bi bi-arrow-left me-2"></i>Quay lại cửa hàng
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- New Arrivals Section -->
    <c:if test="${not empty newArrivalsList}">
        <div class="row mb-5">
            <div class="col-12">
                <h3 class="section-title">Hàng mới về</h3>
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
                    <c:forEach var="newProduct" items="${newArrivalsList}">
                        <div class="col">
                            <div class="product-card">
                                <!-- New Badge -->
                                <span class="featured-badge" style="background: #00b894;">
                                    <i class="bi bi-newspaper me-1"></i>Mới
                                </span>

                                <!-- Product Image -->
                                <a href="${pageContext.request.contextPath}/product?id=${newProduct.id}">
                                    <c:choose>
                                        <c:when test="${not empty newProduct.imagesTop}">
                                            <img src="${newProduct.imagesTop}"
                                                 alt="${newProduct.name}"
                                                 class="product-img">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/assets/img/default-product.jpg"
                                                 alt="${newProduct.name}"
                                                 class="product-img">
                                        </c:otherwise>
                                    </c:choose>
                                </a>

                                <!-- Product Info -->
                                <div class="p-3">
                                    <h5 class="product-name">
                                        <a href="${pageContext.request.contextPath}/product?id=${newProduct.id}"
                                           class="text-decoration-none text-dark">
                                                ${newProduct.name}
                                        </a>
                                    </h5>

                                    <p class="product-price">
                                        <fmt:formatNumber value="${newProduct.price}"
                                                          type="currency"
                                                          currencySymbol="₫"
                                                          maxFractionDigits="0"/>
                                    </p>

                                    <!-- Add to Cart Form -->
                                    <form action="${pageContext.request.contextPath}/add-cart" method="get">
                                        <input type="hidden" name="id" value="${newProduct.id}">
                                        <input type="hidden" name="q" value="1">
                                        <button type="submit" class="add-to-cart-btn">
                                            <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                                        </button>
                                    </form>
                                    <!-- Wishlist Button -->
                                    <c:set var="isInWishlist" value="false" />
                                    <c:if test="${not empty sessionScope.userId}">
                                        <c:if test="${wishlistService.isInWishlist(sessionScope.id, product.id)}">
                                            <c:set var="isInWishlist" value="true" />
                                        </c:if>
                                    </c:if>

                                    <c:choose>
                                        <c:when test="${empty sessionScope.id}">
                                            <a href="${pageContext.request.contextPath}/login"
                                               class="btn btn-outline-danger wishlist-btn"
                                               title="Thêm vào wishlist">
                                                <i class="bi bi-heart"></i>
                                            </a>
                                        </c:when>
                                        <c:when test="${isInWishlist}">
                                            <button class="btn btn-danger wishlist-btn" disabled>
                                                <i class="bi bi-heart-fill"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/add-to-wishlist" method="post" class="d-inline">
                                                <input type="hidden" name="id" value="${product.id}">
                                                <button type="submit" class="btn btn-outline-danger wishlist-btn"
                                                        title="Thêm vào wishlist">
                                                    <i class="bi bi-heart"></i>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Categories Section -->
    <div class="row mb-5">
        <div class="col-12">
            <h3 class="section-title">Danh mục sản phẩm</h3>
            <div class="row g-4">
                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/shop?category=1"
                       class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm h-100">
                            <div class="card-body p-4">
                                <div class="mb-3">
                                    <i class="bi bi-phone display-4 text-primary"></i>
                                </div>
                                <h5 class="card-title">Công nghệ mini</h5>
                                <p class="text-muted small">Thiết bị nhỏ gọn, tiện lợi</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/shop?category=2"
                       class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm h-100">
                            <div class="card-body p-4">
                                <div class="mb-3">
                                    <i class="bi bi-cpu display-4 text-success"></i>
                                </div>
                                <h5 class="card-title">Thiết bị AI</h5>
                                <p class="text-muted small">Thông minh, tự động hóa</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/shop?category=3"
                       class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm h-100">
                            <div class="card-body p-4">
                                <div class="mb-3">
                                    <i class="bi bi-tools display-4 text-warning"></i>
                                </div>
                                <h5 class="card-title">Phụ kiện sáng tạo</h5>
                                <p class="text-muted small">Độc đáo, sáng tạo</p>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-3">
                    <a href="${pageContext.request.contextPath}/shop?category=4"
                       class="text-decoration-none">
                        <div class="card text-center border-0 shadow-sm h-100">
                            <div class="card-body p-4">
                                <div class="mb-3">
                                    <i class="bi bi-controller display-4 text-danger"></i>
                                </div>
                                <h5 class="card-title">Đồ chơi công nghệ</h5>
                                <p class="text-muted small">Giải trí thông minh</p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- ================= Footer ================= -->
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

<!-- Bootstrap Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Sort functionality
    document.getElementById('sortSelect').addEventListener('change', function() {
        const sortValue = this.value;
        const url = new URL(window.location.href);
        url.searchParams.set('sort', sortValue);
        window.location.href = url.toString();
    });

    // Set current sort value
    const urlParams = new URLSearchParams(window.location.search);
    const currentSort = urlParams.get('sort') || 'newest';
    document.getElementById('sortSelect').value = currentSort;

    // Add to cart with AJAX
    document.querySelectorAll('.add-to-cart-btn').forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            const form = this.closest('form');
            const formData = new FormData(form);

            // Get product ID and quantity
            const productId = formData.get('id');
            const quantity = formData.get('q');

            // Disable button during request
            const originalText = this.innerHTML;
            this.innerHTML = '<i class="bi bi-hourglass-split me-1"></i>Đang thêm...';
            this.disabled = true;

            // Send AJAX request
            fetch(`${pageContext.request.contextPath}/add-cart?id=${productId}&q=${quantity}`, {
                method: 'GET'
            })
                .then(response => {
                    if (response.ok) {
                        showToast('Đã thêm sản phẩm vào giỏ hàng!');
                        updateCartCount(parseInt(quantity));

                        // Redirect to cart page after 2 seconds if needed
                        setTimeout(() => {
                            if (confirm('Bạn có muốn xem giỏ hàng?')) {
                                window.location.href = `${pageContext.request.contextPath}/cart`;
                            }
                        }, 1500);
                    } else {
                        showToast('Có lỗi xảy ra. Vui lòng thử lại!', false);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showToast('Lỗi kết nối. Vui lòng thử lại!', false);
                })
                .finally(() => {
                    // Restore button state
                    this.innerHTML = originalText;
                    this.disabled = false;
                });
        });
    });

    // Toast notification
    function showToast(message, isSuccess = true) {
        // Create toast element if it doesn't exist
        let toastContainer = document.getElementById('toast-container');
        if (!toastContainer) {
            toastContainer = document.createElement('div');
            toastContainer.id = 'toast-container';
            toastContainer.style.cssText = `
                position: fixed;
                top: 20px;
                right: 20px;
                z-index: 1050;
            `;
            document.body.appendChild(toastContainer);
        }

        const toastId = 'toast-' + Date.now();
        const toast = document.createElement('div');
        toast.id = toastId;
        toast.className = 'toast show';
        toast.style.cssText = `
            background: ${isSuccess ? '#28a745' : '#dc3545'};
            color: white;
            padding: 12px 20px;
            border-radius: 5px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            animation: slideIn 0.3s ease;
        `;

        toast.innerHTML = `
            <i class="bi ${isSuccess ? 'bi-check-circle-fill' : 'bi-x-circle-fill'} me-2"></i>
            <span>${message}</span>
        `;

        toastContainer.appendChild(toast);

        // Remove toast after 3 seconds
        setTimeout(() => {
            toast.style.animation = 'slideOut 0.3s ease';
            setTimeout(() => {
                if (toast.parentNode) {
                    toast.parentNode.removeChild(toast);
                }
            }, 300);
        }, 3000);
    }

    // Update cart count in header
    function updateCartCount(addedQty) {
        const cartCountElements = document.querySelectorAll('.cart-count, .cart-badge');
        cartCountElements.forEach(element => {
            let currentCount = parseInt(element.textContent) || 0;
            element.textContent = currentCount + addedQty;
            element.style.display = 'inline-block';

            // Add animation
            element.classList.add('cart-updated');
            setTimeout(() => {
                element.classList.remove('cart-updated');
            }, 1000);
        });
    }

    // Add CSS animations
    const style = document.createElement('style');
    style.textContent = `
        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        @keyframes slideOut {
            from { transform: translateX(0); opacity: 1; }
            to { transform: translateX(100%); opacity: 0; }
        }

        .cart-updated {
            animation: cartPulse 0.5s ease-in-out;
        }

        @keyframes cartPulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.3); }
            100% { transform: scale(1); }
        }
    `;
    document.head.appendChild(style);
</script>
</body>
</html>
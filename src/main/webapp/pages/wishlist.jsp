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
<style>
    /* Wishlist Page Styles */
    .wishlist-page {
        min-height: 100vh;
        background-color: #f8f9fa;
    }

    /* Hero Section */
    .wishlist-hero {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 3rem 0;
    }

    .wishlist-hero .hero-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin-bottom: 0.5rem;
    }

    .wishlist-hero .hero-subtitle {
        font-size: 1.1rem;
        opacity: 0.9;
    }

    .wishlist-count {
        display: inline-block;
        background: rgba(255, 255, 255, 0.2);
        padding: 0.25rem 0.75rem;
        border-radius: 20px;
        font-size: 0.9rem;
        margin-left: 0.5rem;
    }

    /* Wishlist Items */
    .wishlist-items {
        background: white;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 2px 15px rgba(0,0,0,0.05);
    }

    .wishlist-item {
        padding: 1rem 0;
        transition: background-color 0.3s;
    }

    .wishlist-item:hover {
        background-color: #f8f9fa;
        border-radius: 8px;
    }

    .wishlist-item-img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #e0e0e0;
    }

    .wishlist-item-title {
        font-size: 1.1rem;
        font-weight: 600;
        margin-bottom: 0.25rem;
        color: #333;
    }

    .wishlist-item-title a:hover {
        color: #667eea;
    }

    .wishlist-item-category {
        font-size: 0.85rem;
    }

    .wishlist-item-description {
        font-size: 0.9rem;
        line-height: 1.4;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .wishlist-item-price {
        font-size: 1.25rem;
        font-weight: 700;
        color: #e74c3c;
    }

    .wishlist-item-actions .btn {
        font-size: 0.875rem;
        padding: 0.375rem 0.75rem;
    }

    /* Summary Card */
    .wishlist-summary {
        background: white;
        border-radius: 12px;
    }

    .wishlist-summary .card-title {
        color: #333;
        font-weight: 600;
        position: relative;
        padding-bottom: 0.75rem;
    }

    .wishlist-summary .card-title::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 40px;
        height: 3px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 2px;
    }

    .summary-item {
        padding: 0.5rem 0;
        border-bottom: 1px solid #f0f0f0;
    }

    .summary-item:last-child {
        border-bottom: none;
    }

    .summary-item span {
        color: #666;
    }

    /* Empty Wishlist */
    .empty-wishlist {
        background: white;
        border-radius: 12px;
        padding: 4rem 2rem;
        box-shadow: 0 2px 15px rgba(0,0,0,0.05);
    }

    .empty-icon {
        color: #e0e0e0;
    }

    .empty-wishlist h3 {
        color: #333;
        font-weight: 600;
    }

    .empty-wishlist p {
        max-width: 500px;
        margin: 0 auto;
    }

    /* Recommended Products */
    .recommended-products .card {
        border-radius: 8px;
        overflow: hidden;
        transition: transform 0.3s;
    }

    .recommended-products .card:hover {
        transform: translateY(-5px);
    }

    .recommended-products .card-title {
        font-size: 0.9rem;
        font-weight: 600;
        margin-bottom: 0.25rem;
    }

    .recommended-products .card-text {
        font-size: 0.8rem;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .wishlist-hero {
            padding: 2rem 0;
            text-align: center;
        }

        .wishlist-hero .hero-title {
            font-size: 2rem;
        }

        .wishlist-hero .text-end {
            text-align: center !important;
            margin-top: 1rem;
        }

        .wishlist-item-img {
            width: 60px;
            height: 60px;
        }

        .wishlist-item-title {
            font-size: 1rem;
        }

        .wishlist-item-actions {
            flex-direction: column;
            gap: 0.5rem !important;
        }

        .wishlist-item-actions .btn {
            width: 100%;
        }
    }
</style>
</head>

<body>
<!-- ================= Header ================= -->
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
                    <button id="clearWishlistBtn" class="btn btn-outline-danger" ${wishlistCount == 0 ? 'disabled' : ''}>
                        <i class="bi bi-trash me-2"></i>Xóa tất cả
                    </button>
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
                                    <div class="wishlist-item" id="wishlist-item-${product.id}">
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
                                                    <form action="${pageContext.request.contextPath}/add-cart" method="post" class="flex-fill">
                                                        <input type="hidden" name="id" value="${product.id}">
                                                        <input type="hidden" name="q" value="1">
                                                        <button type="submit" class="btn btn-primary btn-sm w-100">
                                                            <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
                                                        </button>
                                                    </form>
                                                    <button class="btn btn-outline-danger btn-sm remove-wishlist-btn"
                                                            data-product-id="${product.id}">
                                                        <i class="bi bi-heartbreak"></i>
                                                    </button>
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
                                            <fmt:formatNumber value="${wishlistProducts.stream().mapToInt(p -> p.price).sum()}"
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

                            <!-- Recommended Products -->
                            <div class="recommended-products mt-4">
                                <h6 class="mb-3">Có thể bạn sẽ thích</h6>
                                <div class="row g-3">
                                    <!-- Placeholder for recommended products -->
                                    <div class="col-12">
                                        <div class="card border-0 shadow-sm">
                                            <div class="row g-0">
                                                <div class="col-4">
                                                    <img src="https://via.placeholder.com/100x100"
                                                         class="img-fluid rounded-start"
                                                         alt="Recommended">
                                                </div>
                                                <div class="col-8">
                                                    <div class="card-body p-2">
                                                        <h6 class="card-title mb-1">Sản phẩm đề xuất</h6>
                                                        <p class="card-text small text-muted mb-1">Mô tả ngắn</p>
                                                        <p class="card-text text-primary mb-0">₫1,000,000</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/wishlist.js"></script>
<script>
    // Wishlist JavaScript
    document.addEventListener('DOMContentLoaded', function() {
        const contextPath = '${pageContext.request.contextPath}';

        // Xử lý xóa sản phẩm khỏi wishlist
        document.querySelectorAll('.remove-wishlist-btn').forEach(button => {
            button.addEventListener('click', function() {
                const productId = this.getAttribute('data-product-id');
                removeFromWishlist(productId, this);
            });
        });

        // Xóa tất cả wishlist
        const clearBtn = document.getElementById('clearWishlistBtn');
        if (clearBtn) {
            clearBtn.addEventListener('click', function() {
                if (confirm('Bạn có chắc chắn muốn xóa tất cả sản phẩm khỏi wishlist?')) {
                    clearWishlist();
                }
            });
        }

        // Cập nhật trạng thái wishlist trên các nút trong trang sản phẩm
        updateWishlistButtons();
    });

    // Xóa sản phẩm khỏi wishlist bằng AJAX
    function removeFromWishlist(productId, buttonElement) {
        fetch('${pageContext.request.contextPath}/wishlist', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=remove&productId=${productId}`
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    // Xóa phần tử khỏi DOM
                    const wishlistItem = document.getElementById(`wishlist-item-${productId}`);
                    if (wishlistItem) {
                        wishlistItem.nextElementSibling?.remove(); // Xóa <hr>
                        wishlistItem.remove();

                        // Cập nhật số lượng
                        updateWishlistCount();

                        // Hiển thị thông báo
                        showToast('success', data.message);
                    }
                } else {
                    showToast('error', data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('error', 'Đã xảy ra lỗi!');
            });
    }

    // Xóa tất cả wishlist
    function clearWishlist() {
        fetch('${pageContext.request.contextPath}/wishlist', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'action=clear'
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    // Xóa tất cả sản phẩm
                    document.querySelectorAll('.wishlist-item').forEach(item => {
                        item.nextElementSibling?.remove(); // Xóa <hr>
                        item.remove();
                    });

                    // Cập nhật số lượng
                    updateWishlistCount();

                    // Disable nút xóa tất cả
                    const clearBtn = document.getElementById('clearWishlistBtn');
                    if (clearBtn) {
                        clearBtn.disabled = true;
                    }

                    // Hiển thị trang wishlist trống
                    showEmptyWishlist();

                    showToast('success', data.message);
                } else {
                    showToast('error', data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('error', 'Đã xảy ra lỗi!');
            });
    }

    // Cập nhật số lượng wishlist
    function updateWishlistCount() {
        const wishlistItems = document.querySelectorAll('.wishlist-item');
        const count = wishlistItems.length;

        // Cập nhật số lượng trong hero
        const countElement = document.querySelector('.wishlist-count');
        if (countElement) {
            countElement.textContent = `${count} sản phẩm`;
        }

        // Cập nhật số lượng trong summary
        const summaryCount = document.querySelector('.summary-item strong');
        if (summaryCount) {
            summaryCount.textContent = count;
        }

        // Cập nhật số lượng trong header (nếu có)
        updateHeaderWishlistCount(count);

        // Nếu không còn sản phẩm, hiển thị trang trống
        if (count === 0) {
            showEmptyWishlist();
        }
    }

    // Hiển thị trang wishlist trống
    function showEmptyWishlist() {
        const wishlistContent = document.querySelector('.wishlist-content .container');
        if (wishlistContent && !document.querySelector('.empty-wishlist')) {
            const emptyHTML = `
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
        `;
            wishlistContent.innerHTML = emptyHTML;
        }
    }

    // Cập nhật số lượng trong header
    function updateHeaderWishlistCount(count) {
        const headerCount = document.querySelector('.wishlist-count-header');
        if (headerCount) {
            headerCount.textContent = count;
            headerCount.style.display = count === 0 ? 'none' : 'flex';
        }
    }

    // Thêm vào wishlist từ trang sản phẩm
    function addToWishlist(productId, buttonElement) {
        fetch('${pageContext.request.contextPath}/add-to-wishlist', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `id=${productId}`
        })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else {
                    return response.text();
                }
            })
            .then(() => {
                if (buttonElement) {
                    updateWishlistButtonUI(buttonElement, true);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('error', 'Đã xảy ra lỗi khi thêm vào wishlist!');
            });
    }

    // Xóa khỏi wishlist từ trang sản phẩm
    function removeFromWishlistOnProductPage(productId, buttonElement) {
        fetch('${pageContext.request.contextPath}/wishlist', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: `action=remove&productId=${productId}`
        })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    updateWishlistButtonUI(buttonElement, false);
                    showToast('success', data.message);
                    updateHeaderWishlistCount(parseInt(document.querySelector('.wishlist-count-header')?.textContent || '0') - 1);
                } else {
                    showToast('error', data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('error', 'Đã xảy ra lỗi!');
            });
    }

    // Cập nhật UI nút wishlist
    function updateWishlistButtonUI(buttonElement, isAdded) {
        if (isAdded) {
            buttonElement.innerHTML = '<i class="bi bi-heart-fill"></i> Đã thích';
            buttonElement.classList.remove('btn-outline-danger');
            buttonElement.classList.add('btn-danger');
            buttonElement.disabled = true;
            buttonElement.setAttribute('title', 'Đã có trong wishlist');
        } else {
            buttonElement.innerHTML = '<i class="bi bi-heart"></i> Yêu thích';
            buttonElement.classList.remove('btn-danger');
            buttonElement.classList.add('btn-outline-danger');
            buttonElement.disabled = false;
            buttonElement.setAttribute('title', 'Thêm vào wishlist');
        }
    }

    // Cập nhật trạng thái nút wishlist
    function updateWishlistButtons() {
        document.querySelectorAll('.wishlist-toggle-btn').forEach(button => {
            const productId = button.getAttribute('data-product-id');
            if (productId) {
                checkWishlistStatus(productId, button);
            }
        });
    }

    // Kiểm tra trạng thái wishlist
    function checkWishlistStatus(productId, buttonElement) {
        fetch('${pageContext.request.contextPath}/check-wishlist?productId=' + productId)
            .then(response => response.json())
            .then(data => {
                if (data.inWishlist) {
                    updateWishlistButtonUI(buttonElement, true);
                }
            })
            .catch(error => console.error('Error checking wishlist status:', error));
    }

    // Hiển thị thông báo toast
    function showToast(type, message) {
        // Tạo toast element
        const toast = document.createElement('div');
        toast.className = `toast align-items-center text-white bg-${type} border-0 position-fixed`;
        toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999;';
        toast.setAttribute('role', 'alert');

        toast.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    `;

        document.body.appendChild(toast);

        // Khởi tạo và hiển thị toast
        const bsToast = new bootstrap.Toast(toast);
        bsToast.show();

        // Tự động xóa sau khi ẩn
        toast.addEventListener('hidden.bs.toast', function() {
            toast.remove();
        });
    }

    // Toggle wishlist (thêm/xóa)
    function toggleWishlist(productId, buttonElement) {
        if (buttonElement.classList.contains('btn-danger')) {
            // Đang trong wishlist -> xóa
            removeFromWishlistOnProductPage(productId, buttonElement);
        } else {
            // Chưa trong wishlist -> thêm
            addToWishlist(productId, buttonElement);
        }
    }
</script>
</body>
</html>
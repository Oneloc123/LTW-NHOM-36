<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <title>${p.name} | TechX</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS Files -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css">

    <!-- AOS (animate on scroll) -->
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css" />

    <meta name="description" content="${p.shortDescription}" />
</head>

<body>
<!-- Header -->
<%@ include file="../WEB-INF/views/common/header.jsp" %>

<main class="container product-detail-page" style="padding-top:18px">

    <!-- Product Container -->
    <section class="product-container" aria-labelledby="productTitle">

        <!-- LEFT: Product Details -->
        <div class="product-card" data-aos="fade-up">
            <div class="gallery">
                <!-- MAIN IMAGE -->
                <figure class="main-image" id="mainImageWrap" aria-label="Ảnh sản phẩm chính">
                    <c:choose>
                        <c:when test="${not empty p.imagesTop}">
                            <img id="mainImage" src="${p.imagesTop}" alt="${p.name}">
                        </c:when>
                        <c:otherwise>
                            <img id="mainImage" src="${pageContext.request.contextPath}/assets/img/default-product.jpg" alt="${p.name}">
                        </c:otherwise>
                    </c:choose>
                    <div class="zoom-hint"><i class="bi bi-arrows-fullscreen"></i> Phóng to</div>
                </figure>

                <!-- THUMBNAILS -->
                <div class="thumbs" id="thumbsList" role="list">
                    <c:choose>
                        <c:when test="${not empty p.images}">
                            <c:forEach var="img" items="${p.images}" varStatus="st">
                                <button class="thumb ${st.index == 0 ? 'active' : ''}"
                                        data-src="${img}"
                                        aria-label="Ảnh ${st.index + 1}">
                                    <img src="${img}" alt="thumbnail ${st.index + 1}" />
                                </button>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <button class="thumb active"
                                    data-src="${pageContext.request.contextPath}/assets/img/default-product.jpg"
                                    aria-label="Ảnh sản phẩm">
                                <img src="${pageContext.request.contextPath}/assets/img/default-product.jpg" alt="thumbnail" />
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- META INFORMATION -->
            <div class="meta" style="margin-top:16px">
                <h1 id="productTitle" class="product-title">${p.name}</h1>

                <div class="rating-row">
                    <div class="stars" aria-hidden="true">★★★★☆</div>
                    <div class="review-count">(125 đánh giá)</div>
                </div>

                <div class="price-row">
                    <div class="current-price" id="price">
                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </div>
                    <div class="old-price">
                        <fmt:formatNumber value="${p.price * 1.2}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </div>
                    <div class="badge-sale">-20%</div>
                </div>

                <p class="product-desc">${p.fullDescription}</p>
            </div>

            <!-- TABS -->
            <div class="product-detail-section" style="margin-top:18px" data-aos="fade-up" data-aos-delay="160">
                <div class="tabs">
                    <div class="tab-controls" role="tablist" aria-label="Nội dung sản phẩm">
                        <button class="active" data-tab="details" role="tab">Chi tiết</button>
                        <button data-tab="specs" role="tab">Thông số</button>
                        <button data-tab="reviews" role="tab">Đánh giá</button>
                    </div>

                    <div class="tab-content" id="tabContent">
                        <div id="details" class="tab-panel" data-panel>
                            <p>${p.fullDescription}</p>
                        </div>

                        <div id="specs" class="tab-panel" data-panel style="display:none">
                            <table class="spec-table">
                                <tr>
                                    <td>Mô tả ngắn</td>
                                    <td>${p.shortDescription}</td>
                                </tr>
                                <tr>
                                    <td>Danh mục</td>
                                    <td>${p.categoryID}</td>
                                </tr>
                                <tr>
                                    <td>Sản phẩm nổi bật</td>
                                    <td>${p.featured ? 'Có' : 'Không'}</td>
                                </tr>
                            </table>
                        </div>

                        <div id="reviews" class="tab-panel" data-panel style="display:none">
                            <div class="reviews">
                                <div class="review">
                                    <div class="meta">
                                        <div class="name">Khách hàng 1</div>
                                        <div class="date">2 tuần trước</div>
                                    </div>
                                    <div class="text">Sản phẩm chất lượng tốt, giao hàng nhanh.</div>
                                </div>
                                <div class="review">
                                    <div class="meta">
                                        <div class="name">Khách hàng 2</div>
                                        <div class="date">1 tháng trước</div>
                                    </div>
                                    <div class="text">Đáng đồng tiền, sẽ mua tiếp.</div>
                                </div>
                                <div style="text-align:center; margin-top:10px">
                                    <button id="writeReviewBtn" class="capacity-btn">Viết đánh giá</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- RIGHT: Side Panel (Add to Cart) -->
        <aside class="side-panel" data-aos="fade-left" aria-label="Thanh mua hàng">
            <div>
                <div style="display:flex; justify-content:space-between; align-items:center">
                    <div style="font-size:13px; color:var(--muted)">Tình trạng</div>
                    <div class="in-stock" id="stockLabel">Còn hàng</div>
                </div>

                <div style="margin-top:8px">
                    <div style="font-size:13px; color:var(--muted)">Vận chuyển</div>
                    <div style="font-weight:700; margin-top:4px">Giao hàng toàn quốc — 2–4 ngày</div>
                </div>
            </div>

            <div style="margin-top:16px">
                <div class="kv">Giá</div>
                <div style="display:flex; align-items:center; justify-content:space-between; margin-top:6px">
                    <div class="current-price" id="sidePrice">
                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </div>
                    <div class="old-price">
                        <fmt:formatNumber value="${p.price * 1.2}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                    </div>
                </div>
            </div>

            <div style="margin-top:16px">
                <div class="kv">Số lượng</div>
                <div class="qty" style="margin-top:6px">
                    <button id="decr" class="qty-btn" aria-label="Giảm">−</button>
                    <input id="qtyInput" type="number" min="1" max="10" value="1" aria-label="Số lượng sản phẩm" />
                    <button id="incr" class="qty-btn" aria-label="Tăng">+</button>
                </div>
                <div style="margin-top:8px; font-size:13px; color:var(--muted)">
                    <span id="stockCount">10</span> sản phẩm có sẵn
                </div>
            </div>

            <!-- ADD TO CART FORM - FIXED -->
            <div style="margin-top:20px">
                <form id="addCartForm" action="${pageContext.request.contextPath}/add-cart" method="get">
                    <input type="hidden" name="id" value="${p.id}">
                    <input type="hidden" name="q" id="cartQty" value="1">

                    <button type="submit" class="btn-cart w-100" id="addToCartBtn">
                        <i class="bi bi-cart-plus me-2"></i>Thêm vào giỏ hàng
                    </button>
                </form>
                <c:if test="${not empty sessionScope.id}">
                    <form action="${pageContext.request.contextPath}/wishlist" method="post" class="d-inline">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${p.id}">
                        <button type="submit" class="btn btn-outline-danger btn-sm"
                                title="Thêm vào danh sách yêu thích">
                            <i class="bi bi-heart"></i> Yêu thích
                        </button>
                    </form>
                </c:if>
                <c:if test="${empty sessionScope.id}">
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-outline-danger btn-sm"
                       title="Đăng nhập để thêm vào wishlist">
                        <i class="bi bi-heart"></i> Yêu thích
                    </a>
                </c:if>
<%--                <!-- Test Link -->--%>
<%--                <div class="mt-3 text-center">--%>
<%--                    <a href="${pageContext.request.contextPath}/add-cart?id=${p.id}&q=1"--%>
<%--                       class="btn btn-sm btn-outline-primary">--%>
<%--                        <i class="bi bi-cart-check me-1"></i>Test Add 1 Item--%>
<%--                    </a>--%>
<%--                </div>--%>
            </div>

            <div style="margin-top:12px; font-size:13px; color:var(--muted)">
                <i class="bi bi-shield-check me-1"></i> 12 tháng bảo hành • Hỗ trợ 24/7
            </div>
        </aside>
    </section>

    <!-- Toast Notification -->
    <div id="toast" class="toast" role="status" aria-live="polite" aria-atomic="true">
        <i class="bi bi-check-circle-fill text-success me-2"></i>
        <div id="toastText" style="font-weight:700">Đã thêm vào giỏ hàng</div>
    </div>
</main>

<!-- Footer -->
<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container">
        <div class="row gy-4">
            <div class="col-md-4">
                <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center mb-3 text-decoration-none">
                    <i class="bi bi-camera fs-3 text-primary me-2"></i>
                    <span class="fw-bold fs-5 text-primary">TechX</span>
                </a>
                <p class="text-muted">
                    Nơi bạn tìm thấy những thiết bị công nghệ độc đáo, hiện đại và sáng tạo.
                </p>
            </div>

            <div class="col-md-2">
                <h6 class="fw-bold mb-3 text-uppercase">Danh mục</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/products" class="footer-link">Tất cả sản phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=1" class="footer-link">Công nghệ mini</a></li>
                    <li><a href="${pageContext.request.contextPath}/products?category=2" class="footer-link">Thiết bị AI</a></li>
                </ul>
            </div>

            <div class="col-md-2">
                <h6 class="fw-bold mb-3 text-uppercase">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/contact" class="footer-link">Liên hệ</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart" class="footer-link">Giỏ hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/checkout" class="footer-link">Thanh toán</a></li>
                </ul>
            </div>

            <div class="col-md-4">
                <h6 class="fw-bold mb-3 text-uppercase">Liên hệ</h6>
                <p><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP.HCM</p>
                <p><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
                <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@techx.vn</p>
            </div>
        </div>

        <hr class="mt-4 mb-3">
        <div class="text-center small text-muted">
            © 2025 <strong>TechX</strong>. All rights reserved.
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>

<!-- Add some CSS for cart animations -->
<style>
    .cart-updated {
        animation: cartPulse 0.5s ease-in-out;
    }

    @keyframes cartPulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.3); }
        100% { transform: scale(1); }
    }

    .toast {
        position: fixed;
        bottom: 20px;
        right: 20px;
        padding: 15px 20px;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        display: flex;
        align-items: center;
        z-index: 1000;
        opacity: 0;
        transform: translateY(20px);
        transition: all 0.3s ease;
    }

    .toast.show {
        opacity: 1;
        transform: translateY(0);
    }

    .btn-cart {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-cart:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 12px rgba(102, 126, 234, 0.4);
    }

    .btn-cart:disabled {
        opacity: 0.7;
        cursor: not-allowed;
        transform: none;
    }

    .spec-table {
        width: 100%;
        border-collapse: collapse;
    }

    .spec-table tr {
        border-bottom: 1px solid #eee;
    }

    .spec-table td {
        padding: 10px 0;
    }

    .spec-table td:first-child {
        color: #666;
        font-weight: 500;
        width: 40%;
    }
</style>
</body>
</html>
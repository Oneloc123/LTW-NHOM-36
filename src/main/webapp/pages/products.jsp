<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thiết bị AI Mini | TechX</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/footer.css">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/products.css">
</head>

<body>
<!-- ================= Header ================= -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main class="products-page">
    <!-- HERO -->
    <section class="hero">
        <div class="hero-box">
            <h1 class="hero-title">Thiết bị AI Mini</h1>
            <p class="hero-subtitle">Công nghệ tương lai gói gọn trong lòng bàn tay – Nhỏ nhưng đầy sức mạnh.</p>
        </div>
    </section>

    <!-- FILTER BAR -->
    <section class="filter-bar">
        <div class="filter-container">
            <input type="text" id="searchInput" placeholder="🔍 Tìm kiếm sản phẩm, thương hiệu...">
            <select id="sortSelect">
                <option value="">Sắp xếp</option>
                <option value="asc">Giá tăng dần</option>
                <option value="desc">Giá giảm dần</option>
                <option value="new">Mới nhất</option>
            </select>

            <div class="price-filter">
                <input type="number" id="minPrice" placeholder="Giá từ">
                <span>-</span>
                <input type="number" id="maxPrice" placeholder="đến">
            </div>

            <button id="filterBtn" class="filter-btn">Lọc</button>
        </div>
    </section>

    <!-- CATEGORY TABS -->
    <section class="category-tabs">
        <div class="tabs-container">
            <button class="tab-btn active" data-category="all">Tất cả</button>
            <button class="tab-btn" data-category="mini-tech">Công nghệ mini</button>
            <button class="tab-btn" data-category="ai-device">Thiết bị AI</button>
            <button class="tab-btn" data-category="fun-tech">Đồ chơi công nghệ</button>
            <button class="tab-btn" data-category="creative">Phụ kiện sáng tạo</button>
        </div>
    </section>

    <!-- PRODUCT GRID -->
    <section class="product-grid" id="productGrid">
        <c:forEach var="p" items="${list}">
            <div class="product-card">
                <img src="${p.imagesTop}" alt="${p.name}">

                <h3>${p.name}</h3>

                <div class="product-rating">
                    <span>${p.avgRating} </span> <i class="fa fa-star"></i> <span>(${p.ratingCount})</span>
                </div>

                <div class="product-price">  ${String.format("%,d", p.price)} đ</div>

                <div class="card-footer">
                    <!-- Nút mua (xem chi tiết) -->
                    <button
                            onclick="window.location.href='product?id=${p.getId()}'"
                            class="buy-btn">
                        Chi tiết
                    </button>

                    <!-- Nút thêm vào giỏ hàng -->
                    <form action="${pageContext.request.contextPath}/add-cart" method="get">
                        <input type="hidden" name="id" value="${p.id}">
                        <input type="hidden" name="q" value="1">
                        <button type="submit" class="add-cart-btn">
                            <i class="bi bi-cart-plus me-1"></i>
                        </button>
                    </form>


                    <!-- Nút yêu thích -->


                    <c:if test="${not empty sessionScope.id}">
                        <form action="${pageContext.request.contextPath}/wishlist" method="post" class="d-inline">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="productId" value="${p.id}">
                            <button type="submit" class="btn btn-outline-danger btn-sm wishlist-btn"
                                    title="Thêm vào danh sách yêu thích">
                                <i class="bi bi-heart"></i>
                            </button>
                        </form>
                    </c:if>
                    <c:if test="${empty sessionScope.id}">
                        <a href="${pageContext.request.contextPath}/login"
                           class="btn btn-outline-danger btn-sm wishlist-btn"
                           title="Đăng nhập để thêm vào wishlist">
                            <i class="bi bi-heart"></i>
                        </a>
                    </c:if>

                </div>

            </div>
        </c:forEach>
    </section>


    <!-- Pagination -->
    <div class="pagination-container">
        <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination">
                <!-- Pagination sẽ được tạo bằng JavaScript -->
            </ul>
        </nav>
    </div>


    <!-- CART DRAWER SIMULATION (checkbox hack) -->
    <div class="site-cart">
        <input type="checkbox" id="cart-toggle" hidden>
        <label for="cart-toggle" class="cart-overlay"></label>

        <label for="cart-toggle" class="cart-floating" aria-hidden="false" title="Mở giỏ hàng">
            <span class="cart-count">0</span>
            🛒
        </label>
        <aside class="cart-drawer" aria-label="Giỏ hàng">
            <div class="cart-header">
                <h3>Giỏ hàng của bạn</h3>
                <label for="cart-toggle" class="cart-close" aria-label="Đóng giỏ">✕</label>
            </div>
            <div class="cart-body">
                <p class="muted">Giỏ hàng demo (tĩnh). Links "Thêm vào giỏ" trong trang sẽ dẫn tới đây nhưng không
                    update số lượng do không dùng JS.</p>
                <ul class="cart-items">
                    <li class="cart-item">
                        <img src="https://via.placeholder.com/80x80.png?text=Item" alt="">
                        <div class="cart-info">
                            <strong>Galaxy Mini 1</strong>
                            <span class="muted">1 x 6.490.000₫</span>
                        </div>
                        <div class="cart-actions"><a href="#" class="link-more">Xóa</a></div>
                    </li>
                </ul>
            </div>
            <div class="cart-footer">
                <div class="cart-total"><span>Tổng</span><strong>6.490.000₫</strong></div>
                <div class="cart-cta">
                    <a class="btn btn-ghost" href="#">Tiếp tục mua</a>
                    <a class="btn btn-primary" href="#">Thanh toán</a>
                </div>
            </div>
        </aside>
    </div>
</main>

<!-- ================= Footer ================= -->
<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container">
        <div class="row gy-4">
            <!-- Logo + Giới thiệu -->
            <div class="col-md-4">
                <a href="/index.html" class="d-flex align-items-center mb-3 text-decoration-none">
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
                    <li><a href="/pages/products.html#mini-tech" class="footer-link">Công nghệ mini</a></li>
                    <li><a href="/pages/products.html#ai-device" class="footer-link">Thiết bị AI</a></li>
                    <li><a href="/pages/products.html#creative" class="footer-link">Phụ kiện sáng tạo</a></li>
                    <li><a href="/pages/products.html#fun-tech" class="footer-link">Đồ chơi công nghệ</a></li>
                </ul>
            </div>

            <!-- Hỗ trợ -->
            <div class="col-md-2">
                <h6 class="fw-bold mb-3 text-uppercase">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="/pages/contact.html" class="footer-link">Liên hệ</a></li>
                    <li><a href="/pages/forgot-password.html" class="footer-link">Quên mật khẩu</a></li>
                    <li><a href="/pages/order-history.jsp" class="footer-link">Theo dõi đơn hàng</a></li>
                    <li><a href="/pages/404.html" class="footer-link">Trung tâm trợ giúp</a></li>
                </ul>
            </div>

            <!-- Liên hệ -->
            <div class="col-md-4">
                <h6 class="fw-bold mb-3 text-uppercase">Liên hệ</h6>
                <p class="mb-1"><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP. Hồ Chí Minh</p>
                <p class="mb-1"><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
                <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@htcamera.vn</p>
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
<div id="app" data-context-path="<%= request.getContextPath() %>"></div>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


<script>
    const mapCategory = {
        "mini-tech": 1,
        "ai-device": 2,
        "fun-tech": 3,
        "creative": 4
    };

    const contextPath = document.getElementById("app").dataset.contextPath;
    let currentCategory = "";

    function loadProducts() {
        const params = new URLSearchParams();
        const kw = document.getElementById("searchInput").value.trim();
        const sort = document.getElementById("sortSelect").value;
        const minP = document.getElementById("minPrice").value;
        const maxP = document.getElementById("maxPrice").value;

        if (kw) params.append("keyword", kw);
        if (sort) params.append("sort", sort);
        if (minP) params.append("minPrice", minP);
        if (maxP) params.append("maxPrice", maxP);
        if (currentCategory) params.append("category", currentCategory);

        fetch(contextPath + "/api/products/filter?" + params.toString())
            .then(r => r.json())
            .then(renderProducts)
            .catch(err => console.error("FILTER ERROR", err));
    }

    function renderProducts(list) {
        const grid = document.getElementById("productGrid");
        grid.innerHTML = "";

        if (!list || list.length === 0) {
            grid.innerHTML = "<p>Không có sản phẩm phù hợp</p>";
            return;
        }

        list.forEach(p => {
            const img = (p.images && p.images.length > 0)
                ? p.images[0]
                : "https://via.placeholder.com/300x300?text=No+Image";

            grid.innerHTML +=
                '<div class="product-card">' +

                '<img src="' + img + '" alt="' + p.name + '">' +

                '<h3>' + p.name + '</h3>' +

                '<div class="product-rating">' +
                '<span>' +
                (p.avgRating ? p.avgRating.toFixed(1) : '0.0') +
                ' <i class="fa fa-star"></i> (' +
                (p.ratingCount || 0) +
                ')' +
                '</span>' +
                '</div>'
                +

                '<div class="product-price">' +
                Number(p.price).toLocaleString() + ' đ' +
                '</div>' +

                '<div class="card-footer">' +
                '<button class="buy-btn">Chi tiết</button>' +
                '<button class="add-cart-btn"><i class="bi bi-cart-plus"></i></button>' +
                '<button class="wishlist-btn"><i class="bi bi-heart"></i></button>' +
                '</div>' +

                '</div>';
        });
    }

</script>
<script>
    // Nút Lọc
    document.getElementById("filterBtn").addEventListener("click", loadProducts);

    // Tab category
    document.querySelectorAll(".tab-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            document.querySelector(".tab-btn.active")?.classList.remove("active");
            this.classList.add("active");

            const slug = this.dataset.category;
            currentCategory = (slug === "all") ? "" : mapCategory[slug];
            loadProducts();
        });
    });

    // (Tuỳ chọn) Enter để tìm
    document.getElementById("searchInput").addEventListener("keydown", e => {
        if (e.key === "Enter") loadProducts();
    });
</script>


</body>

</html>
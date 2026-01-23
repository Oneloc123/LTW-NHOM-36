<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/footer.css">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/cart.css">

</head>
<body>
<header class="header-scope navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
    <div class="container">
        <!-- Logo -->
        <a class="navbar-brand d-flex align-items-center fw-bold text-primary" href="/index.jsp">
            <i class="bi bi-camera fs-4 me-2"></i>
            <span>TechX</span>
        </a>

        <!-- Toggle (mobile) -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list fs-2 text-primary"></i>
        </button>

        <!-- Nav links -->
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-lg-center gap-lg-3">
                <li class="nav-item"><a class="nav-link " href="/home">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="../pages/shop.html">Cửa hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pages/products.html">Sản phẩm</a></li>


                <li class="nav-item"><a class="nav-link" href="../pages/blog.html">Blog</a></li>
                <li class="nav-item"><a class="nav-link" href="../pages/contact.html">Liên hệ</a></li>
                <li class="nav-item"><a class="nav-link" href="order-history.jsp">Đơn hàng</a></li>
                 <!-- Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            Tài khoản
                        </a>
                        <ul class="dropdown-menu border-0 shadow rounded-3" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="/pages/profile.jsp">Thông tin tài khoản</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="../pages/wishList.html">Danh sách sản phẩm yêu thích</a></li>
                            <li><a class="dropdown-item" href="../pages/notification.html">Xem thông báo</a></li>
                            <li><a class="dropdown-item" href="../pages/viewed-product.html">Sản phẩm đã xem</a>
                            </li>

                        </ul>
                    </li>
            </ul>

            <!-- Login & Cart -->
            <div class="ms-lg-3 mt-3 mt-lg-0 d-flex align-items-center gap-2">
                <a href="/pages/login.jsp" class="btn btn-outline-primary btn-sm d-flex align-items-center">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                </a>
                <a href="/pages/cart.html" class="btn btn-primary btn-sm d-flex align-items-center">
                    <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                </a>
            </div>
        </div>
    </div>
</header>

<!-- ===== CONTENT ===== -->
<!-- EMPTY CART -->
<c:if test="${empty cartItems}">
    <div class="alert alert-info">
        Giỏ hàng của bạn đang trống.
    </div>
</c:if>

<div class="row g-4">
    <!-- CART LIST -->
    <div class="col-lg-8">

        <c:set var="subtotal" value="0"/>

        <c:forEach var="item" items="${cartItems}">
            <div class="card mb-3">
                <div class="card-body d-flex justify-content-between align-items-center">

                    <div class="d-flex align-items-center">
                        <img src="${item.image}" width="80" class="me-3">
                        <div>
                            <h6 class="mb-1">${item.name}</h6>
                            <small class="text-muted">
                                Giá: ${item.price} ₫
                            </small>
                        </div>
                    </div>

                    <div class="d-flex align-items-center">
                        <!-- UPDATE -->
                        <form action="${pageContext.request.contextPath}/cart-update"
                              method="post" class="me-2">
                            <input type="hidden" name="productId" value="${item.productId}">
                            <input type="number"
                                   name="quantity"
                                   value="${item.quantity}"
                                   min="1"
                                   class="form-control text-center"
                                   style="width:70px"
                                   onchange="this.form.submit()">
                        </form>

                        <!-- REMOVE -->
                        <a href="${pageContext.request.contextPath}/cart-remove?productId=${item.productId}"
                           class="btn btn-outline-danger">
                            <i class="bi bi-trash"></i>
                        </a>
                    </div>
                </div>
            </div>

            <c:set var="subtotal" value="${subtotal + item.total}"/>
        </c:forEach>

    </div>

    <!-- SUMMARY -->
    <div class="col-lg-4">
        <div class="card">
            <div class="card-body">
                <h5>Tổng kết đơn hàng</h5>

                <div class="d-flex justify-content-between mb-2">
                    <span>Tạm tính:</span>
                    <strong>${subtotal} ₫</strong>
                </div>

                <div class="d-flex justify-content-between mb-2">
                    <span>Vận chuyển:</span>
                    <span>Miễn phí</span>
                </div>

                <hr>

                <div class="d-flex justify-content-between mb-3">
                    <strong>Tổng cộng:</strong>
                    <strong class="text-danger">${subtotal} ₫</strong>
                </div>

                <c:if test="${not empty cartItems}">
                    <form action="${pageContext.request.contextPath}/checkout" method="post">
                        <button type="submit" class="btn btn-primary w-100">
                            Thanh toán
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</div>
</div>

<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container">
        <div class="row gy-4">
            <!-- Logo + Giới thiệu -->
            <div class="col-md-4">
                <a href="/index.jsp" class="d-flex align-items-center mb-3 text-decoration-none">
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
                    <li><a href="/pages/forgot-password.jsp" class="footer-link">Quên mật khẩu</a></li>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.querySelector(".btn-checkout").addEventListener("click", function () {
    window.location.href = "checkout.jsp"; // trang bạn muốn chuyển tới
});
</script>


</body>
</html>

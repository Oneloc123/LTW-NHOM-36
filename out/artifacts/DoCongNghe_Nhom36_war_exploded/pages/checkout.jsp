<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thanh toán - TechX</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/footer.css">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/checkout.css">
    <link rel="stylesheet" href="../assets/css/footer.css">
    <link rel="stylesheet" href="../assets/css/header.css">

</head>


<body class="bg-light">

<!-- ================= Header ================= -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<form action="${pageContext.request.contextPath}/checkout" method="post">
    <div class="container checkout-container mt-4">
        <div class="row g-4">

            <!-- LEFT -->
            <div class="col-lg-8">

                <!-- THÔNG TIN NGƯỜI NHẬN -->
                <div class="checkout-box mb-4">
                    <h5 class="section-title">
                        <i class="bi bi-person-circle me-2"></i>Thông tin người nhận
                    </h5>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <input name="fullName" class="form-control"
                                   value="${sessionScope.user.fullName}" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input name="phone" class="form-control"
                                   value="${sessionScope.user.phone}" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Địa chỉ</label>
                            <input name="address" class="form-control"
                                   value="${sessionScope.user.address}" required>
                        </div>
                    </div>
                </div>

                <!-- GIAO HÀNG -->
                <div class="checkout-box mb-4">
                    <h5 class="section-title">
                        <i class="bi bi-truck me-2"></i>Phương thức giao hàng
                    </h5>
                    <select name="shippingMethod" class="form-select">
                        <option value="STANDARD">Giao tiêu chuẩn (Miễn phí)</option>
                        <option value="FAST">Giao nhanh (+30.000đ)</option>
                    </select>
                </div>

                <!-- THANH TOÁN -->
                <div class="checkout-box mb-4">
                    <h5 class="section-title">
                        <i class="bi bi-credit-card me-2"></i>Hình thức thanh toán
                    </h5>
                    <select name="paymentMethod" class="form-select">
                        <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                        <option value="BANK">Chuyển khoản ngân hàng</option>
                        <option value="EWALLET">Ví điện tử</option>
                    </select>
                </div>

                <!-- GHI CHÚ -->
                <div class="checkout-box mb-4">
                    <h5 class="section-title">
                        <i class="bi bi-pencil-square me-2"></i>Ghi chú
                    </h5>
                    <textarea name="note" class="form-control" rows="3"></textarea>
                </div>
            </div>

            <!-- RIGHT -->
            <div class="col-lg-4">
                <div class="summary-box">
                    <h5 class="section-title">
                        <i class="bi bi-receipt me-2"></i>Đơn hàng
                    </h5>

                    <c:if test="${empty sessionScope.cart}">
                        <p class="text-muted">Giỏ hàng trống</p>
                    </c:if>

                    <c:forEach items="${sessionScope.cart}" var="item">
                        <div class="product-item d-flex justify-content-between mb-2">
                            <div class="d-flex gap-2">
                                <img src="${item.image}" width="50">
                                <div>
                                    <div class="fw-semibold">${item.name}</div>
                                    <small>x${item.quantity}</small>
                                </div>
                            </div>
                            <div class="fw-bold text-danger">
                                <fmt:formatNumber value="${item.total}" type="currency" currencySymbol="₫"/>
                            </div>
                        </div>
                    </c:forEach>

                    <hr>

                    <div class="d-flex justify-content-between">
                        <span>Tạm tính</span>
                        <span class="fw-bold">
                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/>
                    </span>
                    </div>

                    <div class="d-flex justify-content-between">
                        <span>Phí vận chuyển</span>
                        <span class="text-success">Miễn phí</span>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between fs-5 fw-bold">
                        <span>Tổng cộng</span>
                        <span class="text-danger">
                        <fmt:formatNumber value="${total}" type="currency" currencySymbol="₫"/>
                    </span>
                    </div>

                    <button type="submit" class="btn btn-danger w-100 mt-3">
                        <i class="bi bi-shield-check me-2"></i>Thanh toán
                    </button>
                </div>
            </div>

        </div>
    </div>
</form>
<!-- ================= Footer ================= -->
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

</body>

</html>
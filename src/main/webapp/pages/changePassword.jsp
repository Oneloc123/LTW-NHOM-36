<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
</head>

<body class="bg-light">

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-7">

            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-body p-4">

                    <h3 class="fw-bold text-primary mb-3 text-center">
                        <i class="bi bi-shield-lock"></i> Đổi mật khẩu
                    </h3>

                    <!-- ALERT -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <c:if test="${not empty success}">
                        <div class="alert alert-success">${success}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/changePassword" method="post">

                        <!-- OLD PASSWORD -->
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu cũ</label>
                            <input type="password" name="oldPass"
                                   class="form-control"
                                   placeholder="Nhập mật khẩu cũ" required>
                        </div>

                        <!-- NEW PASSWORD -->
                        <div class="mb-3">
                            <label class="form-label">Mật khẩu mới</label>
                            <input type="password" name="newPass"
                                   class="form-control"
                                   placeholder="Ít nhất 8 ký tự" required>
                        </div>

                        <!-- SEND OTP -->
                        <div class="mb-3">
                            <button type="submit"
                                    formaction="${pageContext.request.contextPath}/send-otp"
                                    class="btn btn-outline-primary w-100">
                                <i class="bi bi-envelope"></i> Gửi mã xác thực qua email
                            </button>
                        </div>

                        <!-- OTP -->
                        <div class="mb-3">
                            <label class="form-label">Mã xác thực (OTP)</label>
                            <input type="text" name="otp"
                                   class="form-control"
                                   placeholder="Nhập mã từ email" required>
                        </div>

                        <button class="btn btn-primary w-100 py-2">
                            <i class="bi bi-check-circle"></i> Xác nhận đổi mật khẩu
                        </button>

                    </form>
                </div>
            </div>

        </div>
    </div>
</main>

<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container">
        <div class="row gy-4">

            <div class="col-md-4">
                <a href="/index.jsp" class="d-flex align-items-center text-decoration-none mb-3">
                    <i class="bi bi-camera fs-3 text-primary me-2"></i>
                    <span class="fw-bold fs-5 text-primary">TechX</span>
                </a>
                <p class="text-muted">
                    Nơi bạn tìm thấy những thiết bị công nghệ độc đáo, hiện đại và sáng tạo.
                </p>
            </div>

            <div class="col-md-2">
                <h6 class="fw-bold text-uppercase mb-3">Danh mục</h6>
                <ul class="list-unstyled">
                    <li><a href="/pages/products.html#mini-tech" class="footer-link">Công nghệ mini</a></li>
                    <li><a href="/pages/products.html#ai-device" class="footer-link">Thiết bị AI</a></li>
                    <li><a href="/pages/products.html#creative" class="footer-link">Phụ kiện sáng tạo</a></li>
                    <li><a href="/pages/products.html#fun-tech" class="footer-link">Đồ chơi công nghệ</a></li>
                </ul>
            </div>

            <div class="col-md-2">
                <h6 class="fw-bold text-uppercase mb-3">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="/pages/contact.html" class="footer-link">Liên hệ</a></li>
                    <li><a href="/pages/forgot-password.jsp" class="footer-link">Quên mật khẩu</a></li>
                    <li><a href="/pages/order-history.jsp" class="footer-link">Theo dõi đơn hàng</a></li>
                    <li><a href="/pages/404.html" class="footer-link">Trung tâm trợ giúp</a></li>
                </ul>
            </div>

            <div class="col-md-4">
                <h6 class="fw-bold text-uppercase mb-3">Liên hệ</h6>
                <p><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP.HCM</p>
                <p><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
                <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@htcamera.vn</p>
            </div>

        </div>

        <hr />

        <div class="text-center small text-muted">
            © 2025 <strong>TechX</strong>. All rights reserved.
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

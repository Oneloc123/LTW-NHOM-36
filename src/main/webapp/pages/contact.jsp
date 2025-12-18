<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên hệ - TechX</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/contact.css">
</head>

<body>

<!-- ================= HEADER ================= -->
<header class="header-scope navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center fw-bold text-primary"
           href="${pageContext.request.contextPath}/index.jsp">
            <i class="bi bi-camera fs-4 me-2"></i>
            <span>TechX</span>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <i class="bi bi-list fs-2 text-primary"></i>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav align-items-lg-center gap-lg-3">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/orders">Đơn hàng</a>
                </li>
            </ul>

            <div class="ms-lg-3 mt-3 mt-lg-0 d-flex align-items-center gap-2">
                <a href="${pageContext.request.contextPath}/login"
                   class="btn btn-outline-primary btn-sm">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                </a>
                <a href="${pageContext.request.contextPath}/cart"
                   class="btn btn-primary btn-sm">
                    <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                </a>
            </div>
        </div>
    </div>
</header>

<!-- ================= MAIN ================= -->
<main class="contact-page container my-5">
    <h2 class="mb-4 text-center">Liên hệ với chúng tôi</h2>

    <!-- THÔNG BÁO THÀNH CÔNG -->
    <c:if test="${not empty success}">
        <div class="alert alert-success text-center">
                ${success}
        </div>
    </c:if>

    <div class="row g-5">

        <!-- FORM LIÊN HỆ -->
        <div class="col-lg-6">
            <div class="card contact-form p-4">
                <h5>Gửi tin nhắn</h5>

                <form action="/DoCongNghe_Nhom36_war/contact" method="post">
                    <div class="mb-3">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nội dung</label>
                        <textarea class="form-control" name="message" rows="5" required></textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">
                        Gửi tin nhắn
                    </button>
                </form>
            </div>
        </div>

        <!-- THÔNG TIN LIÊN HỆ -->
        <div class="col-lg-6">
            <div class="contact-info">
                <h5>Thông tin liên hệ</h5>
                <p><i class="bi bi-geo-alt-fill"></i> 123 Nguyễn Huệ, Quận 1, TP.HCM</p>
                <p><i class="bi bi-telephone-fill"></i> +84 987 654 321</p>
                <p><i class="bi bi-envelope-fill"></i> support@techx.vn</p>
                <p><i class="bi bi-clock-fill"></i> Thứ 2 - Thứ 6: 8:00 - 17:00</p>
            </div>
        </div>

    </div>
</main>

<!-- ================= FOOTER ================= -->
<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container text-center small text-muted">
        © 2025 <strong>TechX</strong>. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

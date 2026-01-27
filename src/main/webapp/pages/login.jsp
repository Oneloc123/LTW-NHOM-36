<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset='utf-8'>
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <title>Login</title>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/footer.css">
    <link rel="stylesheet" href="../assets/css/header.css">
  <link rel='stylesheet' type='text/css' media='screen' href="../assets/css/login.css">
  

</head>

<body>
<!-- ================= Header ================= -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="login-page">
    <main>
        <div class="login-card">
            <h2>Đăng nhập TechX</h2>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <%
                    if (request.getAttribute("message") != null) {
                %>
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <div>
                        ${message}
                    </div>
                </div>
                <%
                    }
                %>
                <div class="mb-3 text-start">
                    <label for="username" class="form-label">Tài khoản</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Nhập tài khoản">
                </div>
                <div class="mb-3 text-start">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" class="form-control" id="password" name="password"
                           placeholder="Nhập mật khẩu">
                </div>

        <button type="submit" class="btn btn-primary">Đăng nhập</button>


        <div class="footer-links mt-3">
          <a href="/DoCongNghe_Nhom36_war/forgot-password">Quên mật khẩu?</a> |
          <a href="../register">Tạo tài khoản mới</a>
        </div>
      </form>
    </div>


  </main>
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
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</div>
</body>

</html>
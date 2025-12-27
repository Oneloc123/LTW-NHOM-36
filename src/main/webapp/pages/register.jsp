<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="vi">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Đăng ký</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/style.css">
  <link rel="stylesheet" href="../assets/css/register.css">
  <link rel="stylesheet" href="../assets/css/header.css">
  <link rel="stylesheet" href="../assets/css/footer.css">
  <link rel='stylesheet' type='text/css' media='screen' href='login.css'>
  <style>
    body {
      background: linear-gradient(135deg, #e8f0ff, #f6faff);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    header .container {}

    main {
      margin-top: 50px;
      width: 1500px;
    }

    /* main .container {
        max-width:  960px;
      } */
    .card {
      background-color: white;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    }

    .card2{
      margin-top: 20px;
    }
    .form-control {
      border-radius: 8px;
    }

    .btn-primary {
      border-radius: 8px;
      background-color: #007bff;
      border: none;
      font-weight: 500;
    }

    .btn-primary:hover {
      background-color: #0069d9;
    }

    .summary-card {
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      padding: 20px;
    }

    h2 {
      color: #007bff;
      font-weight: 600;
    }
    .footer-links{
      display: flex;
      justify-content: center;
      gap:10px;
    }
  </style>
</head>

<body>
  <!-- ================= Header ================= -->
  <header class="header-scope navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
    <div class="container">
      <!-- Logo -->
      <a class="navbar-brand d-flex align-items-center fw-bold text-primary" href="/DoCongNghe_Nhom36_war/home">
        <i class="bi bi-camera fs-4 me-2"></i>
        <span>TechX</span>
      </a>
    </div>
  </header>
  
  <main>
    <div class="container">
      <h2 class="text-center mb-2">Tạo Tài Khoản</h2>
      <p class="text-center text-muted mb-4">Điền thông tin để đăng ký tài khoản mới</p>
      <div class="row g-4">
        <!-- Form tạo tài khoản -->
        <div class="card-center" style="margin-left: 18%; width: 60%;">
          <div class="card p-4">
            <h5 class="fw-bold mb-3">Tạo tài khoản TechX</h5>
            <ul class="list-unstyled text-muted" style="margin-bottom: 5px;">
              <li class="mb-2">Tham gia cộng đồng những người mê đồ công nghệ độc lạ nhận thông báo ưu đãi & sản phẩm
                hiếm.</li>
            </ul>
            <div class="divider"></div>

            <div style="display:flex;gap:12px;align-items:center;margin-bottom:12px">
              <button class="btn btn-primary" style="flex:1"><i class="bi bi-google" style="margin-right: 15px;"></i>Đăng ký bằng Google</button>
              <button class="btn btn-primary" style="flex:1"><i class="bi bi-facebook "style="margin-right: 15px;"></i>Đăng ký bằng Facebook</button>
            </div>
            <form action="/DoCongNghe_Nhom36_war//register" method="post">
              <div class="row">
                <div class="mb-3 col">
                  <label for="firstname" class="form-label">Họ </label>
                  <input type="text" class="form-control" name="firstName" id="firstname" placeholder="Nhập họ của bạn" required>
                </div>
                <div class="mb-3 col">
                  <label for="lastname" class="form-label">Tên và tên đệm</label>
                  <input type="text" class="form-control" name="lastName" id="lastname" placeholder="Nhập Tên và tên đệm" required>
                </div>
              </div>
              <div class="mb-3 ">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" name="email" id="email" placeholder="Nhập địa chỉ email" required>
              </div>
              <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="tel" class="form-control" name="phone" id="phone" placeholder="Nhập số điện thoại" required>
              </div>
                <div class="mb-3 col">
                    <label for="fullname" class="form-label">Tên đăng nhập</label>
                    <input type="text" class="form-control" name="userName" id="fullname" placeholder="Nhập tên đăng nhập của bạn" required>
                </div>
              <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control" id="password" placeholder="Nhập mật khẩu" required>
              </div>
              <div class="mb-3">
                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
                <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" placeholder="Nhập lại mật khẩu"
                  required>
              </div>
              <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="agree">
                <label class="form-check-label" for="agree">Tôi đồng ý với <a href="#">điều khoản sử dụng</a></label>
              </div>
              <button type="submit" class="btn btn-primary w-100 py-2" >Đăng ký tài khoản</button>
               <div class="footer-links mt-3">
                 <a href="/DoCongNghe_Nhom36_war/login">Đăng nhập</a> |
                 <a href="/DoCongNghe_Nhom36_war/forgot-password">Quên mật khẩu ?</a>
               </div>
            </form>
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
  <script src="../assets/js/main.js"></script>
</body>

</html>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChangPassword</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/footer.css">

    <style>
        body {
             background-color: #f4f6f9;

            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        main .container {

            margin-top: 50px;
        }

        .summary-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            padding: 20px;
        }

        .card2 {
            margin-top: 20px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .btn {
            margin: 5px;
        }

        input {
            
        }

        .form1 {
            width: 100px;
        }

        .btn1 {
            margin-top: 15px;
        }

        .col1 {
            max-width: 640px;
            border-radius: 30px;
            max-height: 50px;
        }

        .col2 {
            max-width: 180px;
            height: 50px;
            margin-top: -1px;
        }

        .bi {
            margin-right: 10px;
        }

        .form1 {
            border-radius: 20px;
            width: 242px;
        }
    </style>
</head>

<body>
  <!-- ================= Header ================= -->
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
          <li class="nav-item"><a class="nav-link  " href="/index.jsp">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link " href="/pages/shop.html">Cửa hàng</a></li>
                        <li class="nav-item"><a class="nav-link" href="/pages/products.html">Sản phẩm</a></li>


          <li class="nav-item"><a class="nav-link" href="/pages/blog.html">Blog</a></li>
          <li class="nav-item"><a class="nav-link" href="/pages/contact.html">Liên hệ</a></li>
          <li class="nav-item"><a class="nav-link " href="/pages/order-history.jsp">Đơn hàng</a></li>
          <!-- Dropdown -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
              aria-expanded="false">
              Tài khoản
            </a>
            <ul class="dropdown-menu border-0 shadow rounded-3" aria-labelledby="navbarDropdown">
              <li><a class="dropdown-item" href="/pages/profile.jsp">Thông tin tài khoản</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="wishList.html">Danh sách sản phẩm yêu thích</a></li>
              <li><a class="dropdown-item" href="notification.html">Xem thông báo</a></li>
              <li><a class="dropdown-item" href="viewed-product.html">Sản phẩm đã xem</a>
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



    <main>
        <div class="container">
            <!-- HERO -->
            <section class="hero">
                <div class="hero-box">
                    <h1 class="hero-title" style="font-size: 2.6rem;font-weight: 700;color: #004a99; margin-bottom: 50px;">Đổi mật khẩu TechX</h1>
                    <p class="hero-subtitle"></p>
                </div>
            </section>
            <div class="row g-4">
                <!-- Form đổi mật khẩu -->
                <div class="col-md-8 ">
                    <div class="card p-4">
                        <h5 class="fw-bold mb-3">Đổi mật khẩu TechX</h5>
                        <hr>
                        <form>
                            <div class="row" style="margin-bottom: -10px;">
                                <div class="mb-5 col-6">
                                    <label for="password" class="form-label">Mật khẩu cũ</label>
                                    <input type="password" class="form1 form-control" id="oldPassword" style="width: 300px;"
                                        placeholder="Nhập mật khẩu cũ" required>
                                </div>
                                <div class="mb-5 col-6">
                                    <label for="password" class="form-label">Mật khẩu mới</label>
                                    <input type="password" class="form1 form-control" id="newPassword" style="width: 300px;"
                                        placeholder="Nhập mật khẩu mới" required>
                                </div>
                            </div>

                            <button type="button" style="margin-bottom: 30px;"
                                class="btn btn btn-white btn-outline-primary  border -primary w-100 py-2">Gửi
                                liên kết đến email để đặt lại
                                mật khẩu</button>
                            <hr>
                            <div class="mb-3">
                                <label for="otp" class="form-label" >Mã xác nhận từ email</label>
                                <div class="row">
                                    <input type="text" class="col1 form-control col  " id="otp" style="width: 600px;"
                                        placeholder="Nhập mã xác nhận từ email">
                                    <button type="button"
                                        class="col2 btn col btn-white btn-outline-primary border -primary "><i
                                            class="bi bi-arrow-clockwise"></i></i>Gửi lại</button>
                                </div>
                                <button type="submit" class="btn1 btn btn-primary w-100 py-2">xác nhận đổi mật
                                    khẩu</button>
                            </div>

                            <div class="footer-links mt-3">
                                <a href="forgot-password.jsp">Quên mật khẩu ?</a> |
                                <a href="/pages/register.jsp">Tạo tài khoản mới</a>
                            </div>

                        </form>
                    </div>
                </div>

                <!-- Tóm tắt lợi ích hoặc hướng dẫn -->
                <div class="col-md-4" style="margin-top: 3px;">
                    <div class="summary-card card2">
                        <h5 class="fw-bold mb-3">Lưu ý bảo mật</h5>
                        <ol class="text-muted small">
                            <li class="mb-2">Không chia sẽ mật khẩu cho người lạ.</li>
                            <li class="mb-2">Mật khẩu nên có ít nhất 8 ký tự, gồm chữ, số và ký hiệu.</li>
                            <li class="mb-2">Liên hệ hỗ trợ nếu có bất ký sai sót nào.</li>
                        </ol>
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
                    <p class="mb-1"><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP. Hồ Chí
                        Minh
                    </p>
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
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</html>
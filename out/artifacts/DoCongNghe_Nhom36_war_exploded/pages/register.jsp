<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        header .container {
        }

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

        .card2 {
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

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
    </style>
</head>

<body>
<!-- ================= Header ================= -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

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
                        <li class="mb-2">Tham gia cộng đồng những người mê đồ công nghệ độc lạ nhận thông báo ưu đãi &
                            sản phẩm
                            hiếm.
                        </li>
                    </ul>
                    <div class="divider"></div>

                    <div style="display:flex;gap:12px;align-items:center;margin-bottom:12px">
                        <button class="btn btn-primary" style="flex:1"><i class="bi bi-google"
                                                                          style="margin-right: 15px;"></i>Đăng ký bằng
                            Google
                        </button>
                        <button class="btn btn-primary" style="flex:1"><i class="bi bi-facebook "
                                                                          style="margin-right: 15px;"></i>Đăng ký bằng
                            Facebook
                        </button>
                    </div>
                    <form action="../register" method="post" id="registerForm" novalidate>
                        <%
                            if (request.getAttribute("error")!=null) {
                        %>
                        <div class="alert alert-danger d-flex align-items-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <div>
                                ${error}
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <div class="mb-3">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" name="fullName" id="fullName">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input type="text" class="form-control" name="address" id="address">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" id="email">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="tel" class="form-control" name="phone" id="phone">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tên đăng nhập</label>
                            <input type="text" class="form-control" name="userName" id="username">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" name="password" id="password">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Xác nhận mật khẩu</label>
                            <input type="password" class="form-control" name="confirmPassword" id="confirmPassword">
                            <div class="invalid-feedback"></div>
                        </div>

                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" id="agree">
                            <label class="form-check-label">Tôi đồng ý điều khoản</label>
                            <div class="invalid-feedback d-block"></div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Đăng ký tài khoản</button>
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
<script>
    const form = document.getElementById("registerForm");

    function setError(input, message) {
        input.classList.add("is-invalid");
        input.nextElementSibling.innerText = message;
    }

    function clearError(input) {
        input.classList.remove("is-invalid");
        input.nextElementSibling.innerText = "";
    }

    form.addEventListener("submit", function (e) {
        e.preventDefault();
        let valid = true;

        const fullName = document.getElementById("fullName");
        const address = document.getElementById("address");
        const email = document.getElementById("email");
        const phone = document.getElementById("phone");
        const username = document.getElementById("username");
        const password = document.getElementById("password");
        const confirmPassword = document.getElementById("confirmPassword");
        const agree = document.getElementById("agree");

        // reset lỗi
        [fullName, address, email, phone, username, password, confirmPassword]
            .forEach(clearError);
        agree.nextElementSibling.nextElementSibling.innerText = "";

        if (fullName.value.trim().length < 3) {
            setError(fullName, "Họ và tên phải ít nhất 3 ký tự");
            valid = false;
        }

        if (address.value.trim() === "") {
            setError(address, "Địa chỉ không được để trống");
            valid = false;
        }

        if (!/^\S+@\S+\.\S+$/.test(email.value)) {
            setError(email, "Email không hợp lệ");
            valid = false;
        }

        if (!/^0\d{9}$/.test(phone.value)) {
            setError(phone, "Số điện thoại phải 10 số và bắt đầu bằng 0");
            valid = false;
        }

        if (username.value.trim().length < 5) {
            setError(username, "Tên đăng nhập phải ít nhất 5 ký tự");
            valid = false;
        }

        if (password.value.length < 6) {
            setError(password, "Mật khẩu phải ít nhất 6 ký tự");
            valid = false;
        }

        if (password.value !== confirmPassword.value) {
            setError(confirmPassword, "Mật khẩu xác nhận không khớp");
            valid = false;
        }

        if (!agree.checked) {
            agree.nextElementSibling.nextElementSibling.innerText =
                "Bạn phải đồng ý điều khoản sử dụng";
            valid = false;
        }

        if (valid) {
            form.submit();
        }
    });
</script>
</body>
</html>
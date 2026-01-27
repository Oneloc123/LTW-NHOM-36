<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhập mã OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card shadow">
                <div class="card-body">

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
                    <h4 class="text-center mb-3">Xác thực OTP</h4>
                    <div id="otpMessage" class="text-center mt-2"></div>
                    <div class="text-center mt-3">
                        <a href="#" id="resendOtp" class="text-decoration-none">
                            Gửi lại mã OTP
                        </a>
                    </div>

                    <form action="/send-otp-forLogin" method="post">
                        <div class="mb-3">
                            <label class="form-label">Mã OTP</label>
                            <input type="text"
                                   name="otp"
                                   class="form-control text-center"
                                   maxlength="6"
                                   placeholder="Nhập 6 số OTP"
                                   required>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">
                            Xác nhận
                        </button>
                    </form>

                    <%
                        if (request.getAttribute("error") != null) {
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

                </div>
            </div>
        </div>
    </div>
</div>
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
</body>
<script>
    document.getElementById("resendOtp").addEventListener("click", function (e) {
        e.preventDefault();

        fetch("<%=request.getContextPath()%>/send-otp-forLogin?ajax=true")
            .then(response => response.json())
            .then(data => {
                const msgDiv = document.getElementById("otpMessage");
                msgDiv.innerHTML = data.message;
                msgDiv.className = data.status === "success"
                    ? "text-success"
                    : "text-danger";
            })
            .catch(() => {
                alert("Có lỗi xảy ra, vui lòng thử lại!");
            });
    });
</script>
</html>

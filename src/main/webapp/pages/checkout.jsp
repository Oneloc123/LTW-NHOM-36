<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <header class="header-scope navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
        <div class="container">
            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center fw-bold" href="/index.jsp">
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
                <li class="nav-item"><a class="nav-link" href="profile.jsp">Tài khoản</a></li>
            </ul>

            <!-- Login & Cart -->
            <div class="ms-lg-3 mt-3 mt-lg-0 d-flex align-items-center gap-2">
                <a href="login.jsp" class="btn btn-outline-primary btn-sm d-flex align-items-center">
                    <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                </a>
                <a href="cart.jsp" class="btn btn-primary btn-sm d-flex align-items-center">
                    <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                </a>
            </div>
        </div>
    </div>
</header>


<div class="container checkout-container">
    <div class="row g-4">
        <!-- LEFT COLUMN -->
        <div class="col-lg-8">

            <!-- THÔNG TIN NGƯỜI NHẬN -->
            <div class="checkout-box mb-4">
                <h4 class="section-title"><i class="bi bi-person-circle me-2"></i>Thông tin người nhận</h4>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Họ và tên</label>
                        <input type="text" class="form-control" placeholder="Nguyễn Văn A">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại</label>
                        <input type="text" class="form-control" placeholder="0123 456 789">
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" class="form-control" placeholder="Số nhà, đường, phường/xã, quận/huyện">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Tỉnh/Thành</label>
                        <select class="form-select">
                            <option>TP. Hồ Chí Minh</option>
                            <option>Hà Nội</option>
                            <option>Đà Nẵng</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Quận/Huyện</label>
                        <select class="form-select">
                            <option>Quận 1</option>
                            <option>Quận 7</option>
                            <option>Thủ Đức</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- PHƯƠNG THỨC NHẬN HÀNG -->
            <div class="checkout-box mb-4">
                <h4 class="section-title"><i class="bi bi-truck me-2"></i>Phương thức giao hàng</h4>
                <select class="form-select">
                    <option>Giao tiêu chuẩn (Miễn phí)</option>
                    <option>Giao nhanh trong 2h (+30.000đ)</option>
                    <option>Nhận tại cửa hàng</option>
                </select>
            </div>

            <!-- HÌNH THỨC THANH TOÁN -->
            <div class="checkout-box mb-4">
                <h4 class="section-title"><i class="bi bi-credit-card me-2"></i>Hình thức thanh toán</h4>
                <select class="form-select">
                    <option>Thanh toán khi nhận hàng (COD)</option>
                    <option>Chuyển khoản ngân hàng</option>
                    <option>Ví điện tử (Momo / ZaloPay)</option>
                    <option>Thẻ tín dụng / Ghi nợ</option>
                </select>
            </div>

            <!-- GHI CHÚ -->
            <div class="checkout-box mb-4">
                <h4 class="section-title"><i class="bi bi-pencil-square me-2"></i>Ghi chú đơn hàng</h4>
                <textarea class="form-control" rows="3" placeholder="VD: Giao buổi sáng, gọi trước khi đến..."></textarea>
            </div>
        </div>

        <!-- RIGHT COLUMN: ORDER SUMMARY -->
        <div class="col-lg-4">
            <div class="summary-box">
                <h4 class="section-title"><i class="bi bi-receipt me-2"></i>Tổng kết đơn hàng</h4>

                <!-- SP 1 -->
                <div class="product-item">
                    <div class="d-flex align-items-center gap-3">
                        <img src="../assets/img/Cart/4urpc.png" alt="">
                        <div>
                            <div class="fw-semibold">Sạc 4URPC</div>
                            <div class="text-muted small">x1</div>
                        </div>
                    </div>
                    <div class="fw-bold highlight">999.000đ</div>
                </div>

                <!-- SP 2 -->
                <div class="product-item">
                    <div class="d-flex align-items-center gap-3">
                        <img src="../assets/img/Cart/ChargeStick.png" alt="">
                        <div>
                            <div class="fw-semibold">ChargeStick</div>
                            <div class="text-muted small">x1</div>
                        </div>
                    </div>
                    <div class="fw-bold highlight">1.290.000đ</div>
                </div>

                <!-- SP 3 -->
                <div class="product-item">
                    <div class="d-flex align-items-center gap-3">
                        <img src="../assets/img/Cart/dônmo.png" alt="">
                        <div>
                            <div class="fw-semibold">AquaCam</div>
                            <div class="text-muted small">x1</div>
                        </div>
                    </div>
                    <div class="fw-bold highlight">3.990.000đ</div>
                </div>

                <!-- SP 4 -->
                <div class="product-item">
                    <div class="d-flex align-items-center gap-3">
                        <img src="../assets/img/Cart/nimo.png" alt="">
                        <div>
                            <div class="fw-semibold">Robot Nimo</div>
                            <div class="text-muted small">x1</div>
                        </div>
                    </div>
                    <div class="fw-bold highlight">8.590.000đ</div>
                </div>

                <!-- TOTAL -->
                <div class="d-flex justify-content-between mt-3">
                    <span class="fw-semibold">Tạm tính:</span>
                    <span class="highlight">14.869.000đ</span>
                </div>
                <div class="d-flex justify-content-between mt-2">
                    <span class="fw-semibold">Phí vận chuyển:</span>
                    <span class="text-success fw-bold">Miễn phí</span>
                </div>

                <hr>

                <div class="d-flex justify-content-between fs-5 fw-bold mb-3">
                    <span>Tổng cộng:</span>
                    <span class="highlight">14.869.000đ</span>
                </div>

                <button class="btn-checkout"><i class="bi bi-shield-check me-2"></i>Thanh toán ngay</button>
            </div>
        </div>

    </div>
</div>
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
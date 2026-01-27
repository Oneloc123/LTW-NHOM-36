<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .success-icon {
            font-size: 5rem;
            color: #28a745;
        }
        .order-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-5 mb-5">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">
            <div class="card border-success shadow">
                <div class="card-body text-center p-5">
                    <div class="mb-4">
                        <i class="bi bi-check-circle-fill success-icon"></i>
                    </div>

                    <h1 class="card-title mb-3 text-success">Đặt hàng thành công!</h1>

                    <p class="card-text mb-4 fs-5">
                        Cảm ơn bạn đã đặt hàng. Đơn hàng của bạn đã được tiếp nhận và đang được xử lý.
                    </p>

                    <div class="order-summary mb-4 text-start">
                        <h5 class="mb-3"><i class="bi bi-info-circle me-2"></i>Thông tin đơn hàng</h5>
                        <div class="row">
                            <div class="col-md-6 mb-2">
                                <strong>Mã đơn hàng:</strong>
                            </div>
                            <div class="col-md-6 mb-2">
                                <span class="badge bg-primary fs-6">#${order.id}</span>
                            </div>

                            <div class="col-md-6 mb-2">
                                <strong>Ngày đặt:</strong>
                            </div>
                            <div class="col-md-6 mb-2">
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>

                            <div class="col-md-6 mb-2">
                                <strong>Tổng tiền:</strong>
                            </div>
                            <div class="col-md-6 mb-2">
                                <span class="fw-bold text-danger">
                                    <fmt:formatNumber value="${order.totalAmount}"
                                                      type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </span>
                            </div>

                            <div class="col-md-6 mb-2">
                                <strong>Trạng thái:</strong>
                            </div>
                            <div class="col-md-6 mb-2">
                                <span class="badge bg-warning">${order.statusDisplay}</span>
                            </div>

                            <div class="col-md-6 mb-2">
                                <strong>Phương thức thanh toán:</strong>
                            </div>
                            <div class="col-md-6 mb-2">
                                ${order.paymentMethodDisplay}
                            </div>

                            <div class="col-md-6 mb-2">
                                <strong>Trạng thái thanh toán:</strong>
                            </div>
                            <div class="col-md-6 mb-2">
                                <span class="badge bg-secondary">${order.paymentStatusDisplay}</span>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <p>
                            Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất để xác nhận đơn hàng.
                            Bạn có thể theo dõi trạng thái đơn hàng trong mục
                            <a href="${pageContext.request.contextPath}/account/orders" class="fw-bold">Đơn hàng của tôi</a>.
                        </p>
                    </div>

                    <div class="d-grid gap-2 d-md-flex justify-content-center">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg me-md-2">
                            <i class="bi bi-house me-2"></i>Tiếp tục mua sắm
                        </a>
                        <a href="${pageContext.request.contextPath}/account/orders" class="btn btn-outline-success btn-lg">
                            <i class="bi bi-list-check me-2"></i>Xem đơn hàng
                        </a>
                    </div>
                </div>
            </div>

            <div class="card mt-4">
                <div class="card-body">
                    <h5 class="card-title"><i class="bi bi-headset me-2"></i>Hỗ trợ khách hàng</h5>
                    <p class="card-text">
                        Nếu bạn có bất kỳ câu hỏi nào về đơn hàng, vui lòng liên hệ với chúng tôi:
                    </p>
                    <div class="row">
                        <div class="col-md-6">
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-telephone text-primary me-2"></i>
                                    <strong>Hotline:</strong> 1900 1234
                                </li>
                                <li class="mb-2">
                                    <i class="bi bi-envelope text-primary me-2"></i>
                                    <strong>Email:</strong> support@example.com
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="list-unstyled">
                                <li class="mb-2">
                                    <i class="bi bi-clock text-primary me-2"></i>
                                    <strong>Thời gian làm việc:</strong>
                                </li>
                                <li class="mb-2">
                                    8:00 - 22:00 hàng ngày
                                </li>
                            </ul>
                        </div>
                    </div>
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
                <a href="${pageContext.request.contextPath}/"
                   class="d-flex align-items-center mb-3 text-decoration-none">
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
                    <li><a href="${pageContext.request.contextPath}/shop?category=1" class="footer-link">Công nghệ
                        mini</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=2" class="footer-link">Thiết bị AI</a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=3" class="footer-link">Phụ kiện sáng
                        tạo</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=4" class="footer-link">Đồ chơi công
                        nghệ</a></li>
                </ul>
            </div>

            <!-- Hỗ trợ -->
            <div class="col-md-2">
                <h6 class="fw-bold mb-3 text-uppercase">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/contact" class="footer-link">Liên hệ</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq" class="footer-link">Câu hỏi thường gặp</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart" class="footer-link">Giỏ hàng</a></li>
                    <li><a href="${pageContext.request.contextPath}/checkout" class="footer-link">Thanh toán</a></li>
                </ul>
            </div>

            <!-- Liên hệ -->
            <div class="col-md-4">
                <h6 class="fw-bold mb-3 text-uppercase">Liên hệ</h6>
                <p class="mb-1"><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP. Hồ Chí Minh</p>
                <p class="mb-1"><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
                <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@techx.vn</p>
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
    // Tự động in hóa đơn (nếu cần)
    function printInvoice() {
        window.print();
    }

    // Copy mã đơn hàng
    function copyOrderId() {
        const orderId = '${order.id}';
        navigator.clipboard.writeText(orderId).then(() => {
            alert('Đã copy mã đơn hàng: ' + orderId);
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        console.log('Order placed successfully: #${order.id}');

        // Xóa thông tin địa chỉ đã lưu trong localStorage
        ['checkout_address', 'checkout_city', 'checkout_district'].forEach(key => {
            localStorage.removeItem(key);
        });
    });
</script>
</body>
</html>
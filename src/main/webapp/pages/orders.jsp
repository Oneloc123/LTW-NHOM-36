<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<%--<head>--%>
<%--    <meta charset="UTF-8">--%>
<%--    <meta name="viewport" content="width=device-width, initial-scale=1.0">--%>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1"/>
<title>Đơn hàng của tôi</title>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
<style>
    /* ===== Reset & Base ===== */
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: "Segoe UI", Arial;
        background: #f4f6f9;
        color: #333;
    }

    /* ===== Container ===== */
    .container {
        max-width: 1100px;
        margin: 40px auto;
        padding: 0 16px;
    }

    .page-title {
        font-size: 28px;
        font-weight: 600;
        margin-bottom: 24px;
        color: #222;
    }

    /* ===== Message ===== */
    .message {
        padding: 14px 16px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 14px;
    }

    .message.success {
        background: #e6f4ea;
        color: #1e7e34;
        border-left: 4px solid #28a745;
    }

    .message.error {
        background: #fdecea;
        color: #c82333;
        border-left: 4px solid #dc3545;
    }

    /* ===== Stats ===== */
    .stats-card {
        background: linear-gradient(135deg, #4f46e5, #6366f1);
        color: #fff;
        padding: 24px;
        border-radius: 14px;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        gap: 16px;
    }

    .stats-number {
        font-size: 36px;
        font-weight: 700;
    }

    .stats-label {
        font-size: 16px;
        opacity: 0.9;
    }

    /* ===== Order Card ===== */
    .order-card {
        background: #fff;
        border-radius: 16px;
        padding: 22px 24px;
        margin-bottom: 22px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .order-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 28px rgba(0, 0, 0, 0.1);
    }

    /* ===== Order Header ===== */
    .order-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 18px;
    }

    .order-id {
        font-size: 16px;
        font-weight: 600;
    }

    .order-date {
        font-size: 13px;
        color: #777;
        margin-top: 4px;
    }

    /* ===== Status ===== */
    .order-status {
        padding: 6px 14px;
        border-radius: 999px;
        font-size: 13px;
        font-weight: 600;
        white-space: nowrap;
    }

    .status-pending {
        background: #fff3cd;
        color: #856404;
    }

    .status-completed {
        background: #e6f4ea;
        color: #1e7e34;
    }

    .status-cancelled {
        background: #fdecea;
        color: #c82333;
    }

    /* ===== Order Info ===== */
    .order-info {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 16px;
        margin-bottom: 18px;
    }

    .info-item {
        background: #f8f9fb;
        padding: 14px;
        border-radius: 10px;
    }

    .info-label {
        font-size: 12px;
        color: #888;
        margin-bottom: 4px;
    }

    .info-value {
        font-size: 14px;
        font-weight: 500;
    }

    /* ===== Total ===== */
    .order-total {
        font-size: 18px;
        font-weight: 700;
        color: #dc2626;
        margin-bottom: 18px;
    }

    /* ===== Actions ===== */
    .order-actions {
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .btn {
        display: inline-block;
        padding: 10px 18px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        text-decoration: none;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    /* View */
    .btn-view {
        background: #2563eb;
        color: #fff;
    }

    .btn-view:hover {
        background: #1d4ed8;
    }

    /* Cancel */
    .btn-cancel {
        background: #fee2e2;
        color: #b91c1c;
    }

    .btn-cancel:hover {
        background: #fecaca;
    }

    /* Shopping */
    .btn-shopping {
        background: #16a34a;
        color: #fff;
    }

    .btn-shopping:hover {
        background: #15803d;
    }

    /* ===== Empty State ===== */
    .empty-state {
        text-align: center;
        background: #fff;
        padding: 60px 20px;
        border-radius: 18px;
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
    }

    .empty-icon {
        font-size: 56px;
        margin-bottom: 16px;
    }

    .empty-title {
        font-size: 22px;
        margin-bottom: 8px;
    }

    .empty-text {
        font-size: 14px;
        color: #666;
        margin-bottom: 20px;
    }

</style>


</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<div class="container">
    <h1 class="page-title">Đơn hàng của tôi</h1>

    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <!-- Thống kê -->
    <div class="stats-card">
        <div class="stats-number">${totalOrders}</div>
        <div class="stats-label">Tổng số đơn hàng</div>
    </div>

    <!-- Danh sách đơn hàng -->
    <c:choose>
        <c:when test="${not empty orders}">
            <c:forEach var="order" items="${orders}">
                <div class="order-card">
                    <div class="order-header">
                        <div>
                            <div class="order-id">Đơn hàng #${order.id}</div>
                            <div class="order-date">${order.orderDate}</div>
                        </div>
                        <span class="order-status status-${order.status}">
                                ${order.statusDisplay}
                        </span>
                    </div>

                    <div class="order-info">
                        <div class="info-item">
                            <div class="info-label">Phương thức thanh toán</div>
                            <div class="info-value">${order.paymentMethodDisplay}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Trạng thái thanh toán</div>
                            <div class="info-value">${order.paymentStatusDisplay}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Địa chỉ giao hàng</div>
                            <div class="info-value">${order.shippingAddress}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Số điện thoại</div>
                            <div class="info-value">${order.phoneNumber}</div>
                        </div>
                    </div>

                    <div class="order-total">
                        Tổng tiền: ${String.format("%,.0f", order.totalAmount)} VNĐ
                    </div>

                    <div class="order-actions">
                        <a href="${pageContext.request.contextPath}/user/order-detail?id=${order.id}"
                           class="btn btn-view">Xem chi tiết</a>

                        <c:if test="${order.status == 'pending'}">
                            <form method="post" action="${pageContext.request.contextPath}/user/cancel-order"
                                  style="display: inline;">
                                <input type="hidden" name="id" value="${order.id}">
                                <button type="submit" class="btn btn-cancel"
                                        onclick="return confirm('Bạn có chắc muốn hủy đơn hàng này?')">
                                    Hủy đơn hàng
                                </button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </c:when>

        <c:otherwise>
            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <h2 class="empty-title">Chưa có đơn hàng nào</h2>
                <p class="empty-text">Hãy mua sắm và quay lại xem đơn hàng của bạn tại đây!</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-shopping">Mua sắm ngay</a>
            </div>
        </c:otherwise>
    </c:choose>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng #${order.id}</title>

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
            background: linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 50%, #fbc2eb 100%);
            color: #333;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ===== Container ===== */
        .container {
            max-width: 1100px;
            margin: 40px auto;
            padding: 0 16px;
            flex: 1;
        }

        .page-title {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 24px;
            color: #222;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-title i {
            color: #667eea;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #667eea;
            text-decoration: none;
            font-weight: 500;
            margin-bottom: 20px;
            padding: 8px 16px;
            border-radius: 8px;
            background-color: white;
            border: 1px solid #ddd;
            transition: all 0.3s;
        }

        .back-link:hover {
            background-color: #f8f9fa;
            border-color: #667eea;
            transform: translateX(-3px);
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

        /*===== Order Header Card ===== */
        .order-header-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 22px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }

        .order-header-content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 20px;
        }

        .order-basic-info h3 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #222;
        }

        .order-date {
            font-size: 14px;
            color: #666;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .order-status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 999px;
            font-size: 14px;
            font-weight: 600;
            white-space: nowrap;
        }

        .status-pending { background: #fff3cd; color: #856404; }
        .status-processing { background: #cce5ff; color: #004085; }
        .status-shipped { background: #d1ecf1; color: #0c5460; }
        .status-delivered { background: #d4edda; color: #155724; }
        .status-cancelled { background: #f8d7da; color: #721c24; }

        .order-payment-status {
            text-align: right;
        }

        .payment-status {
            font-size: 14px;
            color: #666;
            margin-bottom: 4px;
        }

        .payment-method {
            font-size: 14px;
            color: #666;
        }

        /* ===== Order Details Card ===== */
        .order-details-card {
            background: #fff;
            border-radius: 16px;
            padding: 0;
            margin-bottom: 22px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        .order-details-header {
            background: #f8f9fb;
            padding: 18px 24px;
            border-bottom: 1px solid #eee;
            font-weight: 600;
            color: #333;
            font-size: 16px;
        }

        .order-items {
            padding: 0;
        }

        .order-item {
            display: grid;
            grid-template-columns: 60px 2fr 1fr 1fr 1fr;
            gap: 20px;
            align-items: center;
            padding: 20px 24px;
            border-bottom: 1px solid #f0f0f0;
            transition: background-color 0.2s;
        }

        .order-item:hover {
            background-color: #fafafa;
        }

        .item-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #eee;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #999;
        }

        .item-name {
            font-weight: 500;
            color: #333;
        }

        .item-price, .item-quantity, .item-subtotal {
            color: #666;
            font-size: 14px;
        }

        .item-subtotal {
            font-weight: 600;
            color: #222;
        }

        .order-summary {
            background: #f8f9fb;
            padding: 24px;
            border-top: 1px solid #eee;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            color: #666;
            font-size: 14px;
        }

        .summary-row.total {
            font-size: 18px;
            font-weight: 700;
            color: #dc2626;
            border-top: 2px solid #eee;
            margin-top: 8px;
            padding-top: 16px;
        }

        /* ===== Customer Info Card ===== */
        .customer-info-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 22px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }

        .info-card-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: #222;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .info-item {
            padding: 16px;
            background: #f8f9fb;
            border-radius: 12px;
            border-left: 3px solid #667eea;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .info-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .info-label {
            font-size: 12px;
            color: #888;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 15px;
            font-weight: 500;
            color: #333;
            line-height: 1.5;
            font-family: "Segoe UI", "Roboto", "Helvetica Neue", Arial, "Noto Sans",
            "Noto Sans Vietnamese", sans-serif;
        }

        /* ===== Order Actions ===== */
        .order-actions-card {
            background: #fff;
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
        }

        .action-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: #2563eb;
            color: #fff;
        }

        .btn-primary:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .btn-danger {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        .btn-danger:hover {
            background: #fecaca;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(185, 28, 28, 0.1);
        }

        .btn-secondary {
            background: #f3f4f6;
            color: #374151;
            border: 1px solid #e5e7eb;
        }

        .btn-secondary:hover {
            background: #e5e7eb;
            transform: translateY(-2px);
        }

        .btn-success {
            background: #16a34a;
            color: #fff;
        }

        .btn-success:hover {
            background: #15803d;
            transform: translateY(-2px);
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 13px;
        }

        /* ===== Notes Section ===== */
        .notes-section {
            background: #fff8e1;
            border-left: 4px solid #ffc107;
            padding: 18px;
            border-radius: 0 12px 12px 0;
            margin: 20px 0;
            font-size: 14px;
            transition: transform 0.2s ease;
        }

        .notes-section:hover {
            transform: translateX(2px);
        }

        .notes-label {
            font-weight: 600;
            color: #856404;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .notes-content {
            color: #333;
            line-height: 1.6;
        }

        /* ===== Empty State ===== */
        .empty-state {
            text-align: center;
            background: #fff;
            padding: 60px 20px;
            border-radius: 18px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.06);
            margin-top: 40px;
        }

        .empty-icon {
            font-size: 56px;
            margin-bottom: 16px;
            color: #6366f1;
        }

        .empty-title {
            font-size: 22px;
            margin-bottom: 8px;
            color: #333;
        }

        .empty-text {
            font-size: 14px;
            color: #666;
            margin-bottom: 20px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.6;
        }

        /* ===== Timeline ===== */
        .order-timeline {
            margin-top: 20px;
            position: relative;
            padding-left: 24px;
        }

        .order-timeline::before {
            content: '';
            position: absolute;
            left: 7px;
            top: 24px;
            bottom: 0;
            width: 2px;
            background: #e5e7eb;
            z-index: 1;
        }

        .timeline-item {
            display: flex;
            align-items: flex-start;
            gap: 15px;
            margin-bottom: 24px;
            position: relative;
        }

        .timeline-icon {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background: #e5e7eb;
            border: 3px solid #fff;
            position: relative;
            z-index: 2;
            flex-shrink: 0;
            margin-top: 4px;
        }

        .timeline-icon.active {
            background: #10b981;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1);
        }

        .timeline-content {
            flex: 1;
            padding-bottom: 4px;
        }

        .timeline-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 4px;
        }

        .timeline-date {
            font-size: 12px;
            color: #888;
        }

        /* ===== Print Styles ===== */
        @media print {
            .back-link,
            .order-actions-card,
            .btn,
            footer,
            header {
                display: none !important;
            }

            body {
                background: white !important;
                font-size: 12px;
            }

            .container {
                margin: 10px !important;
                padding: 0 !important;
                max-width: 100% !important;
            }

            .order-header-card,
            .order-details-card,
            .customer-info-card {
                box-shadow: none !important;
                border: 1px solid #ddd !important;
                margin-bottom: 10px !important;
            }

            .page-title {
                font-size: 20px !important;
                margin-bottom: 15px !important;
            }
        }

        /* ===== Footer (điều chỉnh từ Bootstrap) ===== */
        .footer {
            margin-top: 60px;
        }

        .footer-link {
            color: #666;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .footer-link:hover {
            color: #4f46e5;
        }

        .social-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            background: #f8f9fa;
            border-radius: 50%;
            color: #666;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .social-link:hover {
            background: #4f46e5;
            color: white;
            transform: translateY(-2px);
        }

        /* ===== Responsive ===== */
        @media (max-width: 768px) {
            .container {
                margin: 20px auto;
                padding: 0 12px;
            }

            .page-title {
                font-size: 24px;
            }

            .order-header-content {
                flex-direction: column;
                text-align: center;
            }

            .order-payment-status {
                text-align: center;
            }

            .order-item {
                grid-template-columns: 1fr;
                gap: 12px;
                text-align: center;
                padding: 16px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .order-timeline {
                padding-left: 20px;
            }

            .timeline-item {
                margin-bottom: 20px;
            }
        }

        @media (max-width: 576px) {
            .order-header-card,
            .order-details-card,
            .customer-info-card,
            .order-actions-card {
                padding: 16px;
            }

            .empty-state {
                padding: 40px 16px;
            }

            .empty-icon {
                font-size: 48px;
            }

            .empty-title {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container">
    <!-- Breadcrumb và Back link -->
    <a href="${pageContext.request.contextPath}/user/orders" class="back-link">
        <i class="bi bi-arrow-left"></i> Quay lại danh sách đơn hàng
    </a>

    <h1 class="page-title">
        <i class="bi bi-receipt"></i> Chi tiết đơn hàng #${order.id}
    </h1>

    <!-- Thông báo -->
    <c:if test="${not empty message}">
        <div class="message success">${message}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="message error">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${order != null}">
            <!-- Order Header -->
            <div class="order-header-card">
                <div class="order-header-content">
                    <div class="order-basic-info">
                        <h3>Đơn hàng #${order.id}</h3>
                        <div class="order-date">
                            <i class="bi bi-calendar"></i>
                            Đặt ngày: <fmt:formatDate value="${order.orderDate}" pattern="HH:mm dd/MM/yyyy" />
                        </div>
                        <span class="order-status-badge status-${order.status}">
                                ${order.statusDisplay}
                        </span>
                    </div>
                    <div class="order-payment-status">
                        <div class="payment-status">
                            Thanh toán: ${order.paymentStatusDisplay}
                        </div>
                        <div class="payment-method">
                            Phương thức: ${order.paymentMethodDisplay}
                        </div>
                    </div>
                </div>

                <!-- Order Timeline -->
                <div class="order-timeline">
                    <div class="timeline-item">
                        <div class="timeline-icon ${order.status != 'cancelled' ? 'active' : ''}"></div>
                        <div class="timeline-content">
                            <div class="timeline-title">Đơn hàng đã được tạo</div>
                            <div class="timeline-date">
                                <fmt:formatDate value="${order.orderDate}" pattern="HH:mm dd/MM/yyyy" />
                            </div>
                        </div>
                    </div>

                    <c:if test="${order.status == 'processing' || order.status == 'shipped' || order.status == 'delivered'}">
                        <div class="timeline-item">
                            <div class="timeline-icon ${order.status != 'pending' ? 'active' : ''}"></div>
                            <div class="timeline-content">
                                <div class="timeline-title">Đang xử lý</div>
                                <div class="timeline-date">Đơn hàng đang được chuẩn bị</div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${order.status == 'shipped' || order.status == 'delivered'}">
                        <div class="timeline-item">
                            <div class="timeline-icon ${order.status == 'shipped' || order.status == 'delivered' ? 'active' : ''}"></div>
                            <div class="timeline-content">
                                <div class="timeline-title">Đang giao hàng</div>
                                <div class="timeline-date">Đơn hàng đang được vận chuyển</div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${order.status == 'delivered'}">
                        <div class="timeline-item">
                            <div class="timeline-icon active"></div>
                            <div class="timeline-content">
                                <div class="timeline-title">Đã giao hàng</div>
                                <div class="timeline-date">Đơn hàng đã được giao thành công</div>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${order.status == 'cancelled'}">
                        <div class="timeline-item">
                            <div class="timeline-icon active"></div>
                            <div class="timeline-content">
                                <div class="timeline-title">Đã hủy</div>
                                <div class="timeline-date">Đơn hàng đã bị hủy</div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Order Items -->
            <div class="order-details-card">
                <div class="order-details-header">
                    Sản phẩm đã đặt (${order.items.size()} sản phẩm)
                </div>
                <div class="order-items">
                    <c:forEach var="item" items="${order.items}">
                        <div class="order-item">
                            <div class="item-image">
                                <c:choose>
                                    <c:when test="${not empty item.product.imagesTop}">
                                        <img src="${item.product.imagesTop}" alt="${item.product.name}"
                                             style="width: 100%; height: 100%; border-radius: 8px; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-box"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="item-name">
                                    ${item.product.name}
                            </div>
                            <div class="item-price">
                                <fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                            </div>
                            <div class="item-quantity">
                                Số lượng: ${item.quantity}
                            </div>
                            <div class="item-subtotal">
                                <fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Order Summary -->
                <div class="order-summary">
                    <div class="summary-row">
                        <span>Tạm tính:</span>
                        <span>
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                        </span>
                    </div>
                    <div class="summary-row">
                        <span>Phí vận chuyển:</span>
                        <span>Miễn phí</span>
                    </div>
                    <div class="summary-row">
                        <span>Giảm giá:</span>
                        <span>₫0</span>
                    </div>
                    <div class="summary-row total">
                        <span>Tổng cộng:</span>
                        <span>
                            <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" />
                        </span>
                    </div>
                </div>
            </div>

            <!-- Customer Information -->
            <div class="customer-info-card">
                <div class="info-card-title">
                    <i class="bi bi-person-circle"></i> Thông tin khách hàng
                </div>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Họ tên</div>
                        <div class="info-value">${user.fullName}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Email</div>
                        <div class="info-value">${order.email}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Số điện thoại</div>
                        <div class="info-value">${order.phoneNumber}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Địa chỉ giao hàng</div>
                        <div class="info-value">${order.shippingAddress}</div>
                    </div>
                </div>
            </div>

            <!-- Order Notes -->
            <c:if test="${not empty order.notes}">
                <div class="notes-section">
                    <div class="notes-label">
                        <i class="bi bi-sticky"></i> Ghi chú đơn hàng
                    </div>
                    <div class="notes-content">
                            ${order.notes}
                    </div>
                </div>
            </c:if>

            <!-- Order Actions -->
            <div class="order-actions-card">
                <div class="info-card-title">
                    <i class="bi bi-gear"></i> Thao tác
                </div>
                <div class="action-buttons">
                    <c:if test="${order.status == 'pending'}">
                        <form method="post" action="${pageContext.request.contextPath}/user/cancel-order"
                              style="display: inline;">
                            <input type="hidden" name="id" value="${order.id}">
                            <button type="submit" class="btn btn-danger"
                                    onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')">
                                <i class="bi bi-x-circle"></i> Hủy đơn hàng
                            </button>
                        </form>
                    </c:if>

                    <c:if test="${order.status == 'delivered'}">
                        <button class="btn btn-success" disabled>
                            <i class="bi bi-check-circle"></i> Đã nhận được hàng
                        </button>
                    </c:if>

                    <c:if test="${order.status == 'shipped'}">
                        <a href="#" class="btn btn-primary">
                            <i class="bi bi-truck"></i> Theo dõi vận chuyển
                        </a>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        <i class="bi bi-cart-plus"></i> Tiếp tục mua sắm
                    </a>

                    <button class="btn btn-secondary" onclick="window.print()">
                        <i class="bi bi-printer"></i> In đơn hàng
                    </button>
                </div>

                <!-- Support Info -->
                <div class="mt-4 pt-3 border-top">
                    <p class="small text-muted mb-2">
                        <i class="bi bi-info-circle"></i>
                        Nếu bạn có bất kỳ câu hỏi nào về đơn hàng, vui lòng liên hệ hỗ trợ.
                    </p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="tel:19001234" class="btn btn-secondary btn-sm">
                            <i class="bi bi-telephone"></i> 1900 1234
                        </a>
                        <a href="mailto:support@store.com" class="btn btn-secondary btn-sm">
                            <i class="bi bi-envelope"></i> support@store.com
                        </a>
                    </div>
                </div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Empty State if Order Not Found -->
            <div class="empty-state">
                <div class="empty-icon">❌</div>
                <h2 class="empty-title">Không tìm thấy đơn hàng</h2>
                <p class="empty-text">Đơn hàng bạn tìm kiếm không tồn tại hoặc bạn không có quyền xem.</p>
                <a href="${pageContext.request.contextPath}/user/orders" class="btn btn-primary">
                    Quay lại danh sách đơn hàng
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
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
                    <li><a href="${pageContext.request.contextPath}/shop?category=1" class="footer-link">Công nghệ mini</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=2" class="footer-link">Thiết bị AI</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=3" class="footer-link">Phụ kiện sáng tạo</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop?category=4" class="footer-link">Đồ chơi công nghệ</a></li>
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
<script>
    // Print order functionality
    function printOrder() {
        window.print();
    }

    // Confirm order cancellation
    document.querySelectorAll('form[action*="cancel-order"]').forEach(form => {
        form.addEventListener('submit', function(e) {
            if (!confirm('Bạn có chắc chắn muốn hủy đơn hàng này? Hành động này không thể hoàn tác.')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>
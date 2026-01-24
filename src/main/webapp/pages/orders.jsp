<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Đơn hàng của tôi</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: #333;
            background-color: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: bold;
            text-decoration: none;
            color: white;
        }

        .user-nav {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-link {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
        }

        .welcome {
            font-size: 1.1rem;
            font-weight: 500;
        }

        .page-title {
            color: #333;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #667eea;
        }

        .stats-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            text-align: center;
        }

        .stats-number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #667eea;
            margin-bottom: 10px;
        }

        .stats-label {
            font-size: 1.1rem;
            color: #666;
        }

        .order-card {
            background: white;
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid #667eea;
        }

        .order-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .order-id {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
        }

        .order-date {
            color: #666;
            font-size: 0.9rem;
        }

        .order-status {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-processing { background-color: #cce5ff; color: #004085; }
        .status-shipped { background-color: #d1ecf1; color: #0c5460; }
        .status-delivered { background-color: #d4edda; color: #155724; }
        .status-cancelled { background-color: #f8d7da; color: #721c24; }

        .order-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .info-item {
            padding: 10px 0;
        }

        .info-label {
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            font-size: 1rem;
            font-weight: 500;
            color: #333;
        }

        .order-total {
            text-align: right;
            font-size: 1.3rem;
            font-weight: 600;
            color: #667eea;
            margin-top: 15px;
        }

        .order-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            text-align: center;
            cursor: pointer;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-view {
            background-color: #667eea;
            color: white;
        }

        .btn-view:hover {
            background-color: #5a6fd8;
            transform: translateY(-2px);
        }

        .btn-cancel {
            background-color: #f8f9fa;
            color: #dc3545;
            border: 1px solid #dc3545;
        }

        .btn-cancel:hover {
            background-color: #dc3545;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .empty-icon {
            font-size: 4rem;
            color: #ddd;
            margin-bottom: 20px;
        }

        .empty-title {
            font-size: 1.5rem;
            color: #666;
            margin-bottom: 10px;
        }

        .empty-text {
            color: #888;
            margin-bottom: 30px;
        }

        .btn-shopping {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 12px 30px;
            font-size: 1.1rem;
        }

        .btn-shopping:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .message {
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
            font-weight: 500;
        }

        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        footer {
            text-align: center;
            padding: 30px 0;
            margin-top: 50px;
            color: #666;
            border-top: 1px solid #eee;
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .order-header {
                flex-direction: column;
                gap: 10px;
            }

            .order-info {
                grid-template-columns: 1fr;
            }

            .order-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="header-content">
        <a href="${pageContext.request.contextPath}/" class="logo">Shop Online</a>
        <div class="user-nav">
            <span class="welcome">Xin chào, ${user.fullName}</span>
            <a href="${pageContext.request.contextPath}/" class="nav-link">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/user/orders" class="nav-link">Đơn hàng</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link">Đăng xuất</a>
        </div>
    </div>
</header>

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

<footer>
    <p>© 2024 Shop Online. Tất cả các quyền được bảo lưu.</p>
</footer>
</body>
</html>
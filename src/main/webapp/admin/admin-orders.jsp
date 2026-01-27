<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Đơn hàng | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
    <style>
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-processing { background-color: #cce5ff; color: #004085; }
        .status-shipped { background-color: #d1ecf1; color: #0c5460; }
        .status-delivered { background-color: #d4edda; color: #155724; }
        .status-cancelled { background-color: #f8d7da; color: #721c24; }
        .payment-unpaid { background-color: #f8d7da; color: #721c24; }
        .payment-paid { background-color: #d4edda; color: #155724; }
        .payment-refunded { background-color: #e2e3e5; color: #383d41; }
    </style>
</head>

<body>
<div class="d-flex">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
        <nav>
            <ul>
                <li><a href="dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="products"><i class="bi bi-box"></i> Sản phẩm</a></li>
                <li><a href="categories" ><i class="bi bi-tags"></i> Danh mục</a></li>
                <li><a href="orders" class="active"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                <li><a href="users"><i class="bi bi-people"></i> Người dùng</a></li>
                <li><a href="blogs"><i class="bi bi-journal-text"></i> Blog</a></li>
                <li><a href="banners"><i class="bi bi-image"></i> Banner</a></li>
                <li><a href="/loggout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main -->
    <main class="main-content">

        <!-- HEADER -->
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi-cart"></i> Đơn hàng</h3>
            <div class="actions d-flex align-items-center gap-2">
                <span class="text-muted">
                    Tổng: <strong>${orders.size()}</strong> đơn hàng
                </span>
            </div>
        </header>

        <!-- 🔎 SEARCH & FILTERS -->
        <section class="filters mt-4">
            <form action="orders" method="get">
                <div class="row g-3">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="keyword"
                               placeholder="Mã đơn, email, số điện thoại..."
                               value="${param.keyword}">
                    </div>

                    <div class="col-md-2">
                        <select class="form-select" name="status">
                            <option value="">Tất cả trạng thái</option>
                            <c:forEach items="${orderStatuses}" var="status">
                                <option value="${status}"
                                    ${param.status == status ? 'selected' : ''}>
                                        ${status == 'pending' ? 'Đang chờ' :
                                                status == 'processing' ? 'Đang xử lý' :
                                                        status == 'shipped' ? 'Đang giao' :
                                                                status == 'delivered' ? 'Đã giao' :
                                                                        status == 'cancelled' ? 'Đã hủy' : status}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <select class="form-select" name="paymentStatus">
                            <option value="">Tất cả TT thanh toán</option>
                            <option value="unpaid" ${param.paymentStatus == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                            <option value="paid" ${param.paymentStatus == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                            <option value="refunded" ${param.paymentStatus == 'refunded' ? 'selected' : ''}>Đã hoàn tiền</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <input type="number" class="form-control" name="userId"
                               placeholder="Mã khách hàng"
                               value="${param.userId}">
                    </div>

                    <div class="col-md-3 text-end">
                        <button class="btn btn-primary">
                            <i class="bi bi-search"></i> Tìm kiếm
                        </button>
                        <a href="orders" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-clockwise"></i> Làm mới
                        </a>
                    </div>
                </div>
            </form>
        </section>

        <!-- Bảng đơn hàng -->
        <section class="blog-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Mã đơn</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>TT thanh toán</th>
                                <th>Phương thức</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td><strong>#${order.id}</strong></td>
                                    <td>
                                        <div>ID: ${order.userId}</div>
                                        <small class="text-muted">${order.email}</small>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <strong><fmt:formatNumber value="${order.totalAmount}" type="currency"/></strong>
                                    </td>
                                    <td>
                                        <span class="status-badge status-${order.status}">
                                                ${order.statusDisplay}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.paymentStatus == 'unpaid'}">
                                                <span class="status-badge payment-unpaid">Chưa thanh toán</span>
                                            </c:when>
                                            <c:when test="${order.paymentStatus == 'paid'}">
                                                <span class="status-badge payment-paid">Đã thanh toán</span>
                                            </c:when>
                                            <c:when test="${order.paymentStatus == 'refunded'}">
                                                <span class="status-badge payment-refunded">Đã hoàn tiền</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge">${order.paymentStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <small>${order.paymentMethodDisplay}</small>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <a href="orders?action=view&id=${order.id}"
                                               class="btn btn-sm btn-outline-info" title="Xem chi tiết">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="orders?action=edit&id=${order.id}"
                                               class="btn btn-sm btn-outline-warning" title="Chỉnh sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="orders?action=delete&id=${order.id}"
                                               onclick="return confirm('Xóa đơn hàng #${order.id}?')"
                                               class="btn btn-sm btn-outline-danger" title="Xóa">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty orders}">
                                <tr>
                                    <td colspan="8" class="text-center py-4">
                                        <i class="bi bi-cart-x text-muted" style="font-size: 3rem;"></i>
                                        <p class="mt-2 text-muted">Không có đơn hàng nào</p>
                                    </td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>

    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- MODAL: Chỉnh sửa đơn hàng -->
<c:if test="${not empty editOrder}">
    <div class="modal fade show" id="editOrderModal" tabindex="-1" style="display:block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-pencil-square"></i> Cập nhật đơn hàng #${editOrder.id}
                    </h5>
                    <a href="orders" class="btn-close"></a>
                </div>

                <form action="orders?action=edit" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${editOrder.id}">
                        <input type="hidden" name="userId" value="${editOrder.userId}">

                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Khách hàng</label>
                                <input type="text" class="form-control"
                                       value="${user.fullName} (ID: ${user.id})" readonly>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control"
                                       name="email" value="${editOrder.email}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control"
                                       name="phoneNumber" value="${editOrder.phoneNumber}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ giao hàng</label>
                                <textarea class="form-control" name="shippingAddress"
                                          rows="2" required>${editOrder.shippingAddress}</textarea>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Tổng tiền</label>
                                <input type="number" class="form-control"
                                       name="totalAmount" value="${editOrder.totalAmount}" step="0.01" required>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Trạng thái đơn hàng</label>
                                <select class="form-select" name="status">
                                    <c:forEach items="${orderStatuses}" var="status">
                                        <option value="${status}"
                                            ${editOrder.status == status ? 'selected' : ''}>
                                                ${status == 'pending' ? 'Đang chờ' :
                                                        status == 'processing' ? 'Đang xử lý' :
                                                                status == 'shipped' ? 'Đang giao' :
                                                                        status == 'delivered' ? 'Đã giao' :
                                                                                status == 'cancelled' ? 'Đã hủy' : status}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label class="form-label">Trạng thái thanh toán</label>
                                <select class="form-select" name="paymentStatus">
                                    <option value="unpaid" ${editOrder.paymentStatus == 'unpaid' ? 'selected' : ''}>
                                        Chưa thanh toán
                                    </option>
                                    <option value="paid" ${editOrder.paymentStatus == 'paid' ? 'selected' : ''}>
                                        Đã thanh toán
                                    </option>
                                    <option value="refunded" ${editOrder.paymentStatus == 'refunded' ? 'selected' : ''}>
                                        Đã hoàn tiền
                                    </option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Phương thức thanh toán</label>
                                <select class="form-select" name="paymentMethod">
                                    <option value="cod" ${editOrder.paymentMethod == 'cod' ? 'selected' : ''}>
                                        Thanh toán khi nhận hàng
                                    </option>
                                    <option value="bank_transfer" ${editOrder.paymentMethod == 'bank_transfer' ? 'selected' : ''}>
                                        Chuyển khoản ngân hàng
                                    </option>
                                    <option value="credit_card" ${editOrder.paymentMethod == 'credit_card' ? 'selected' : ''}>
                                        Thẻ tín dụng
                                    </option>
                                    <option value="paypal" ${editOrder.paymentMethod == 'paypal' ? 'selected' : ''}>
                                        PayPal
                                    </option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Ghi chú</label>
                                <textarea class="form-control" name="notes"
                                          rows="2">${editOrder.notes}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <a href="orders" class="btn btn-secondary">Hủy</a>
                        <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <div class="modal-backdrop fade show"></div>
</c:if>

<script>
    // Auto-close modal on background click
    document.addEventListener('DOMContentLoaded', function() {
        const backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) {
            backdrop.addEventListener('click', function() {
                window.location.href = 'orders';
            });
        }
    });
</script>

</body>
</html>
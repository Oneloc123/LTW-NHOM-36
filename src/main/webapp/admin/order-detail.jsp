<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .order-status {
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 500;
        }
        .pending { background-color: #fff3cd; color: #856404; }
        .processing { background-color: #cce5ff; color: #004085; }
        .shipped { background-color: #d1ecf1; color: #0c5460; }
        .delivered { background-color: #d4edda; color: #155724; }
        .cancelled { background-color: #f8d7da; color: #721c24; }
        .card-header { background-color: #f8f9fa; }
    </style>
</head>

<body class="bg-light">
<div class="container mt-4 mb-4">

    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">
            <i class="bi bi-receipt"></i> Chi tiết đơn hàng #${order.id}
        </h2>
        <a href="orders" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
    </div>

    <div class="row">
        <!-- Thông tin đơn hàng -->
        <div class="col-md-8">
            <div class="card shadow-sm mb-4">
                <div class="card-header fw-bold">
                    <i class="bi bi-info-circle"></i> Thông tin đơn hàng
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="fw-bold">Trạng thái:</label>
                            <span class="order-status ${order.status} ms-2">
                                ${order.statusDisplay}
                            </span>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold">TT thanh toán:</label>
                            <span class="ms-2 ${order.paymentStatus == 'paid' ? 'text-success' : 'text-danger'}">
                                ${order.paymentStatusDisplay}
                            </span>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label class="fw-bold">Ngày đặt:</label>
                            <span class="ms-2">
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </span>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold">Phương thức:</label>
                            <span class="ms-2">${order.paymentMethodDisplay}</span>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-12">
                            <label class="fw-bold">Địa chỉ giao hàng:</label>
                            <p class="ms-2">${order.shippingAddress}</p>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label class="fw-bold">Email:</label>
                            <span class="ms-2">${order.email}</span>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold">Số điện thoại:</label>
                            <span class="ms-2">${order.phoneNumber}</span>
                        </div>
                    </div>

                    <c:if test="${not empty order.notes}">
                        <div class="row mt-3">
                            <div class="col-12">
                                <label class="fw-bold">Ghi chú:</label>
                                <p class="ms-2 text-muted">${order.notes}</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Sản phẩm -->
            <div class="card shadow-sm">
                <div class="card-header fw-bold">
                    <i class="bi bi-box-seam"></i> Sản phẩm đã đặt
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-end">Thành tiền</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${order.items}" var="item">
                                <tr>
                                    <td>
                                        <div>
                                            <strong>${item.product.name}</strong>
                                            <c:if test="${not empty item.product}">
                                                <br>
                                                <small class="text-muted">Mã SP: ${item.productId}</small>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td class="text-center">${item.quantity}</td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${item.unitPrice}" type="currency"/>
                                    </td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${item.subtotal}" type="currency"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr class="table-light">
                                <td colspan="3" class="text-end fw-bold">Tổng cộng:</td>
                                <td class="text-end fw-bold fs-5 text-danger">
                                    <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thông tin khách hàng & Hành động -->
        <div class="col-md-4">
            <!-- Thông tin khách hàng -->
            <div class="card shadow-sm mb-4">
                <div class="card-header fw-bold">
                    <i class="bi bi-person-circle"></i> Khách hàng
                </div>
                <div class="card-body">
                    <c:if test="${not empty user}">
                        <div class="mb-3">
                            <label class="fw-bold">Họ tên:</label>
                            <p class="ms-2">${user.fullName}</p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Username:</label>
                            <p class="ms-2">${user.username}</p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Email:</label>
                            <p class="ms-2">${user.email}</p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Số điện thoại:</label>
                            <p class="ms-2">${user.phoneNumber}</p>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Địa chỉ:</label>
                            <p class="ms-2">${user.address}</p>
                        </div>
                        <div class="text-center">
                            <a href="users?action=view&id=${user.id}"
                               class="btn btn-sm btn-outline-primary">
                                <i class="bi bi-person-lines-fill"></i> Xem chi tiết
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Hành động -->
            <div class="card shadow-sm">
                <div class="card-header fw-bold">
                    <i class="bi bi-gear"></i> Hành động
                </div>
                <div class="card-body">
                    <div class="d-grid gap-2">
                        <!-- Form cập nhật trạng thái -->
                        <form action="orders?action=updateStatus" method="post" class="mb-3">
                            <input type="hidden" name="orderId" value="${order.id}">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Cập nhật trạng thái:</label>
                                <select class="form-select" name="status">
                                    <option value="pending" ${order.status == 'pending' ? 'selected' : ''}>Đang chờ</option>
                                    <option value="processing" ${order.status == 'processing' ? 'selected' : ''}>Đang xử lý</option>
                                    <option value="shipped" ${order.status == 'shipped' ? 'selected' : ''}>Đang giao</option>
                                    <option value="delivered" ${order.status == 'delivered' ? 'selected' : ''}>Đã giao</option>
                                    <option value="cancelled" ${order.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-warning w-100">
                                <i class="bi bi-arrow-repeat"></i> Cập nhật trạng thái
                            </button>
                        </form>

                        <a href="orders?action=edit&id=${order.id}"
                           class="btn btn-outline-primary">
                            <i class="bi bi-pencil-square"></i> Chỉnh sửa đơn hàng
                        </a>

                        <a href="orders?action=delete&id=${order.id}"
                           onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng #${order.id}?')"
                           class="btn btn-outline-danger">
                            <i class="bi bi-trash"></i> Xóa đơn hàng
                        </a>

                        <a href="#" class="btn btn-outline-success">
                            <i class="bi bi-printer"></i> In hóa đơn
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng - TechX</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        .cart-container {
            padding: 30px 0;
            max-width: 1200px;
            margin: 0 auto;
        }

        .cart-item {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            background: white;
        }

        .product-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }

        .quantity-control {
            width: 120px;
        }

        .item-total {
            font-weight: 600;
            font-size: 18px;
            color: #d70018;
        }

        .cart-summary {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 25px;
            position: sticky;
            top: 20px;
        }
    </style>
</head>
<body>
<!-- Header -->
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container cart-container">
    <!-- Thông báo -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="success" scope="session"/>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <h1 class="mb-4">Giỏ hàng của bạn</h1>

    <c:choose>
        <c:when test="${empty cartItems}">
            <!-- Giỏ hàng trống -->
            <div class="text-center py-5">
                <i class="bi bi-cart-x" style="font-size: 80px; color: #dee2e6;"></i>
                <h3 class="my-3">Giỏ hàng của bạn đang trống</h3>
                <p class="text-muted mb-4">Hãy thêm sản phẩm vào giỏ hàng để tiếp tục mua sắm</p>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary btn-lg">
                    <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row">
                <!-- Danh sách sản phẩm -->
                <div class="col-lg-8">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="cart-item">
                            <div class="row align-items-center">
                                <div class="col-md-2">
                                    <img src="${item.image}"
                                         alt="${item.name}"
                                         class="product-image">
                                </div>

                                <div class="col-md-4">
                                    <h6 class="mb-2">${item.name}</h6>
                                    <div class="text-muted mb-2">
                                        <fmt:formatNumber value="${item.price}"
                                                          type="currency"
                                                          currencyCode="VND"/>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <form action="${pageContext.request.contextPath}/cart-update"
                                          method="post"
                                          class="d-flex align-items-center">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <div class="input-group quantity-control">
                                            <button class="btn btn-outline-secondary"
                                                    type="button"
                                                    onclick="updateQuantity(${item.productId}, -1)">-</button>
                                            <input type="number"
                                                   class="form-control text-center"
                                                   value="${item.quantity}"
                                                   min="1"
                                                   max="${item.product.stock}"
                                                   id="qty-${item.productId}"
                                                   readonly>
                                            <button class="btn btn-outline-secondary"
                                                    type="button"
                                                    onclick="updateQuantity(${item.productId}, 1)">+</button>
                                        </div>
                                    </form>
                                </div>

                                <div class="col-md-2">
                                    <div class="item-total">
                                        <fmt:formatNumber value="${item.total}"
                                                          type="currency"
                                                          currencyCode="VND"/>
                                    </div>
                                </div>

                                <div class="col-md-1">
                                    <a href="${pageContext.request.contextPath}/cart-remove?productId=${item.productId}"
                                       class="btn btn-outline-danger btn-sm"
                                       onclick="return confirm('Xóa sản phẩm này khỏi giỏ hàng?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Nút hành động -->
                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                        </a>

                        <form action="${pageContext.request.contextPath}/cart" method="post">
                            <input type="hidden" name="action" value="clear">
                            <button type="submit" class="btn btn-outline-danger"
                                    onclick="return confirm('Xóa toàn bộ giỏ hàng?')">
                                <i class="bi bi-trash me-2"></i>Xóa tất cả
                            </button>
                        </form>
                    </div>
                </div>

                <!-- Tóm tắt đơn hàng -->
                <div class="col-lg-4">
                    <div class="cart-summary">
                        <h5 class="mb-4">Tóm tắt đơn hàng</h5>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <strong>
                                <fmt:formatNumber value="${cartTotal}"
                                                  type="currency"
                                                  currencyCode="VND"/>
                            </strong>
                        </div>

                        <div class="d-flex justify-content-between mb-2">
                            <span>Phí vận chuyển:</span>
                            <span class="text-success">Miễn phí</span>
                        </div>

                        <hr class="my-3">

                        <div class="d-flex justify-content-between mb-4">
                            <strong>Tổng cộng:</strong>
                            <strong class="text-danger fs-5">
                                <fmt:formatNumber value="${cartTotal}"
                                                  type="currency"
                                                  currencyCode="VND"/>
                            </strong>
                        </div>

                        <!-- Nút thanh toán -->
                        <a href="${pageContext.request.contextPath}/checkout"
                           class="btn btn-danger w-100 py-3 fw-bold">
                            <i class="bi bi-credit-card me-2"></i>Tiến hành thanh toán
                        </a>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function updateQuantity(productId, change) {
        const input = document.getElementById('qty-' + productId);
        let currentQty = parseInt(input.value);
        let newQty = currentQty + change;

        if (newQty < 1) return;

        // Cập nhật qua AJAX
        fetch('${pageContext.request.contextPath}/cart-update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'productId=' + productId + '&quantity=' + newQty
        })
            .then(response => {
                if (response.ok) {
                    location.reload(); // Reload trang
                }
            });
    }
</script>
</body>
</html>
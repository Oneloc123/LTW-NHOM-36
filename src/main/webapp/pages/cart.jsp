<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="/assets/css/footer.css">
    <link rel="stylesheet" href="/assets/css/home.css">
    <link rel="stylesheet" href="/assets/css/header.css">
    <style>
        .empty-cart {
            text-align: center;
            padding: 80px 20px;
        }
        .empty-cart i {
            font-size: 5rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
        .card img {
            object-fit: cover;
            height: 80px;
            width: 80px;
        }
        .cart-summary {
            position: sticky;
            top: 20px;
        }
        .cart-item {
            transition: all 0.3s;
        }
        .cart-item:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-4 mb-5">
    <h2 class="mb-4">
        <i class="bi bi-cart3 me-2"></i>Giỏ Hàng
        <c:if test="${not empty cartItems}">
            <span class="badge bg-primary ms-2">${totalQuantity} sản phẩm</span>
        </c:if>
    </h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <!-- EMPTY CART -->
            <div class="empty-cart">
                <i class="bi bi-cart-x"></i>
                <h3 class="text-muted mb-3">Giỏ hàng của bạn đang trống</h3>
                <p class="text-muted mb-4">Hãy thêm sản phẩm để bắt đầu mua sắm</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-lg">
                    <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="row g-4">
                <!-- CART LIST -->
                <div class="col-lg-8">
                    <c:set var="subtotal" value="0"/>

                    <c:forEach var="item" items="${cartItems}">
                        <c:set var="itemTotal" value="${item.price * item.quantity}"/>
                        <c:set var="subtotal" value="${subtotal + itemTotal}"/>
                        <c:set var="imageUrl" value="${requestScope['image_' += item.product.id]}"/>

                        <div class="card mb-3 cart-item">
                            <div class="card-body">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <img src="${not empty imageUrl ? imageUrl : 'https://via.placeholder.com/80x80?text=No+Image'}"
                                             class="img-fluid rounded" alt="${item.product.name}">
                                    </div>
                                    <div class="col-md-6">
                                        <h5 class="card-title mb-1">${item.product.name}</h5>
                                        <p class="text-muted small mb-2">${item.product.shortDescription}</p>
                                        <div class="d-flex align-items-center">
                                            <span class="text-primary fw-bold">
                                                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center justify-content-end">
                                            <!-- UPDATE FORM -->
                                            <form action="${pageContext.request.contextPath}/cart-update" method="post" class="me-3">
                                                <input type="hidden" name="productId" value="${item.product.id}">
                                                <div class="input-group" style="width: 120px;">
                                                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(this, -1)">-</button>
                                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="99"
                                                           class="form-control text-center" readonly>
                                                    <button class="btn btn-outline-secondary" type="button" onclick="changeQuantity(this, 1)">+</button>
                                                </div>
                                            </form>

                                            <!-- REMOVE BUTTON -->
                                            <a href="${pageContext.request.contextPath}/cart-remove?productId=${item.product.id}"
                                               class="btn btn-outline-danger"
                                               onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </div>
                                        <div class="text-end mt-2">
                                            <small class="text-muted">Tổng:</small>
                                            <span class="fw-bold text-danger ms-2">
                                                <fmt:formatNumber value="${itemTotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
                        </a>
                        <a href="${pageContext.request.contextPath}/cart-remove-all" class="btn btn-outline-danger"
                           onclick="return confirm('Bạn có chắc muốn xóa tất cả sản phẩm khỏi giỏ hàng?')">
                            <i class="bi bi-trash me-2"></i>Xóa tất cả
                        </a>
                    </div>
                </div>

                <!-- SUMMARY -->
                <div class="col-lg-4">
                    <div class="card cart-summary">
                        <div class="card-body">
                            <h5 class="card-title mb-4">
                                <i class="bi bi-receipt me-2"></i>Tổng kết đơn hàng
                            </h5>

                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Tạm tính:</span>
                                    <strong><fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></strong>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Vận chuyển:</span>
                                    <span class="text-success">Miễn phí</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Giảm giá:</span>
                                    <span class="text-success">0₫</span>
                                </div>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5 class="mb-0">Tổng cộng:</h5>
                                <h4 class="text-danger mb-0">
                                    <fmt:formatNumber value="${subtotal}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </h4>
                            </div>

                            <!-- THANH TOÁN BUTTON -->
                            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary w-100 btn-lg mb-3">
                                <i class="bi bi-credit-card me-2"></i>Thanh toán
                            </a>

                            <div class="text-center small text-muted">
                                <i class="bi bi-shield-check text-success me-1"></i>
                                Thanh toán an toàn • Đảm bảo hoàn tiền
                            </div>
                        </div>
                    </div>

                    <!-- PROMO CODE -->
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Thêm phần footer nếu cần -->


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Hàm thay đổi số lượng
    function changeQuantity(button, change) {
        const input = button.parentElement.querySelector('input[name="quantity"]');
        let currentValue = parseInt(input.value);
        let newValue = currentValue + change;

        if (newValue < 1) newValue = 1;
        if (newValue > 99) newValue = 99;

        if (newValue !== currentValue) {
            input.value = newValue;
            // Tự động submit form
            button.closest('form').submit();
        }
    }

    // Hàm xử lý thanh toán
    function checkout() {
        alert('Chức năng thanh toán đang được phát triển. Cảm ơn bạn đã quan tâm!');
        // window.location.href = "${pageContext.request.contextPath}/checkout";
    }

    // Tự động submit khi thay đổi số lượng từ input
    document.querySelectorAll('input[name="quantity"]').forEach(input => {
        input.addEventListener('change', function() {
            if (this.value < 1) this.value = 1;
            if (this.value > 99) this.value = 99;
            this.closest('form').submit();
        });
    });

    // Kiểm tra console để debug
    console.log('Cart items count:', ${not empty cartItems ? cartItems.size() : 0});
</script>
</body>
</html>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .checkout-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }
        .step {
            text-align: center;
            flex: 1;
            position: relative;
        }
        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            font-weight: bold;
        }
        .step.active .step-number {
            background: #0d6efd;
            color: white;
        }
        .step.completed .step-number {
            background: #198754;
            color: white;
        }
        .was-validated .form-control:invalid {
            border-color: #dc3545;
        }
        .invalid-feedback {
            display: none;
        }
        .was-validated .form-control:invalid ~ .invalid-feedback {
            display: block;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container mt-4 mb-5">
    <!-- Thanh tiến trình -->
    <div class="checkout-steps">
        <div class="step completed">
            <div class="step-number">1</div>
            <div>Giỏ hàng</div>
        </div>
        <div class="step active">
            <div class="step-number">2</div>
            <div>Thanh toán</div>
        </div>
        <div class="step">
            <div class="step-number">3</div>
            <div>Hoàn tất</div>
        </div>
    </div>

    <div class="row g-4">
        <!-- Thông tin thanh toán -->
        <div class="col-lg-8">
            <form id="checkoutForm" action="${pageContext.request.contextPath}/checkout-process" method="post" novalidate>
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-person me-2"></i>Thông tin giao hàng</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="fullName" class="form-label">Họ và tên *</label>
                                <input type="text" class="form-control" id="fullName" name="fullName"
                                       value="${defaultName}" required>
                                <div class="invalid-feedback">Vui lòng nhập họ và tên</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label">Số điện thoại *</label>
                                <input type="tel" class="form-control" id="phone" name="phone"
                                       value="${defaultPhone}" pattern="[0-9]{10,11}" required>
                                <div class="invalid-feedback">Vui lòng nhập số điện thoại hợp lệ (10-11 số)</div>
                            </div>
                            <div class="col-md-12 mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${defaultEmail}">
                                <div class="invalid-feedback">Vui lòng nhập email hợp lệ</div>
                            </div>
                            <div class="col-md-12 mb-3">
                                <label for="address" class="form-label">Địa chỉ giao hàng *</label>
                                <textarea class="form-control" id="address" name="address"
                                          rows="3" required>${defaultAddress}</textarea>
                                <div class="invalid-feedback">Vui lòng nhập địa chỉ giao hàng</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="city" class="form-label">Thành phố *</label>
                                <select class="form-select" id="city" name="city" required>
                                    <option value="">Chọn thành phố</option>
                                    <option value="Hà Nội">Hà Nội</option>
                                    <option value="TP. Hồ Chí Minh">TP. Hồ Chí Minh</option>
                                    <option value="Đà Nẵng">Đà Nẵng</option>
                                    <option value="Hải Phòng">Hải Phòng</option>
                                    <option value="Cần Thơ">Cần Thơ</option>
                                </select>
                                <div class="invalid-feedback">Vui lòng chọn thành phố</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="district" class="form-label">Quận/Huyện *</label>
                                <input type="text" class="form-control" id="district" name="district" required>
                                <div class="invalid-feedback">Vui lòng nhập quận/huyện</div>
                            </div>
                            <div class="col-md-12 mb-3">
                                <label for="notes" class="form-label">Ghi chú đơn hàng</label>
                                <textarea class="form-control" id="notes" name="notes" rows="2"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-credit-card me-2"></i>Phương thức thanh toán</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="radio" name="paymentMethod"
                                   id="cod" value="cod" checked>
                            <label class="form-check-label" for="cod">
                                <i class="bi bi-cash-coin me-2"></i>Thanh toán khi nhận hàng (COD)
                            </label>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="radio" name="paymentMethod"
                                   id="bank_transfer" value="bank_transfer">
                            <label class="form-check-label" for="bank_transfer">
                                <i class="bi bi-bank me-2"></i>Chuyển khoản ngân hàng
                            </label>
                        </div>
                        <div class="form-check mb-3">
                            <input class="form-check-input" type="radio" name="paymentMethod"
                                   id="momo" value="momo">
                            <label class="form-check-label" for="momo">
                                <i class="bi bi-phone me-2"></i>Ví điện tử MoMo
                            </label>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Tóm tắt đơn hàng -->
        <div class="col-lg-4">
            <div class="card sticky-top" style="top: 20px;">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="bi bi-receipt me-2"></i>Đơn hàng của bạn</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <h6>Sản phẩm</h6>
                        <c:forEach var="item" items="${cartItems}">
                            <c:set var="imageUrl" value="${requestScope['image_' += item.product.id]}"/>
                            <div class="d-flex align-items-center mb-2">
                                <img src="${not empty imageUrl ? imageUrl : 'https://via.placeholder.com/40x40?text=No+Image'}"
                                     class="rounded me-2" width="40" height="40"
                                     alt="${item.product.name}">
                                <div class="flex-grow-1">
                                    <div class="small">${item.product.name}</div>
                                    <div class="text-muted small">SL: ${item.quantity} x
                                        <fmt:formatNumber value="${item.price}"
                                                          type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <fmt:formatNumber value="${item.price * item.quantity}"
                                                      type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <hr>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Tạm tính:</span>
                            <strong><fmt:formatNumber value="${total}"
                                                      type="currency" currencySymbol="₫" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Phí vận chuyển:</span>
                            <span class="text-success">Miễn phí</span>
                        </div>
                    </div>

                    <hr>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="mb-0">Tổng cộng:</h5>
                        <h4 class="text-danger mb-0">
                            <fmt:formatNumber value="${total}"
                                              type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </h4>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="button" class="btn btn-primary btn-lg" onclick="submitOrder()">
                            <i class="bi bi-check-circle me-2"></i>Đặt hàng
                        </button>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-2"></i>Quay lại giỏ hàng
                        </a>
                    </div>

                    <div class="alert alert-info mt-3 small">
                        <i class="bi bi-info-circle me-2"></i>
                        Bằng cách nhấn "Đặt hàng", bạn đồng ý với
                        <a href="${pageContext.request.contextPath}/terms">Điều khoản dịch vụ</a> của chúng tôi.
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
    function submitOrder() {
        const form = document.getElementById('checkoutForm');

        // Kích hoạt validation
        form.classList.add('was-validated');

        if (!form.checkValidity()) {
            // Tìm trường không hợp lệ đầu tiên và focus vào đó
            const firstInvalid = form.querySelector(':invalid');
            if (firstInvalid) {
                firstInvalid.focus();
            }
            return;
        }

        // Hiển thị loading
        const submitBtn = document.querySelector('button[onclick="submitOrder()"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Đang xử lý...';
        submitBtn.disabled = true;

        // Lấy form data
        const formData = new FormData(form);

        // Thêm csrf token nếu có
        const csrfToken = document.querySelector('meta[name="_csrf"]');
        if (csrfToken) {
            formData.append(csrfToken.getAttribute('content-name'), csrfToken.getAttribute('content'));
        }

        // Gửi yêu cầu đặt hàng
        fetch('${pageContext.request.contextPath}/checkout-process', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Chuyển hướng đến trang thành công
                    window.location.href = data.redirect;
                } else {
                    // Hiển thị thông báo lỗi
                    alert('Lỗi: ' + data.message);
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;

                    // Nếu cần đăng nhập, chuyển hướng
                    if (data.redirect) {
                        window.location.href = data.redirect;
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Có lỗi xảy ra khi đặt hàng. Vui lòng thử lại.');
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            });
    }

    // Tự động điền thông tin nếu đã đăng nhập
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Checkout page loaded');

        // Format số điện thoại
        const phoneInput = document.getElementById('phone');
        if (phoneInput) {
            phoneInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/\D/g, '');
                if (value.length > 11) value = value.substring(0, 11);
                e.target.value = value;
            });
        }

        // Lưu địa chỉ vào localStorage khi thay đổi
        const addressFields = ['address', 'city', 'district'];
        addressFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            if (field) {
                // Khôi phục giá trị từ localStorage
                const savedValue = localStorage.getItem(`checkout_${fieldId}`);
                if (savedValue && !field.value) {
                    field.value = savedValue;
                }

                // Lưu vào localStorage khi thay đổi
                field.addEventListener('change', function() {
                    localStorage.setItem(`checkout_${fieldId}`, this.value);
                });
            }
        });
    });
</script>
</body>
</html>
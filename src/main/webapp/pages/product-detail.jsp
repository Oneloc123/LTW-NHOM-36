<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${p.name} - TechX</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/footer.css">
  <link rel="stylesheet" href="../assets/css/header.css">
  <link rel="stylesheet" href="../assets/css/product-detail.css">
  <style>
    .product-container {
      display: flex;
      flex-wrap: wrap;
      gap: 30px;
      margin-top: 30px;
    }
    .product-main {
      flex: 1;
      min-width: 300px;
    }
    .product-sidebar {
      width: 350px;
    }
    .main-image {
      width: 100%;
      height: 400px;
      object-fit: contain;
      border: 1px solid #eee;
      border-radius: 10px;
      background: #f8f9fa;
      margin-bottom: 15px;
    }
    .thumbnail-container {
      display: flex;
      gap: 10px;
      overflow-x: auto;
      padding: 10px 0;
    }
    .thumbnail {
      width: 80px;
      height: 80px;
      object-fit: cover;
      border: 2px solid #ddd;
      border-radius: 5px;
      cursor: pointer;
      transition: all 0.3s;
    }
    .thumbnail:hover, .thumbnail.active {
      border-color: #007bff;
    }
    .product-title {
      font-size: 24px;
      font-weight: bold;
      margin-bottom: 10px;
    }
    .product-price {
      font-size: 28px;
      color: #dc3545;
      font-weight: bold;
      margin: 15px 0;
    }
    .product-old-price {
      text-decoration: line-through;
      color: #999;
      font-size: 18px;
      margin-right: 10px;
    }
    .product-discount {
      background: #dc3545;
      color: white;
      padding: 3px 10px;
      border-radius: 4px;
      font-size: 14px;
    }
    .quantity-control {
      display: flex;
      align-items: center;
      gap: 10px;
      margin: 20px 0;
    }
    .quantity-btn {
      width: 40px;
      height: 40px;
      border: 1px solid #ddd;
      background: #f8f9fa;
      border-radius: 5px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 20px;
    }
    .quantity-input {
      width: 70px;
      height: 40px;
      text-align: center;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 16px;
    }
    .action-buttons {
      display: flex;
      gap: 15px;
      margin: 25px 0;
    }
    .btn-buy-now, .btn-add-cart {
      flex: 1;
      padding: 15px;
      border: none;
      border-radius: 8px;
      font-weight: bold;
      font-size: 16px;
      cursor: pointer;
      transition: all 0.3s;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }
    .btn-buy-now {
      background: linear-gradient(135deg, #ff6b6b, #ff4757);
      color: white;
    }
    .btn-add-cart {
      background: #007bff;
      color: white;
    }
    .btn-buy-now:hover {
      background: linear-gradient(135deg, #ff4757, #ff3838);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
    }
    .btn-add-cart:hover {
      background: #0056b3;
      transform: translateY(-2px);
    }
    .product-meta {
      margin: 20px 0;
      padding: 20px;
      background: #f8f9fa;
      border-radius: 10px;
    }
    .meta-item {
      display: flex;
      justify-content: space-between;
      padding: 10px 0;
      border-bottom: 1px solid #eee;
    }
    .meta-item:last-child {
      border-bottom: none;
    }
    .product-tabs {
      margin-top: 40px;
    }
    .tab-buttons {
      display: flex;
      border-bottom: 2px solid #eee;
      margin-bottom: 20px;
    }
    .tab-button {
      padding: 15px 30px;
      background: none;
      border: none;
      font-size: 16px;
      font-weight: 600;
      color: #666;
      cursor: pointer;
      position: relative;
    }
    .tab-button.active {
      color: #007bff;
    }
    .tab-button.active::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      right: 0;
      height: 3px;
      background: #007bff;
    }
    .tab-content {
      padding: 20px;
      line-height: 1.8;
    }
    .stock-status {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 14px;
      font-weight: 600;
    }
    .in-stock {
      background: #d4edda;
      color: #155724;
    }
    .out-of-stock {
      background: #f8d7da;
      color: #721c24;
    }
    .wishlist-btn {
      position: absolute;
      top: 15px;
      right: 15px;
      width: 40px;
      height: 40px;
      background: white;
      border: 1px solid #ddd;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 20px;
      color: #dc3545;
      z-index: 10;
    }
    .wishlist-btn:hover {
      background: #ffe6e6;
    }
    .toast {
      position: fixed;
      bottom: 30px;
      right: 30px;
      background: #28a745;
      color: white;
      padding: 15px 25px;
      border-radius: 10px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.2);
      display: flex;
      align-items: center;
      gap: 15px;
      z-index: 1000;
      transform: translateY(100px);
      opacity: 0;
      transition: all 0.3s ease;
    }
    .toast.show {
      transform: translateY(0);
      opacity: 1;
    }
    .toast.error {
      background: #dc3545;
    }
    @media (max-width: 768px) {
      .product-container {
        flex-direction: column;
      }
      .product-sidebar {
        width: 100%;
      }
      .action-buttons {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
<!-- Header -->
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main class="container py-4">
  <!-- Breadcrumb -->
  <nav aria-label="breadcrumb" class="mb-4">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/home">Trang chủ</a></li>
      <li class="breadcrumb-item"><a href="/products">Sản phẩm</a></li>
      <li class="breadcrumb-item active" aria-current="page">${p.name}</li>
    </ol>
  </nav>

  <!-- Product Container -->
  <div class="product-container">
    <!-- Left Column - Product Images -->
    <div class="product-main">
      <!-- Wishlist Button -->
      <button class="wishlist-btn" id="wishlistBtn">
        <i class="bi bi-heart"></i>
      </button>

      <!-- Main Image -->
      <div class="main-image-container">
        <img id="mainImage" src="${p.imagesTop}" alt="${p.name}" class="main-image">
      </div>

      <!-- Thumbnails -->
      <div class="thumbnail-container">
        <c:forEach var="img" items="${p.images}" varStatus="status">
          <img src="${img}"
               alt="Thumbnail ${status.index + 1}"
               class="thumbnail ${status.index == 0 ? 'active' : ''}"
               onclick="changeMainImage('${img}')">
        </c:forEach>
      </div>

      <!-- Product Details -->
      <div class="product-details">
        <h1 class="product-title">${p.name}</h1>

        <!-- Rating -->
        <div class="rating mb-3">
                    <span class="text-warning">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-half"></i>
                    </span>
          <span class="text-muted ms-2">4.5 (125 đánh giá)</span>
        </div>

        <!-- Price -->
        <div class="d-flex align-items-center mb-3">
          <div class="product-price">
            <fmt:formatNumber value="${p.price}" type="currency"/>
          </div>
          <c:if test="${p.discount > 0}">
            <div class="product-old-price ms-3">
              <fmt:formatNumber value="${p.price * 100 / (100 - p.discount)}" type="currency"/>
            </div>
            <div class="product-discount ms-2">
              -${p.discount}%
            </div>
          </c:if>
        </div>

        <!-- Short Description -->
        <div class="mb-4">
          <p>${p.shortDescription}</p>
        </div>
      </div>
    </div>

    <!-- Right Column - Product Info & Actions -->
    <div class="product-sidebar">
      <div class="card">
        <div class="card-body">
          <!-- Stock Status -->
          <div class="d-flex justify-content-between align-items-center mb-4">
            <span class="text-muted">Tình trạng:</span>
            <c:choose>
              <c:when test="${p.stock > 0}">
                                <span class="stock-status in-stock">
                                    <i class="bi bi-check-circle"></i>
                                    Còn ${p.stock} sản phẩm
                                </span>
              </c:when>
              <c:otherwise>
                                <span class="stock-status out-of-stock">
                                    <i class="bi bi-x-circle"></i>
                                    Hết hàng
                                </span>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Shipping -->
          <div class="mb-4">
            <div class="text-muted mb-2">Vận chuyển:</div>
            <div class="d-flex align-items-center">
              <i class="bi bi-truck text-success me-2"></i>
              <span>Giao hàng toàn quốc • 2-4 ngày</span>
            </div>
          </div>

          <!-- Quantity -->
          <div class="mb-4">
            <div class="text-muted mb-2">Số lượng:</div>
            <div class="quantity-control">
              <button class="quantity-btn" onclick="decreaseQuantity()">-</button>
              <input type="number"
                     id="quantityInput"
                     class="quantity-input"
                     value="1"
                     min="1"
                     max="${p.stock}"
                     onchange="validateQuantity()">
              <button class="quantity-btn" onclick="increaseQuantity()">+</button>
            </div>
            <div class="text-muted mt-2">
              <c:if test="${p.stock > 0}">
                Tối đa ${p.stock} sản phẩm
              </c:if>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="action-buttons">
            <!-- Buy Now Button -->
            <c:choose>
              <c:when test="${p.stock > 0}">
                <form action="${pageContext.request.contextPath}/checkout"
                      method="post"
                      id="buyNowForm">
                  <input type="hidden" name="productId" value="${p.id}">
                  <input type="hidden" name="quantity" value="1" id="buyNowQuantity">
                  <button type="submit" class="btn-buy-now">
                    <i class="bi bi-bag-check"></i>
                    Mua ngay
                  </button>
                </form>
              </c:when>
              <c:otherwise>
                <button class="btn-buy-now" disabled style="opacity: 0.6;">
                  <i class="bi bi-bag-x"></i>
                  Hết hàng
                </button>
              </c:otherwise>
            </c:choose>

            <!-- Add to Cart Button -->
            <c:choose>
              <c:when test="${p.stock > 0}">
                <form action="${pageContext.request.contextPath}/add-to-cart"
                      method="post"
                      id="addToCartForm">
                  <input type="hidden" name="productId" value="${p.id}">
                  <input type="hidden" name="quantity" value="1" id="cartQuantity">
                  <input type="hidden" name="redirect" value="product-detail?id=${p.id}">
                  <button type="submit" class="btn-add-cart">
                    <i class="bi bi-cart-plus"></i>
                    Thêm giỏ hàng
                  </button>
                </form>
              </c:when>
              <c:otherwise>
                <button class="btn-add-cart" disabled style="opacity: 0.6;">
                  <i class="bi bi-cart-x"></i>
                  Hết hàng
                </button>
              </c:otherwise>
            </c:choose>
          </div>

          <!-- Product Meta -->
          <div class="product-meta">
            <div class="meta-item">
              <span class="text-muted">SKU:</span>
              <span>${p.sku}</span>
            </div>
            <div class="meta-item">
              <span class="text-muted">Thương hiệu:</span>
              <span>${p.brand}</span>
            </div>
            <div class="meta-item">
              <span class="text-muted">Danh mục:</span>
              <span>${p.category}</span>
            </div>
            <div class="meta-item">
              <span class="text-muted">Bảo hành:</span>
              <span>12 tháng</span>
            </div>
          </div>

          <!-- Additional Info -->
          <div class="text-center mt-3">
            <small class="text-muted">
              <i class="bi bi-shield-check me-1"></i>
              Sản phẩm chính hãng • Đổi trả trong 30 ngày
            </small>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Product Tabs -->
  <div class="product-tabs">
    <div class="tab-buttons">
      <button class="tab-button active" onclick="showTab('description')">Mô tả</button>
      <button class="tab-button" onclick="showTab('specs')">Thông số</button>
      <button class="tab-button" onclick="showTab('reviews')">Đánh giá</button>
    </div>

    <div class="tab-content">
      <!-- Description Tab -->
      <div id="description" class="tab-pane active">
        ${p.fullDescription}
      </div>

      <!-- Specifications Tab -->
      <div id="specs" class="tab-pane" style="display: none;">
        <table class="table table-bordered">
          <tbody>
          <tr>
            <td style="width: 30%;" class="text-muted">Kích thước</td>
            <td>${p.dimensions}</td>
          </tr>
          <tr>
            <td class="text-muted">Trọng lượng</td>
            <td>${p.weight} g</td>
          </tr>
          <tr>
            <td class="text-muted">Màu sắc</td>
            <td>${p.color}</td>
          </tr>
          <tr>
            <td class="text-muted">Chất liệu</td>
            <td>${p.material}</td>
          </tr>
          <tr>
            <td class="text-muted">Xuất xứ</td>
            <td>${p.origin}</td>
          </tr>
          </tbody>
        </table>
      </div>

      <!-- Reviews Tab -->
      <div id="reviews" class="tab-pane" style="display: none;">
        <!-- Reviews will be loaded here -->
        <div class="text-center py-4">
          <p class="text-muted">Chưa có đánh giá nào.</p>
          <button class="btn btn-outline-primary" onclick="openReviewModal()">
            <i class="bi bi-pencil"></i> Viết đánh giá
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- Toast Notification -->
  <div class="toast" id="toast">
    <i class="bi bi-check-circle" id="toastIcon"></i>
    <span id="toastMessage"></span>
  </div>
</main>

<!-- Footer -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Product Image Gallery
  function changeMainImage(src) {
    document.getElementById('mainImage').src = src;

    // Update active thumbnail
    document.querySelectorAll('.thumbnail').forEach(thumb => {
      thumb.classList.remove('active');
      if (thumb.src.includes(src)) {
        thumb.classList.add('active');
      }
    });
  }

  // Quantity Control
  let quantity = 1;
  const maxStock = ${p.stock};

  function validateQuantity() {
    const input = document.getElementById('quantityInput');
    let value = parseInt(input.value) || 1;

    if (value < 1) value = 1;
    if (value > maxStock) value = maxStock;

    input.value = value;
    quantity = value;

    // Update hidden inputs
    document.getElementById('cartQuantity').value = value;
    document.getElementById('buyNowQuantity').value = value;
  }

  function decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      document.getElementById('quantityInput').value = quantity;
      validateQuantity();
    }
  }

  function increaseQuantity() {
    if (quantity < maxStock) {
      quantity++;
      document.getElementById('quantityInput').value = quantity;
      validateQuantity();
    }
  }

  // Tab Switching
  function showTab(tabId) {
    // Hide all tabs
    document.querySelectorAll('.tab-pane').forEach(tab => {
      tab.style.display = 'none';
    });

    // Remove active class from all buttons
    document.querySelectorAll('.tab-button').forEach(btn => {
      btn.classList.remove('active');
    });

    // Show selected tab
    document.getElementById(tabId).style.display = 'block';
    event.target.classList.add('active');
  }

  // Add to Cart with AJAX
  document.getElementById('addToCartForm').addEventListener('submit', function(e) {
    e.preventDefault();

    // Check if user is logged in
    <c:if test="${empty sessionScope.id}">
    window.location.href = '${pageContext.request.contextPath}/login?redirect=' +
            encodeURIComponent(window.location.href);
    return;
    </c:if>

    const formData = new FormData(this);

    // Show loading state
    const submitBtn = this.querySelector('button[type="submit"]');
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<i class="bi bi-hourglass-split"></i> Đang thêm...';
    submitBtn.disabled = true;

    fetch(this.action, {
      method: 'POST',
      body: formData
    })
            .then(response => {
              if (response.redirected) {
                window.location.href = response.url;
                return;
              }
              return response.json();
            })
            .then(data => {
              if (data && data.success) {
                showToast('Đã thêm ' + quantity + ' sản phẩm vào giỏ hàng!', 'success');

                // Update cart count in header
                updateCartCount(data.cartCount);
              } else {
                showToast('Có lỗi xảy ra!', 'error');
              }
            })
            .catch(error => {
              console.error('Error:', error);
              showToast('Có lỗi kết nối!', 'error');
            })
            .finally(() => {
              // Restore button state
              submitBtn.innerHTML = originalText;
              submitBtn.disabled = false;
            });
  });

  // Wishlist Button
  document.getElementById('wishlistBtn').addEventListener('click', function() {
    <c:if test="${empty sessionScope.id}">
    window.location.href = '${pageContext.request.contextPath}/login?redirect=' +
            encodeURIComponent(window.location.href);
    return;
    </c:if>

    const btn = this;
    const icon = btn.querySelector('i');
    const isActive = icon.classList.contains('bi-heart-fill');

    fetch('${pageContext.request.contextPath}/wishlist', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'productId=${p.id}&action=' + (isActive ? 'remove' : 'add')
    })
            .then(response => response.json())
            .then(data => {
              if (data.success) {
                if (isActive) {
                  icon.classList.remove('bi-heart-fill');
                  icon.classList.add('bi-heart');
                  showToast('Đã xóa khỏi danh sách yêu thích', 'success');
                } else {
                  icon.classList.remove('bi-heart');
                  icon.classList.add('bi-heart-fill');
                  showToast('Đã thêm vào danh sách yêu thích', 'success');
                }
              } else {
                showToast(data.message || 'Có lỗi xảy ra!', 'error');
              }
            })
            .catch(error => {
              console.error('Error:', error);
              showToast('Có lỗi kết nối!', 'error');
            });
  });

  // Toast Notification
  function showToast(message, type = 'success') {
    const toast = document.getElementById('toast');
    const toastIcon = document.getElementById('toastIcon');
    const toastMessage = document.getElementById('toastMessage');

    toastMessage.textContent = message;

    if (type === 'success') {
      toast.style.background = '#28a745';
      toastIcon.className = 'bi bi-check-circle';
    } else {
      toast.style.background = '#dc3545';
      toastIcon.className = 'bi bi-exclamation-circle';
    }

    toast.classList.add('show');

    setTimeout(() => {
      toast.classList.remove('show');
    }, 3000);
  }

  function updateCartCount(count) {
    // Update cart badge in header
    const cartBadge = document.querySelector('.badge.bg-danger');
    if (cartBadge) {
      cartBadge.textContent = count;
      cartBadge.style.display = count > 0 ? 'inline-block' : 'none';
    }

    // If no badge exists, create one
    const cartBtn = document.querySelector('a[href="/cart"]');
    if (cartBtn && count > 0) {
      let badge = cartBtn.querySelector('.badge');
      if (!badge) {
        badge = document.createElement('span');
        badge.className = 'position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger';
        cartBtn.appendChild(badge);
      }
      badge.textContent = count;
    }
  }

  // Initialize
  document.addEventListener('DOMContentLoaded', function() {
    validateQuantity(); // Set initial values

    // Check if product is in wishlist
    <c:if test="${not empty sessionScope.id}">
    fetch('${pageContext.request.contextPath}/wishlist/check?productId=${p.id}')
            .then(response => response.json())
            .then(data => {
              if (data.inWishlist) {
                const icon = document.querySelector('#wishlistBtn i');
                icon.classList.remove('bi-heart');
                icon.classList.add('bi-heart-fill');
              }
            });
    </c:if>
  });

  function openReviewModal() {
    alert('Chức năng đánh giá sẽ được phát triển sau!');
  }
</script>
</body>
</html>
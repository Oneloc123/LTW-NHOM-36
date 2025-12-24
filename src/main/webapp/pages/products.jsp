    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Thiết bị AI Mini | TechX</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
      <link rel="stylesheet" href="../assets/css/footer.css">
      <link rel="stylesheet" href="../assets/css/products.css">
      <link rel="stylesheet" href="../assets/css/header.css">
    </head>

    <body>
      <!-- ================= Header ================= -->
      <div class="header-scope">
        <header class="header-scope navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
          <div class="container">
            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center fw-bold text-primary" href="/index.html">
              <i class="bi bi-camera fs-4 me-2"></i>
              <span>TechX</span>
            </a>

            <!-- Toggle (mobile) -->
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
              aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
              <i class="bi bi-list fs-2 text-primary"></i>
            </button>

            <!-- Nav links -->
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
              <ul class="navbar-nav align-items-lg-center gap-lg-3">
                <li class="nav-item"><a class="nav-link " href="/index.html">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="/pages/shop.html">Cửa hàng</a></li>

                <li class="nav-item"><a class="nav-link" href="/pages/products.html">Sản phẩm</a></li>


                <li class="nav-item"><a class="nav-link" href="/pages/blog.html">Blog</a></li>
                <li class="nav-item"><a class="nav-link" href="/pages/contact.html">Liên hệ</a></li>
                <li class="nav-item"><a class="nav-link" href="/pages/order-history.jsp">Đơn hàng</a></li>
                <!-- Dropdown -->
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
                    aria-expanded="false">
                    Tài khoản
                  </a>
                  <ul class="dropdown-menu border-0 shadow rounded-3" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item" href="/pages/profile.html">Thông tin tài khoản</a></li>
                    <li>
                      <hr class="dropdown-divider">
                    </li>
                    <li><a class="dropdown-item" href="wishList.html">Danh sách sản phẩm yêu thích</a></li>
                    <li><a class="dropdown-item" href="notification.html">Xem thông báo</a></li>
                    <li><a class="dropdown-item" href="viewed-product.html">Sản phẩm đã xem</a>
                    </li>
                  </ul>
                </li>
              </ul>

              <!-- Login & Cart -->
              <div class="ms-lg-3 mt-3 mt-lg-0 d-flex align-items-center gap-2">
                <a href="/pages/login.html" class="btn btn-outline-primary btn-sm d-flex align-items-center">
                  <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                </a>
                <a href="/pages/cart.jsp" class="btn btn-primary btn-sm d-flex align-items-center">
                  <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                </a>
              </div>
            </div>
          </div>
        </header>
      </div>

      <main class="products-page">
        <!-- HERO -->
        <section class="hero">
          <div class="hero-box">
            <h1 class="hero-title">Thiết bị AI Mini</h1>
            <p class="hero-subtitle">Công nghệ tương lai gói gọn trong lòng bàn tay – Nhỏ nhưng đầy sức mạnh.</p>
          </div>
        </section>

        <!-- FILTER BAR -->
        <section class="filter-bar">
          <div class="filter-container">
            <input type="text" id="searchInput" placeholder="🔍 Tìm kiếm sản phẩm, thương hiệu...">
            <select id="sortSelect">
              <option value="">Sắp xếp</option>
              <option value="asc">Giá tăng dần</option>
              <option value="desc">Giá giảm dần</option>
              <option value="new">Mới nhất</option>
            </select>

            <div class="price-filter">
              <input type="number" id="minPrice" placeholder="Giá từ">
              <span>-</span>
              <input type="number" id="maxPrice" placeholder="đến">
            </div>

            <button id="filterBtn" class="filter-btn">Lọc</button>
          </div>
        </section>

        <!-- CATEGORY TABS -->
        <section class="category-tabs">
          <div class="tabs-container">
            <button class="tab-btn active" data-category="all">Tất cả</button>
            <button class="tab-btn" data-category="mini-tech">Công nghệ mini</button>
            <button class="tab-btn" data-category="ai-device">Thiết bị AI</button>
            <button class="tab-btn" data-category="fun-tech">Đồ chơi công nghệ</button>
            <button class="tab-btn" data-category="creative">Phụ kiện sáng tạo</button>
          </div>
        </section>

        <!-- PRODUCT GRID -->
          <section class="product-grid" id="productGrid">


                <c:forEach var="p" items="${list}">
              <div class="product-card">

                  <img src="${p.getImg()}"
                       alt="Robot Elilik">

                  <h3>${p.getName()}</h3>

                  <div class="product-rating">
                      <i class="fa fa-star"></i>
                      <i class="fa fa-star"></i>
                      <i class="fa fa-star"></i>
                      <i class="fa fa-star"></i>
                      <i class="fa fa-star-o"></i>
                      <span>4.5 (12)</span>
                  </div>

                  <p style="font-size:14px; color:#444;">Hồng</p>

                  <div class="color-options">
                      <div class="color-circle active" style="background:#ccc;"></div>
                      <div class="color-circle" style="background:#222;"></div>
                  </div>

                  <div class="product-price">${p.getPrice()}</div>

                  <p class="product-discount">
                      Giá gốc
                      <span class="product-old-price">7.139.000 VND</span>
                  </p>

                  <div class="card-footer">
                      <button
                              onclick="window.location.href='product?id=${p.getId()}'"
                              class="buy-btn">
                          Mua
                      </button>
                  </div>

              </div>
                </c:forEach>


          </section>


          <!-- Pagination -->
        <div class="pagination-container">
          <nav aria-label="Page navigation">
            <ul class="pagination" id="pagination">
              <!-- Pagination sẽ được tạo bằng JavaScript -->
            </ul>
          </nav>
        </div>



        <!-- CART DRAWER SIMULATION (checkbox hack) -->
        <div class="site-cart">
          <input type="checkbox" id="cart-toggle" hidden>
          <label for="cart-toggle" class="cart-overlay"></label>

          <label for="cart-toggle" class="cart-floating" aria-hidden="false" title="Mở giỏ hàng">
            <span class="cart-count">0</span>
            🛒
          </label>
          <aside class="cart-drawer" aria-label="Giỏ hàng">
            <div class="cart-header">
              <h3>Giỏ hàng của bạn</h3>
              <label for="cart-toggle" class="cart-close" aria-label="Đóng giỏ">✕</label>
            </div>
            <div class="cart-body">
              <p class="muted">Giỏ hàng demo (tĩnh). Links "Thêm vào giỏ" trong trang sẽ dẫn tới đây nhưng không
                update số lượng do không dùng JS.</p>
              <ul class="cart-items">
                <li class="cart-item">
                  <img src="https://via.placeholder.com/80x80.png?text=Item" alt="">
                  <div class="cart-info">
                    <strong>Galaxy Mini 1</strong>
                    <span class="muted">1 x 6.490.000₫</span>
                  </div>
                  <div class="cart-actions"><a href="#" class="link-more">Xóa</a></div>
                </li>
              </ul>
            </div>
            <div class="cart-footer">
              <div class="cart-total"><span>Tổng</span><strong>6.490.000₫</strong></div>
              <div class="cart-cta">
                <a class="btn btn-ghost" href="#">Tiếp tục mua</a>
                <a class="btn btn-primary" href="#">Thanh toán</a>
              </div>
            </div>
          </aside>
        </div>
      </main>

      <!-- ================= Footer ================= -->
      <footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
        <div class="container">
          <div class="row gy-4">
            <!-- Logo + Giới thiệu -->
            <div class="col-md-4">
              <a href="/index.html" class="d-flex align-items-center mb-3 text-decoration-none">
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
                <li><a href="/pages/products.html#mini-tech" class="footer-link">Công nghệ mini</a></li>
                <li><a href="/pages/products.html#ai-device" class="footer-link">Thiết bị AI</a></li>
                <li><a href="/pages/products.html#creative" class="footer-link">Phụ kiện sáng tạo</a></li>
                <li><a href="/pages/products.html#fun-tech" class="footer-link">Đồ chơi công nghệ</a></li>
              </ul>
            </div>

            <!-- Hỗ trợ -->
            <div class="col-md-2">
              <h6 class="fw-bold mb-3 text-uppercase">Hỗ trợ</h6>
              <ul class="list-unstyled">
                <li><a href="/pages/contact.html" class="footer-link">Liên hệ</a></li>
                <li><a href="/pages/forgot-password.html" class="footer-link">Quên mật khẩu</a></li>
                <li><a href="/pages/order-history.jsp" class="footer-link">Theo dõi đơn hàng</a></li>
                <li><a href="/pages/404.html" class="footer-link">Trung tâm trợ giúp</a></li>
              </ul>
            </div>

            <!-- Liên hệ -->
            <div class="col-md-4">
              <h6 class="fw-bold mb-3 text-uppercase">Liên hệ</h6>
              <p class="mb-1"><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP. Hồ Chí Minh</p>
              <p class="mb-1"><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
              <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@htcamera.vn</p>
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

      <!-- JavaScript -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    </body>

    </html>
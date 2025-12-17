<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>Chi tiết sản phẩm | TechX</title>

  <!-- Icons & Bootstrap (keeps your site consistent) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
  <link rel="stylesheet" href="../assets/css/header.css">
  <link rel="stylesheet" href="../assets/css/footer.css">
  <!-- AOS (animate on scroll) -->
  <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css" />

  <!-- Main CSS (the enhanced stylesheet above) -->
  <link rel="stylesheet" href="/assets/css/product-detail.css">

  <meta name="description"
    content="Chi tiết sản phẩm TechX - Tai nghe Bluetooth TechX AirBeat, công nghệ AI, thiết kế nhỏ gọn." />
</head>

<body>

  <!-- Header (kept minimal, you can reuse your site header) -->
  <!-- ================= Header ================= -->

  <main class="container product-detail-page" style="padding-top:18px">
    <!-- Breadcrumbs -->


    <!-- Product grid: left detailed content, right side panel -->
    <section class="product-container" aria-labelledby="productTitle">

      <!-- LEFT: product visual + meta -->
      <div class="product-card" data-aos="fade-up">

        <div class="gallery">
          <!-- MAIN IMAGE -->
          <figure class="main-image" id="mainImageWrap" aria-label="Ảnh sản phẩm chính">
            <img id="mainImage" src="${p.getImg()}"
              alt="Tai nghe TechX AirBeat - màu đen">
            <div class="zoom-hint"><i class="bi bi-arrows-fullscreen"></i> Phóng to</div>
          </figure>

          <!-- THUMBNAILS -->
          <div class="thumbs" id="thumbsList" role="list">
            <button class="thumb active" data-src="https://www.gundam.my/images/sell_products/big/image_8273.jpg"
              aria-label="Ảnh 1" role="listitem">
              <img src="https://www.gundam.my/images/sell_products/big/image_8273.jpg" alt="thumbnail 1" />
            </button>
            <button class="thumb"
              data-src="https://i.redd.it/fm-aerial-kosmos-led-succumbed-and-broke-my-no-1-100-non-mg-v0-6one2blg5bqc1.jpg?width=2877&format=pjpg&auto=webp&s=d76ff82cd5c2f76b84bb3143cdce4b727d093bfb"
              aria-label="Ảnh 2" role="listitem">
              <img
                src="https://i.redd.it/fm-aerial-kosmos-led-succumbed-and-broke-my-no-1-100-non-mg-v0-6one2blg5bqc1.jpg?width=2877&format=pjpg&auto=webp&s=d76ff82cd5c2f76b84bb3143cdce4b727d093bfb"
                alt="thumbnail 2" />
            </button>
            <button class="thumb" data-src="https://i.ytimg.com/vi/MFa9yULoWRc/maxresdefault.jpg" aria-label="Ảnh 3"
              role="listitem">
              <img src="https://i.ytimg.com/vi/MFa9yULoWRc/maxresdefault.jpg" alt="thumbnail 3" />
            </button>
            <button class="thumb"
              data-src="https://cooldragonhobby.ca/cdn/shop/files/O1CN01Ekq03t1yf8smTjssJ__741596605_jpg_468x468Q75_jpg.jpg?v=1738941898&width=1445"
              aria-label="Ảnh 4" role="listitem">
              <img
                src="https://cooldragonhobby.ca/cdn/shop/files/O1CN01Ekq03t1yf8smTjssJ__741596605_jpg_468x468Q75_jpg.jpg?v=1738941898&width=1445"
                alt="thumbnail 4" />
            </button>
          </div>
        </div>

        <!-- META -->
        <div class="meta" style="margin-top:16px">
          <h1 id="productTitle" class="product-title">${p.getName()}</h1>
          <span class="sku">Mã: <strong>TX-AB001</strong></span>

          <div class="rating-row">
            <div class="stars" aria-hidden="true">★★★★☆</div>
            <div class="review-count">(125 đánh giá)</div>
          </div>

          <div class="price-row">
            <div class="current-price" id="price">${p.getPrice()}</div>
            <div class="old-price">1.099.000₫</div>
            <div class="badge-sale">-18%</div>
          </div>

          <p class="product-desc">Tai nghe không dây TechX AirBeat: pin 30 giờ, Bluetooth 5.3, ANC chống ồn chủ động,
            sạc nhanh Type-C. Thiết kế tối giản phù hợp người dùng năng động.</p>

          <!-- Options: color & capacity -->
          <div style="margin-top:8px">
            <div style="display:flex; justify-content:space-between; align-items:center;">
              <strong>Chọn màu</strong>
              <span class="kv">Sản phẩm còn <span class="in-stock">còn hàng</span></span>
            </div>
            <div class="options" style="margin-top:8px">
              <button class="color-swatch active" data-color="black" style="background:#0f1724"
                aria-label="Màu Đen"></button>
              <button class="color-swatch" data-color="white" style="background:#f5f6fa"
                aria-label="Màu Trắng"></button>
              <button class="color-swatch" data-color="rose" style="background:#ffb4c1" aria-label="Màu Hồng"></button>
            </div>

            <div style="display:flex; justify-content:space-between; align-items:center; margin-top:10px">
              <strong>Chọn bản</strong>
              <span class="kv">Bảo hành 12 tháng</span>
            </div>

            <div class="options" style="margin-top:8px">
              <button class="capacity-btn active" data-cap="standard">Tiêu chuẩn</button>
              <button class="capacity-btn" data-cap="pro">Pro (Bluetooth LDAC)</button>
            </div>
          </div>

        </div> <!-- /.meta -->

        <!-- TABS + details + related -->
        <div class="product-detail-section" style="margin-top:18px" data-aos="fade-up" data-aos-delay="160">
          <div class="tabs">
            <div class="tab-controls" role="tablist" aria-label="Nội dung sản phẩm">
              <button class="active" data-tab="details" role="tab">Chi tiết</button>
              <button data-tab="specs" role="tab">Thông số</button>
              <button data-tab="reviews" role="tab">Đánh giá</button>
            </div>

            <div class="tab-content" id="tabContent">
              <div id="details" class="tab-panel" data-panel>
                <p>AirBeat có driver 10mm, âm trường rộng, bass sâu nhưng không lấn, mid rõ giọng nói, phù hợp nghe
                  nhạc, họp trực tuyến, chơi game nhẹ. Vật liệu chống mồ hôi, dùng được khi tập luyện.</p>
                <ul>
                  <li>Thời lượng pin: 30 giờ (kể cả hộp sạc)</li>
                  <li>ANC: Có</li>
                  <li>Kết nối: Bluetooth 5.3 (LDAC ở phiên bản Pro)</li>
                  <li>Sạc nhanh: 10 phút -> 3 giờ</li>
                </ul>
              </div>

              <div id="specs" class="tab-panel" data-panel style="display:none">
                <table style="width:100%; border-collapse:collapse; font-size:14px">
                  <tr>
                    <td style="padding:8px; color:var(--muted)">Driver</td>
                    <td style="padding:8px">10 mm dynamic</td>
                  </tr>
                  <tr>
                    <td style="padding:8px; color:var(--muted)">Bluetooth</td>
                    <td style="padding:8px">5.3</td>
                  </tr>
                  <tr>
                    <td style="padding:8px; color:var(--muted)">Trọng lượng</td>
                    <td style="padding:8px">45g</td>
                  </tr>
                  <tr>
                    <td style="padding:8px; color:var(--muted)">Chuẩn chống nước</td>
                    <td style="padding:8px">IPX4</td>
                  </tr>
                </table>
              </div>

              <div id="reviews" class="tab-panel" data-panel style="display:none">
                <div class="reviews">
                  <div class="review">
                    <div class="meta">
                      <div class="name">Hùng</div>
                      <div class="date">2 tuần trước</div>
                    </div>
                    <div class="text">Âm bass ấm, đeo êm, ANC tạm ổn với tầm giá. Giao hàng nhanh.</div>
                  </div>
                  <div class="review">
                    <div class="meta">
                      <div class="name">Thanh</div>
                      <div class="date">1 tháng trước</div>
                    </div>
                    <div class="text">Pin bền thật, dùng cả ngày vẫn ổn. Recommend.</div>
                  </div>
                  <div style="text-align:center; margin-top:10px"><button id="writeReviewBtn" class="capacity-btn">Viết
                      đánh giá</button></div>
                </div>
              </div>
            </div>
          </div>

          <!-- RIGHT: reviews quick + related -->
          <aside class="reviews" aria-label="Đánh giá nhanh">
            <h4 style="margin-top:4px; margin-bottom:8px">Đánh giá trung bình</h4>
            <div style="display:flex; align-items:center; gap:12px">
              <div style="font-size:36px; font-weight:800; color:#07122a">4.5</div>
              <div>
                <div class="stars">★★★★☆</div>
                <div class="kv">125 đánh giá • 4 câu hỏi đã trả lời</div>
              </div>
            </div>

            <hr style="margin:12px 0">
            <h5 style="margin-bottom:10px">Sản phẩm tương tự</h5>
            <div class="related-grid" id="relatedGrid">
              <!-- static related cards -->
              <div class="related-card">
                <img src="/assets/img/rel-1.jpg" alt="related 1">
                <h4>Humane AI Pin</h4>
                <div class="price">6.490.000₫</div>
              </div>
              <div class="related-card">
                <img src="/assets/img/rel-2.jpg" alt="related 2">
                <h4>AI Smart Glasses</h4>
                <div class="price">3.290.000₫</div>
              </div>
              <div class="related-card">
                <img src="/assets/img/rel-3.jpg" alt="related 3">
                <h4>Mini Projector</h4>
                <div class="price">4.990.000₫</div>
              </div>
            </div>
          </aside>
        </div> <!-- /.product-detail-section -->


      </div> <!-- /.product-card -->

      <!-- RIGHT: side panel (sticky) -->
      <aside class="side-panel" data-aos="fade-left" aria-label="Thanh mua hàng">
        <div>
          <div style="display:flex; justify-content:space-between; align-items:center">
            <div style="font-size:13px; color:var(--muted)">Tình trạng</div>
            <div class="in-stock" id="stockLabel">Còn hàng</div>
          </div>

          <div style="margin-top:8px">
            <div style="font-size:13px; color:var(--muted)">Vận chuyển</div>
            <div style="font-weight:700; margin-top:4px">Giao hàng toàn quốc — 2–4 ngày</div>
          </div>
        </div>

        <div>
          <div class="kv">Giá</div>
          <div style="display:flex; align-items:center; justify-content:space-between; margin-top:6px">
            <div class="current-price" id="sidePrice">899.000₫</div>
            <div class="old-price">1.099.000₫</div>
          </div>
        </div>

        <div>
          <div class="kv">Số lượng</div>
          <div class="qty" style="margin-top:6px">
            <button id="decr" class="qty-btn" aria-label="Giảm">−</button>
            <input id="qtyInput" type="number" min="1" value="1" aria-label="Số lượng sản phẩm" />
            <button id="incr" class="qty-btn" aria-label="Tăng">+</button>
          </div>
          <div style="margin-top:8px; font-size:13px; color:var(--muted)"><span id="stockCount">50</span> sản phẩm có
            sẵn</div>
        </div>

        <div>
          <button id="buyNow" class="btn-buy" aria-label="Mua ngay"><i class="bi bi-bag-check me-1"></i> Mua
            ngay</button>
          <button id="addCart" class="btn-cart" style="margin-top:8px"><i class="bi bi-cart-plus me-1"></i> Thêm vào
            giỏ</button>
        </div>

        <div style="margin-top:6px; font-size:13px; color:var(--muted)">
          <i class="bi bi-shield-check me-1"></i> 12 tháng bảo hành • Hỗ trợ 24/7
        </div>
      </aside>

    </section>

    <!-- Toast for feedback -->
    <div id="toast" class="toast" role="status" aria-live="polite" aria-atomic="true">
      <i class="bi bi-check-circle-fill" style="font-size:20px"></i>
      <div id="toastText" style="font-weight:700">Đã thêm vào giỏ hàng</div>
    </div>

  </main>

  <!-- Footer (kept simple) -->
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

  <!-- AOS + small inline JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
  <script>
    AOS.init({ once: true, duration: 700 });

    // ---------- Gallery logic ----------
    (function () {
      const main = document.getElementById('mainImage');
      const thumbs = Array.from(document.querySelectorAll('.thumb'));
      thumbs.forEach(t => {
        t.addEventListener('click', () => {
          thumbs.forEach(x => x.classList.remove('active'));
          t.classList.add('active');
          const src = t.dataset.src;
          // fade out-in
          main.style.filter = 'brightness(.85) blur(0.5px)';
          setTimeout(() => {
            main.src = src;
            main.alt = 'Ảnh sản phẩm';
            main.style.filter = 'none';
          }, 160);
        });
      });

      // simple keyboard left/right for thumbs
      let current = 0;
      document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowRight' || e.key === 'ArrowLeft') {
          if (e.key === 'ArrowRight') current = Math.min(current + 1, thumbs.length - 1);
          else current = Math.max(current - 1, 0);
          thumbs[current].click();
        }
      });
    })();

    // ---------- Color & capacity UI ----------
    (function () {
      document.querySelectorAll('.color-swatch').forEach(btn => {
        btn.addEventListener('click', () => {
          document.querySelectorAll('.color-swatch').forEach(b => b.classList.remove('active'));
          btn.classList.add('active');
          // small visual: change main image to correspond color if available
          const color = btn.dataset.color;
          const main = document.getElementById('mainImage');
          if (color === 'white') main.src = '/assets/img/product-sample-2.jpg';
          else if (color === 'rose') main.src = '/assets/img/product-sample-3.jpg';
          else main.src = '/assets/img/product-sample.jpg';
        });
      });

      document.querySelectorAll('.capacity-btn').forEach(btn => {
        btn.addEventListener('click', () => {
          document.querySelectorAll('.capacity-btn').forEach(b => b.classList.remove('active'));
          btn.classList.add('active');
          // change price for 'pro' variant
          const sidePrice = document.getElementById('sidePrice');
          const price = document.getElementById('price');
          if (btn.dataset.cap === 'pro') {
            sidePrice.textContent = '1.199.000₫';
            price.textContent = '1.199.000₫';
            document.querySelector('.badge-sale').textContent = '-8%';
          } else {
            sidePrice.textContent = '899.000₫';
            price.textContent = '899.000₫';
            document.querySelector('.badge-sale').textContent = '-18%';
          }
        });
      });
    })();

    // ---------- Quantity control & stock ----------
    (function () {
      const decr = document.getElementById('decr');
      const incr = document.getElementById('incr');
      const input = document.getElementById('qtyInput');
      const stockCount = document.getElementById('stockCount');
      let stock = parseInt(stockCount.textContent) || 50;

      function setQty(v) {
        v = Math.max(1, Math.min(stock, Number(v) || 1));
        input.value = v;
      }
      decr.addEventListener('click', () => setQty(Number(input.value) - 1));
      incr.addEventListener('click', () => setQty(Number(input.value) + 1));
      input.addEventListener('change', () => setQty(input.value));
    })();

    // ---------- Add to cart & toast ----------
    (function () {
      const toast = document.getElementById('toast');
      const toastText = document.getElementById('toastText');
      const addCart = document.getElementById('addCart');
      const buyNow = document.getElementById('buyNow');

      function showToast(msg) {
        toastText.textContent = msg;
        toast.classList.add('show');
        setTimeout(() => toast.classList.remove('show'), 2200);
      }

      addCart.addEventListener('click', () => {
        const qty = document.getElementById('qtyInput').value;
        // simulate add: in real app you'd call API or update localStorage
        showToast('🛒 Đã thêm ' + qty + ' sản phẩm vào giỏ');
      });

      buyNow.addEventListener('click', () => {
        const qty = document.getElementById('qtyInput').value;
        showToast('✅ Mua ngay: ' + qty + ' sản phẩm — chuyển tới thanh toán (demo)');
        // demo: redirect to cart / checkout page (static)
        setTimeout(() => { window.location.href = '/pages/cart.html'; }, 900);
      });
    })();

    // ---------- Tabs logic ----------
    (function () {
      const tabButtons = document.querySelectorAll('.tab-controls button');
      const panels = document.querySelectorAll('[data-panel]');
      tabButtons.forEach(btn => {
        btn.addEventListener('click', () => {
          tabButtons.forEach(b => b.classList.remove('active'));
          panels.forEach(p => p.style.display = 'none');
          btn.classList.add('active');
          const panel = document.getElementById(btn.dataset.tab);
          if (panel) panel.style.display = 'block';
          // scroll into view on small devices
          if (window.innerWidth < 800) panel.scrollIntoView({ behavior: 'smooth', block: 'center' });
        });
      });
    })();

    // ---------- Write review demo ----------
    (function () {
      const writeBtn = document.getElementById('writeReviewBtn');
      writeBtn.addEventListener('click', () => {
        const name = prompt('Tên của bạn');
        const text = prompt('Đánh giá (tối đa 300 ký tự)');
        if (name && text) {
          alert('Cảm ơn ' + name + '! (Demo: đánh giá sẽ được ghi lại trên server thực tế)');
        }
      });
    })();

    // Accessibility: thumbs keyboard focus
    (function () {
      const thumbs = document.querySelectorAll('.thumb');
      thumbs.forEach((t, i) => {
        t.tabIndex = 0;
        t.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ' ') t.click();
          if (e.key === 'ArrowRight') thumbs[Math.min(i + 1, thumbs.length - 1)].focus();
          if (e.key === 'ArrowLeft') thumbs[Math.max(i - 1, 0)].focus();
        });
      });
    })();

  </script>

</body>

</html>
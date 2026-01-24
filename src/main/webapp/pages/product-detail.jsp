<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>Chi tiết sản phẩm | TechX</title>

    <!-- Icons & Bootstrap (keeps your site consistent) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/header.css">
    <link rel="stylesheet" href="../assets/css/footer.css">
    <!-- AOS (animate on scroll) -->
    <link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css"/>

    <!-- Main CSS (the enhanced stylesheet above) -->
    <link rel="stylesheet" href="/assets/css/product-detail.css">

    <meta name="description"
          content="Chi tiết sản phẩm TechX - Tai nghe Bluetooth TechX AirBeat, công nghệ AI, thiết kế nhỏ gọn."/>
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
                    <img id="mainImage" src="${p.imagesTop}" alt="${p.name}">
                    <div class="zoom-hint"><i class="bi bi-arrows-fullscreen"></i> Phóng to</div>
                </figure>


                <!-- THUMBNAILS -->
                <div class="thumbs" id="thumbsList" role="list">
                    <c:forEach var="img" items="${p.images}" varStatus="st">

                        <button class="thumb ${st.index == 0 ? 'active' : ''}"
                                data-src="${img}"
                                aria-label="Ảnh ${st.index + 1}">
                            <img src="${img}" alt="thumbnail ${st.index + 1}"/>
                        </button>

                    </c:forEach>
                </div>

            </div>

            <!-- META -->
            <div class="meta" style="margin-top:16px">
                <h1 id="productTitle" class="product-title">${p.name}</h1>


                <div class="rating-row">
                    <div class="stars" aria-hidden="true">★★★★☆</div>
                    <div class="review-count">(125 đánh giá)</div>
                </div>

                <div class="price-row">
                    <div class="current-price" id="price">${p.price}</div>
                </div>

                <p class="product-desc">${p.fullDescription}</p>


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
                        </div>

                        <div id="specs" class="tab-panel" data-panel style="display:none">
                        </div>

                        <div id="reviews" class="tab-panel" data-panel style="display:none">
                            <div class="reviews">
<%--                                <div class="review">--%>
<%--                                    <div class="meta">--%>
<%--                                        <div class="name">Hùng</div>--%>
<%--                                        <div class="date">2 tuần trước</div>--%>
<%--                                    </div>--%>
<%--                                    <div class="text">Âm bass ấm, đeo êm, ANC tạm ổn với tầm giá. Giao hàng nhanh.</div>--%>
<%--                                </div>--%>
                                <c:if test="${empty reviews}">
                                    <p>Chưa có đánh giá nào</p>
                                </c:if>
                                <c:forEach var="r" items="${reviews}">
                                    <div class="review">
                                        <strong>${r.rating}★</strong>
                                        <p>${r.comment}</p>
                                        <small>${r.createdAt}</small>
                                    </div>
                                </c:forEach>

                                <c:if test="${sessionScope.user != null}">
                                    <form action="${pageContext.request.contextPath}/rate" method="post">
                                        <input type="hidden" name="productId" value="${p.id}">

                                        <label>Đánh giá:</label>
                                        <select name="rating" required>
                                            <option value="5">★★★★★</option>
                                            <option value="4">★★★★</option>
                                            <option value="3">★★★</option>
                                            <option value="2">★★</option>
                                            <option value="1">★</option>
                                        </select>

                                        <textarea name="comment" placeholder="Nhận xét của bạn"></textarea>

                                        <button type="submit">Gửi đánh giá</button>
                                    </form>
                                </c:if>


                            </div>
                        </div>
                    </div>
                </div>

                <!-- RIGHT: reviews quick + related -->
                <aside class="reviews" aria-label="Đánh giá nhanh">
                    <h4 style="margin-top:4px; margin-bottom:8px">Đánh giá trung bình</h4>
                    <div style="display:flex; align-items:center; gap:12px">
                        <div style="font-size:36px; font-weight:800; color:#07122a">${p.avgRating}</div>
                        <div>
                            <div class="stars">★★★★☆</div>
                            <div class="kv">${p.ratingCount} đánh giá </div>
                        </div>
                    </div>

                    <hr style="margin:12px 0">
                    <h5 style="margin-bottom:10px">Sản phẩm tương tự</h5>
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
                    <input id="qtyInput" type="number" min="1" value="1" aria-label="Số lượng sản phẩm"/>
                    <button id="incr" class="qty-btn" aria-label="Tăng">+</button>
                </div>
                <div style="margin-top:8px; font-size:13px; color:var(--muted)"><span id="stockCount">50</span> sản phẩm
                    có
                    sẵn
                </div>
            </div>
            <div>
                <button id="buyNow" class="btn-buy" aria-label="Mua ngay">
                    <i class="bi bi-bag-check me-1"></i> Mua ngay
                </button>

                <!-- FORM ADD TO CART (CHỈ THÊM, KHÔNG ẢNH HƯỞNG GIAO DIỆN) -->
                <form id="addCartForm"
                      action="${pageContext.request.contextPath}/cart"
                      method="post"
                      style="margin-top:8px">

                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="productId" value="${p.id}">
                    <input type="hidden" name="quantity" id="cartQty">

                    <button type="submit" id="addCart" class="btn-cart">
                        <i class="bi bi-cart-plus me-1"></i> Thêm vào giỏ
                    </button>
                </form>
                <form id="addCartForm"
                      action="${pageContext.request.contextPath}/add-to-cart"
                      method="post"
                      style="margin-top:8px">

                    <input type="hidden" name="productId" value="${p.id}">
                    <input type="hidden" name="quantity" id="cartQty">

                    <button type="submit" class="btn-cart">
                        <i class="bi bi-cart-plus me-1"></i> Thêm vào giỏ
                    </button>
                </form>

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

<!-- AOS + small inline JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({once: true, duration: 700});

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
    // ---------- Add to cart & toast (REAL BACKEND) ----------
    (function () {
        const toast = document.getElementById('toast');
        const toastText = document.getElementById('toastText');
        const addCartForm = document.getElementById('addCartForm');
        const buyNow = document.getElementById('buyNow');

        function showToast(msg) {
            toastText.textContent = msg;
            toast.classList.add('show');
            setTimeout(() => toast.classList.remove('show'), 2200);
        }

        // ADD TO CART → GỌI SERVLET
        addCartForm.addEventListener('submit', function (e) {
            e.preventDefault(); // KHÔNG reload trang

            const qty = document.getElementById('qtyInput').value;
            document.getElementById('cartQty').value = qty;

            fetch(addCartForm.action, {
                method: 'POST',
                body: new FormData(addCartForm)
            }).then(() => {
                showToast('🛒 Đã thêm ' + qty + ' sản phẩm vào giỏ');
            });
        });

        buyNow.addEventListener('click', () => {
            const qty = document.getElementById('qtyInput').value;
            showToast('✅ Mua ngay: ' + qty + ' sản phẩm');
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/cart';
            }, 900);
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
                if (window.innerWidth < 800) panel.scrollIntoView({behavior: 'smooth', block: 'center'});
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
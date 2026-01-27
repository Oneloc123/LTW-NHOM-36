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
<%@ include file="/WEB-INF/views/common/header.jsp" %>

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
                    <div class="review-count">${p.ratingCount}</div>
                </div>

                <div class="price-row">
                    <div class="current-price">
                        ${String.format("%,d", p.price)} đ
                    </div>
                </div>

                <p class="product-desc">${p.shortDescription}</p>


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
                            <p>${p.fullDescription}</p>
                        </div>

                        <div id="specs" class="tab-panel" data-panel style="display:none">

                            <pre>${p.spec}</pre>

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
                                        <strong>${r.userName}</strong>
                                        <span> – ${r.rating}★</span>
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
                            <div class="kv">${p.ratingCount} đánh giá</div>
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
                    <div class="current-price" id="sidePrice">
                        ${String.format("%,d", p.price)} đ
                    </div>
                </div>
            </div>

            <div>
                <div class="kv">Số lượng</div>
                <div class="qty" style="margin-top:6px">
                    <button id="decr" class="qty-btn" aria-label="Giảm">−</button>
                    <input id="qtyInput" type="number" min="1" value="1" aria-label="Số lượng sản phẩm"/>
                    <button id="incr" class="qty-btn" aria-label="Tăng">+</button>
                </div>
                <%--                <div style="margin-top:8px; font-size:13px; color:var(--muted)"><span id="stockCount">50</span> sản phẩm--%>
                <%--                    có--%>
                <%--                    sẵn--%>
                <%--                </div>--%>

            </div>
            <div>

                <button id="buyNow" type="button" class="btn-buy">
                    <i class="bi bi-bag-check me-1"></i> Mua ngay
                </button>



                <!-- FORM ADD TO CART (CHỈ THÊM, KHÔNG ẢNH HƯỞNG GIAO DIỆN) -->


                <form id="addCartForm"
                      action="${pageContext.request.contextPath}/add-cart"
                      method="post"
                      style="margin-top: 10px">

                    <input type="hidden" name="id" value="${p.id}">
                    <input type="hidden" name="q" id="qtyHidden" value="1">

                    <!-- 🔥 PHẢI NẰM TRONG FORM -->
                    <input type="hidden" name="buyNow" id="buyNowFlag" value="false">

                    <button type="submit" class="btn-cart">
                        <i class="bi bi-cart-plus me-1"></i> Thêm vào giỏ
                    </button>
                </form>

                <c:if test="${not empty sessionScope.id}">
                    <form action="${pageContext.request.contextPath}/wishlist" method="post" class="d-inline">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="${p.id}">
                        <button type="submit" class="btn btn-cart btn-outline-danger btn-sm"
                                title="Thêm vào danh sách yêu thích">
                            <i class="bi bi-heart"></i> Yêu thích
                        </button>
                    </form>
                </c:if>
                <c:if test="${empty sessionScope.id}">
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-outline-danger  "
                       title="Đăng nhập để thêm vào wishlist"
                        type = "margin-top:10px;">
                        <i class="bi bi-heart"></i> Yêu thích
                    </a>
                </c:if>
                <%--                <!-- Test Link -->--%>
                <%--                <div class="mt-3 text-center">--%>
                <%--                    <a href="${pageContext.request.contextPath}/add-cart?id=${p.id}&q=1"--%>
                <%--                       class="btn btn-sm btn-outline-primary">--%>
                <%--                        <i class="bi bi-cart-check me-1"></i>Test Add 1 Item--%>
                <%--                    </a>--%>
                <%--                </div>--%>
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
    document.addEventListener("DOMContentLoaded", function () {

        /* ================= AOS ================= */
        if (window.AOS) {
            AOS.init({once: true, duration: 700});
        }

        /* ================= GALLERY ================= */
        const mainImage = document.getElementById("mainImage");
        const thumbs = document.querySelectorAll(".thumb");

        if (mainImage && thumbs.length) {
            let currentIndex = 0;

            thumbs.forEach((thumb, index) => {
                thumb.addEventListener("click", () => {
                    thumbs.forEach(t => t.classList.remove("active"));
                    thumb.classList.add("active");

                    const src = thumb.dataset.src;
                    if (src) {
                        mainImage.style.filter = "brightness(.85)";
                        setTimeout(() => {
                            mainImage.src = src;
                            mainImage.style.filter = "none";
                        }, 150);
                    }
                    currentIndex = index;
                });
            });

            document.addEventListener("keydown", e => {
                if (e.key === "ArrowRight") {
                    currentIndex = Math.min(currentIndex + 1, thumbs.length - 1);
                    thumbs[currentIndex].click();
                }
                if (e.key === "ArrowLeft") {
                    currentIndex = Math.max(currentIndex - 1, 0);
                    thumbs[currentIndex].click();
                }
            });
        }

        /* ================= TABS ================= */
        const tabButtons = document.querySelectorAll(".tab-controls button");
        const tabPanels = document.querySelectorAll("[data-panel]");

        tabButtons.forEach(btn => {
            btn.addEventListener("click", () => {
                tabButtons.forEach(b => b.classList.remove("active"));
                tabPanels.forEach(p => p.style.display = "none");

                btn.classList.add("active");
                const panel = document.getElementById(btn.dataset.tab);
                if (panel) panel.style.display = "block";
            });
        });

        /* ================= QUANTITY ================= */
        const qtyInput = document.getElementById("qtyInput");
        const qtyHidden = document.getElementById("qtyHidden");
        const decr = document.getElementById("decr");
        const incr = document.getElementById("incr");

        function syncQty(val) {
            val = parseInt(val);
            if (isNaN(val) || val < 1) val = 1;
            qtyInput.value = val;
            qtyHidden.value = val;
        }

        if (qtyInput && qtyHidden && decr && incr) {
            decr.addEventListener("click", e => {
                e.preventDefault();
                syncQty(qtyInput.value - 1);
            });

            incr.addEventListener("click", e => {
                e.preventDefault();
                syncQty(+qtyInput.value + 1);
            });

            qtyInput.addEventListener("input", () => {
                syncQty(qtyInput.value);
            });
        }


        /* ================= TOAST ================= */
        const toast = document.getElementById("toast");
        const toastText = document.getElementById("toastText");

        function showToast(message) {
            if (!toast || !toastText) return;
            toastText.textContent = message;
            toast.classList.add("show");
            setTimeout(() => toast.classList.remove("show"), 2200);
        }

        /* ================= ADD TO CART ================= */
        const addCartForm = document.getElementById("addCartForm");
        const cartQty = document.getElementById("cartQty");

        if (addCartForm) {
            addCartForm.addEventListener("submit", function () {
                document.getElementById("buyNowFlag").value = "false";
                showToast(`🛒 Đã thêm ${qtyHidden.value} sản phẩm vào giỏ`);
            });
        }




        /* ================= BUY NOW ================= */
        const buyNow = document.getElementById("buyNow");

        buyNow.addEventListener("click", () => {
            qtyHidden.value = qtyInput.value;
            document.getElementById("buyNowFlag").value = "true";
            addCartForm.submit();
        });




    });
</script>

</body>

</html>
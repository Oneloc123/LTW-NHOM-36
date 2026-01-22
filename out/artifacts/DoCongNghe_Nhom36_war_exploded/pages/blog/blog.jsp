<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>TechX Blog — Công nghệ độc lạ & thiết bị AI</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet"/>
    <link rel="stylesheet" href="/assets/css/blog.css">
    <link rel="stylesheet" href="/assets/css/footer.css">
    <link rel="stylesheet" href="/assets/css/header.css">
</head>

<body class="blog-page">
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- MAIN CONTENT -->
<main class="site-container" id="posts">

    <!-- HERO -->
    <section class="hero site-container">
        <div class="hero-cover"></div>
        <div class="hero-body">
            <div style="display:flex; gap:.5rem; align-items:center;">
                <span class="tag">MỚI</span>
                <small class="muted">Bài viết & sản phẩm nổi bật</small>
            </div>
            <h1>TechX Blog — Cập nhật công nghệ & thiết bị AI</h1>
            <p class="lead">Tin tức, đánh giá và gợi ý sản phẩm công nghệ độc lạ — chọn trực tiếp, mua nhanh.</p>

            <div class="cta-group">
                <a class="btn btn-primary-brand btn-cta" href="#posts">Khám phá bài viết</a>
                <a class="btn btn-outline-brand btn-cta" href="../shop.html">Xem sản phẩm</a>
            </div>
        </div>
    </section>


    <div class="content-row" style="margin-top:18px;">
        <!-- POSTS LEFT -->
        <div style="flex:1 1 0;">
            <div class="blog-grid">

                <c:forEach items="${blogs}" var="b">
                    <article class="card blog">
                        <a href="/blog-detail?id=${b.id}">
                        <img src="${b.thumbnail}" alt="${b.title}">
                        </a>
                        <div class="card-body">

                            <h3 class="card-title">${b.title}</h3>
                            <p class="card-text">
                                    ${b.summary}
                            </p>
                            <div class="d-flex align-items-center justify-content-between">
                                <div class="meta">
                                        ${b.createdAt} •
                                </div>
                                <a href="blog-detail?id=${b.id}"
                                   class="btn btn-outline-secondary read-btn">
                                    Đọc thêm
                                </a>
                            </div>
                        </div>
                    </article>
                </c:forEach>

            </div>
            <!-- Pagination (HTML-only) -->
            <div class="d-flex justify-content-center mt-4 mb-2">
                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm">
                        <li class="page-item disabled"><a class="page-link">«</a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">»</a></li>
                    </ul>
                </nav>
            </div>

            <!-- Related products carousel-like grid (HTML-only) -->
            <section style="margin-top:28px;">
                <h4 style="color:var(--brand); margin-bottom:12px;">Sản phẩm gợi ý từ TechX</h4>
                <div style="display:flex; gap:12px; flex-wrap:wrap;">
                    <div class="widget"
                         style="flex:1 1 220px; min-width:220px; display:flex; gap:12px; align-items:center;">
                        <img src="../../assets/img/Blog/TVcuon.png" alt=""
                             style="width:84px; height:66px; object-fit:cover; border-radius:8px;">
                        <div>
                            <div style="font-weight:700; color:#111;">TV cuộn</div>
                            <div class="price muted">9.500.000đ</div>
                        </div>
                        <div style="margin-left:auto"><a class="btn btn-outline-secondary btn-sm"
                                                         href="product.html">Xem</a></div>
                    </div>

                    <div class="widget"
                         style="flex:1 1 220px; min-width:220px; display:flex; gap:12px; align-items:center;">
                        <img src="../../assets/img/Blog/SonyAibo.png" alt=""
                             style="width:84px; height:66px; object-fit:cover; border-radius:8px;">
                        <div>
                            <div style="font-weight:700; color:#111;">Sony Aibo</div>
                            <div class="price muted">9.999.000đ</div>
                        </div>
                        <div style="margin-left:auto"><a class="btn btn-outline-secondary btn-sm"
                                                         href="product.html">Xem</a></div>
                    </div>

                    <div class="widget"
                         style="flex:1 1 220px; min-width:220px; display:flex; gap:12px; align-items:center;">
                        <img src="../../assets/img/Blog/TVLG.png" alt=""
                             style="width:84px; height:66px; object-fit:cover; border-radius:8px;">
                        <div>
                            <div style="font-weight:700; color:#111;">TV LG AI</div>
                            <div class="price muted">19.900.000đ</div>
                        </div>
                        <div style="margin-left:auto"><a class="btn btn-outline-secondary btn-sm"
                                                         href="product.html">Xem</a></div>
                    </div>
                </div>
            </section>
        </div>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <!-- Featured posts -->
            <div class="widget">
                <h5>Bài viết nổi bật</h5>
                <c:forEach items="${featureList}" var="f">
                    <div class="post-sm">
                        <a href="/blog-detail?id=${f.id}"><img src="${f.thumbnail}" alt=""></a>
                        <div>
                            <div class="title">${f.title}</div>
                            <div class="meta">${f.createdAt}</div>
                        </div>
                    </div>
                </c:forEach>

            </div>

            <!-- newsletter compact -->
            <div class="widget">
                <h5>Nhận thông tin</h5>
                <p class="muted" style="margin-bottom:12px;">Đăng ký để nhận khuyến mãi & bài viết mới</p>
                <form action="#" method="POST" class="d-flex gap-2">
                    <input type="email" required placeholder="Email của bạn" class="form-control form-control-sm">
                    <button class="btn btn-primary btn-sm" type="submit">Gửi</button>
                </form>
            </div>
        </aside>
    </div>

    <div style="background: rgba(255,255,255,0.5)" ; class="newsletter site-container">
        <div>
            <h4 style="margin:0;">Đăng ký nhận tin từ TechX</h4>
            <div class="muted" style="margin-top:6px;">Khuyến mãi, bài review & các sản phẩm mới nhất</div>
        </div>
        <div class="email-box">
            <input type="email" placeholder="Nhập email của bạn" aria-label="Email"/>
            <button class="btn btn-primary" type="button">Đăng ký</button>

        </div>
    </div>
</main>
<!-- ================= Footer ================= -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Chi tiết bài viết | TechX Blog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <!--    <link rel="stylesheet" href="../assets/css/blog.css">-->
    <link rel="stylesheet" href="../../assets/css/header.css">
    <link rel="stylesheet" href="../../assets/css/footer.css">
    <link rel="stylesheet" href="../../assets/css/blog-detail.css">
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="blog-detail">
    <!-- CONTENT -->

    <article class="content">
        <div class="tag"> ${blog.author}</div>
        <div class="meta mt-1">Đăng ngày ${blog.createdAt}</div>
        <h1 class="post-title"> ${blog.title}</h1>


        <div class="post-cover">
            <img src="${blog.thumbnail}" alt="AI Future">
        </div>

        <div class="post-content">
            ${blog.content}
        </div>

        <!-- Author -->

        <div class="author-box">
            <img src="../../assets/img/Blog/tacgia.png" alt="Tác giả">
            <div>
                <h6 class="fw-bold mb-1">Nguyễn Minh Trí</h6>
                <p class="text-muted small mb-2">Chuyên gia AI & công nghệ tiêu dùng</p>
                <div class="share-icons">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-twitter"></i></a>
                    <a href="#"><i class="bi bi-linkedin"></i></a>

                </div>
            </div>
        </div>
    </article>

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="widget">
            <h5>Bài viết nổi bật</h5>
            <div class="post-sm">
                <img src="../../assets/img/Blog/UVmongtay.png" alt="">
                <div>
                    <div class="title">AI thay đổi cuộc sống</div>
                    <div class="meta small">18/09/2025</div>
                </div>
            </div>
            <div class="post-sm">
                <img src="../../assets/img/Blog/NYX.png" alt="">
                <div>
                    <div class="title">Top 5 thiết bị mini 2025</div>
                    <div class="meta small">12/09/2025</div>
                </div>
            </div>
        </div>

        <div class="widget">
            <h5>Nhận thông tin</h5>
            <p class="small text-muted">Đăng ký để nhận khuyến mãi và bài viết mới nhất</p>
            <form class="d-flex gap-2">
                <input type="email" required placeholder="Email của bạn" class="form-control form-control-sm">
                <button class="btn btn-primary btn-sm">Gửi</button>
            </form>
        </div>
    </aside>
</section>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Bài viết</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .blog-detail-img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .info-label {
            font-weight: bold;
            color: #495057;
            width: 30%;
        }
        .blog-content {
            line-height: 1.8;
            font-size: 1.1rem;
        }
        .blog-content img {
            max-width: 100%;
            height: auto;
            margin: 1rem 0;
        }
    </style>
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header fw-bold">
            <i class="bi bi-journal-text"></i> Chi tiết Bài viết
        </div>

        <div class="card-body">
            <div class="row">
                <!-- Hình ảnh blog -->
                <div class="col-md-4">
                    <c:if test="${not empty blog.thumbnail}">
                        <div class="text-center mb-3">
                            <img src="${blog.thumbnail}"
                                 alt="${blog.title}"
                                 class="blog-detail-img"
                                 onerror="this.src='../assets/images/no-image.png'">
                        </div>
                    </c:if>
                    <c:if test="${empty blog.thumbnail}">
                        <div class="text-center">
                            <img src="../assets/images/no-image.png"
                                 alt="No image" class="blog-detail-img">
                        </div>
                    </c:if>
                </div>

                <!-- Thông tin blog -->
                <div class="col-md-8">
                    <table class="table table-bordered">
                        <tr>
                            <td class="info-label">ID</td>
                            <td>${blog.id}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Tiêu đề</td>
                            <td>${blog.title}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Tác giả</td>
                            <td>${blog.author}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Ngày đăng</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty blog.createdAt}">
                                        <c:set var="dateStr" value="${blog.createdAt}" />
                                        <c:choose>
                                            <c:when test="${fn:contains(dateStr, 'T')}">
                                                <!-- Định dạng: 2024-01-23T14:30:45 -->
                                                ${fn:substring(dateStr, 8, 10)}/${fn:substring(dateStr, 5, 7)}/${fn:substring(dateStr, 0, 4)}
                                                ${fn:substring(dateStr, 11, 19)}
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Định dạng: 2024-01-23 14:30:45 -->
                                                ${fn:substring(dateStr, 8, 10)}/${fn:substring(dateStr, 5, 7)}/${fn:substring(dateStr, 0, 4)}
                                                ${fn:substring(dateStr, 11, 19)}
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">URL hình ảnh</td>
                            <td>
                                <c:if test="${not empty blog.thumbnail}">
                                    <small><a href="${blog.thumbnail}" target="_blank">${blog.thumbnail}</a></small>
                                </c:if>
                                <c:if test="${empty blog.thumbnail}">
                                    <span class="text-muted">Không có hình ảnh</span>
                                </c:if>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Tóm tắt -->
            <div class="mt-4">
                <h5><i class="bi bi-card-text"></i> Tóm tắt</h5>
                <div class="card">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty blog.summary}">
                                ${blog.summary}
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Không có tóm tắt</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Nội dung -->
            <div class="mt-4">
                <h5><i class="bi bi-text-paragraph"></i> Nội dung</h5>
                <div class="card">
                    <div class="card-body blog-content">
                        <c:choose>
                            <c:when test="${not empty blog.content}">
                                ${blog.content}
                            </c:when>
                            <c:otherwise>
                                <span class="text-muted">Không có nội dung</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-footer text-end">
            <a href="blogs" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>
</div>

</body>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Danh mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .category-detail-img {
            max-width: 300px;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .info-label {
            font-weight: bold;
            color: #495057;
            width: 40%;
        }
    </style>
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header fw-bold">
            <i class="bi bi-tag"></i> Chi tiết Danh mục
        </div>

        <div class="card-body">
            <div class="row">
                <!-- Hình ảnh danh mục -->
                <div class="col-md-4">
                    <c:if test="${not empty category.imageURL}">
                        <div class="text-center mb-3">
                            <img src="${category.imageURL}"
                                 alt="${category.name}"
                                 class="category-detail-img"
                                 onerror="this.src='../assets/images/no-image.png'">
                        </div>
                    </c:if>
                    <c:if test="${empty category.imageURL}">
                        <div class="text-center">
                            <img src="../assets/images/no-image.png"
                                 alt="No image" class="category-detail-img">
                        </div>
                    </c:if>
                </div>

                <!-- Thông tin danh mục -->
                <div class="col-md-8">
                    <table class="table table-bordered">
                        <tr>
                            <td class="info-label">ID</td>
                            <td>${category.id}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Tên danh mục</td>
                            <td>${category.name}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Mô tả</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty category.description}">
                                        ${category.description}
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">Không có mô tả</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">URL hình ảnh</td>
                            <td>
                                <c:if test="${not empty category.imageURL}">
                                    <small><a href="${category.imageURL}" target="_blank">${category.imageURL}</a></small>
                                </c:if>
                                <c:if test="${empty category.imageURL}">
                                    <span class="text-muted">Không có hình ảnh</span>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">Số sản phẩm</td>
                            <td>
                                <span class="badge bg-info">${productCount} sản phẩm</span>
                            </td>
                        </tr>
                    </table>

                    <!-- Thông báo nếu có sản phẩm -->
                    <c:if test="${productCount > 0}">
                        <div class="alert alert-warning mt-3">
                            <i class="bi bi-exclamation-triangle"></i>
                            Danh mục này có ${productCount} sản phẩm.
                            Không thể xóa khi còn sản phẩm.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="card-footer text-end">
            <a href="categories" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>
</div>

</body>
</html>
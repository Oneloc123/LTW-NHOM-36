<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .product-image {
            max-width: 200px;
            height: auto;
            border-radius: 8px;
        }
        .image-thumbnail {
            width: 80px;
            height: 80px;
            object-fit: cover;
            margin: 5px;
            border-radius: 5px;
            cursor: pointer;
            border: 2px solid transparent;
        }
        .image-thumbnail:hover, .image-thumbnail.active {
            border-color: #0d6efd;
        }
    </style>
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header fw-bold">
            <i class="bi bi-box"></i> Chi tiết sản phẩm
        </div>

        <div class="card-body">
            <div class="row">
                <!-- Hình ảnh sản phẩm -->
                <div class="col-md-4">
                    <c:if test="${not empty product.images}">
                        <div class="text-center mb-3">
                            <img id="mainImage" src="${product.images[0]}"
                                 alt="${product.name}" class="product-image img-fluid"
                                 onerror="this.src='../assets/images/no-image.png'">
                        </div>

                        <div class="d-flex flex-wrap justify-content-center">
                            <c:forEach items="${product.images}" var="image" varStatus="status">
                                <img src="${image}" alt="Hình ${status.index + 1}"
                                     class="image-thumbnail ${status.index == 0 ? 'active' : ''}"
                                     onclick="changeMainImage('${image}', this)"
                                     onerror="this.src='../assets/images/no-image.png'">
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${empty product.images}">
                        <div class="text-center">
                            <img src="../assets/images/no-image.png"
                                 alt="No image" class="product-image img-fluid">
                        </div>
                    </c:if>
                </div>

                <!-- Thông tin sản phẩm -->
                <div class="col-md-8">
                    <table class="table table-bordered">
                        <tr>
                            <th width="30%">ID</th>
                            <td>${product.id}</td>
                        </tr>
                        <tr>
                            <th>Tên sản phẩm</th>
                            <td>${product.name}</td>
                        </tr>
                        <tr>
                            <th>Danh mục</th>
                            <td>
                                <c:choose>
                                    <c:when test="${product.categoryID == 1}">Laptop</c:when>
                                    <c:when test="${product.categoryID == 2}">Điện thoại</c:when>
                                    <c:when test="${product.categoryID == 3}">Phụ kiện</c:when>
                                    <c:otherwise>Khác</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Mô tả ngắn</th>
                            <td>${product.shortDescription}</td>
                        </tr>
                        <tr>
                            <th>Mô tả đầy đủ</th>
                            <td>${product.fullDescription}</td>
                        </tr>
                        <tr>
                            <th>Giá</th>
                            <td class="text-danger fw-bold">
                                <fmt:formatNumber value="${product.price}" type="number"/> đ
                            </td>
                        </tr>
                        <tr>
                            <th>Trạng thái</th>
                            <td>
                                <c:choose>
                                    <c:when test="${product.featured}">
                                        <span class="badge bg-warning">Nổi bật</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Bình thường</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Ngày tạo</th>
                            <td>${product.createAt}</td>
                        </tr>
                        <tr>
                            <th>Ngày cập nhật</th>
                            <td>${product.updateAt}</td>
                        </tr>
                        <tr>
                            <th>Số lượng ảnh</th>
                            <td>
                                <!-- Cách 1: Dùng fn:length (đã import tag library fn) -->
                                <c:if test="${not empty product.images}">
                                    ${fn:length(product.images)}
                                </c:if>
                                <c:if test="${empty product.images}">
                                    0
                                </c:if>

                                <!-- Cách 2: Hoặc dùng varStatus để đếm -->
                                <!--
                                <c:if test="${not empty product.images}">
                                    <c:forEach items="${product.images}" var="image" varStatus="loop">
                                        <c:if test="${loop.last}">
                                            ${loop.index + 1}
                                        </c:if>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty product.images}">
                                    0
                                </c:if>
                                -->
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <!-- Danh sách ảnh -->
            <c:if test="${not empty images}">
                <div class="mt-4">
                    <h5><i class="bi bi-images"></i> Danh sách hình ảnh</h5>
                    <div class="row">
                        <c:forEach items="${images}" var="image">
                            <div class="col-md-3 col-6 mb-3">
                                <div class="card">
                                    <img src="${image.url}" class="card-img-top"
                                         alt="Hình ảnh sản phẩm"
                                         style="height: 150px; object-fit: cover;"
                                         onerror="this.src='../assets/images/no-image.png'">
                                    <div class="card-body p-2">
                                        <small class="text-muted">ID: ${image.id}</small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>

        <div class="card-footer text-end">
            <a href="products" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>
</div>

<script>
    function changeMainImage(src, element) {
        document.getElementById('mainImage').src = src;

        // Xóa active class từ tất cả thumbnail
        document.querySelectorAll('.image-thumbnail').forEach(img => {
            img.classList.remove('active');
        });

        // Thêm active class cho thumbnail được click
        element.classList.add('active');
    }
</script>

</body>
</html>
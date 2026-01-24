<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Sản phẩm | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
    <style>
        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        .price {
            color: #dc3545;
            font-weight: bold;
        }
    </style>
</head>

<body>
<div class="d-flex">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
        <nav>
            <ul>
                <li><a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="products" class="active"><i class="bi bi-box"></i> Sản phẩm</a></li>
                <li><a href="categories" ><i class="bi bi-tags"></i> Danh mục</a></li>
                <li><a href="admin-orders.jsp"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                <li><a href="users"><i class="bi bi-people"></i> Người dùng</a></li>
                <li><a href="blogs"><i class="bi bi-journal-text"></i> Blog</a></li>
                <li><a href="banners"><i class="bi bi-image"></i> Banner</a></li>
                <li><a href="/loggout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main -->
    <main class="main-content">

        <!-- HEADER -->
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-box"></i> Sản phẩm</h3>
            <div class="actions d-flex align-items-center gap-2">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                    <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                </button>
            </div>
        </header>

        <!-- 🔎 SEARCH -->
        <form class="input-group mb-4" action="products" method="get">
            <input type="text" class="form-control" name="keyword"
                   placeholder="Tìm kiếm sản phẩm theo tên..."
                   value="${param.keyword}">
            <button class="btn btn-outline-secondary"><i class="bi bi-search"></i></button>
        </form>

        <section class="filters mt-4">
            <form action="products" method="get">
                <div class="row g-3">
                    <div class="col-md-4">
                        <select class="form-select" name="category">
                            <option value="">Tất cả danh mục</option>
                            <option value="1" ${param.category == '1' ? 'selected' : ''}>Laptop</option>
                            <option value="2" ${param.category == '2' ? 'selected' : ''}>Điện thoại</option>
                            <option value="3" ${param.category == '3' ? 'selected' : ''}>Phụ kiện</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <select class="form-select" name="featured">
                            <option value="">Tất cả</option>
                            <option value="1" ${param.featured == '1' ? 'selected' : ''}>Nổi bật</option>
                            <option value="0" ${param.featured == '0' ? 'selected' : ''}>Bình thường</option>
                        </select>
                    </div>

                    <input type="hidden" name="keyword" value="${param.keyword}"/>

                    <div class="col-md-4 text-end">
                        <button class="btn btn-primary">
                            <i class="bi bi-funnel"></i> Lọc
                        </button>
                    </div>
                </div>
            </form>
        </section>

        <!-- Bảng sản phẩm -->
        <section class="product-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Hình ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Giá</th>
                            <th>Nổi bật</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${products}" var="p" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>
                                    <c:if test="${not empty p.images}">
                                        <img src="${p.images[0]}" alt="${p.name}"
                                             class="product-img" onerror="this.src='../assets/images/no-image.png'">
                                    </c:if>
                                    <c:if test="${empty p.images}">
                                        <img src="../assets/images/no-image.png" alt="No image" class="product-img">
                                    </c:if>
                                </td>
                                <td>${p.name}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.categoryID == 1}">Laptop</c:when>
                                        <c:when test="${p.categoryID == 2}">Điện thoại</c:when>
                                        <c:when test="${p.categoryID == 3}">Phụ kiện</c:when>
                                        <c:otherwise>Khác</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="price">
                                    <fmt:formatNumber value="${p.price}" type="number"/> đ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.featured}">
                                            <span class="badge bg-warning">Nổi bật</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Bình thường</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.createAt}</td>
                                <td>
                                    <a href="products?action=view&id=${p.id}" class="action-btn action-view">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="products?action=edit&id=${p.id}" class="action-btn action-edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="products?action=delete&id=${p.id}"
                                       onclick="return confirm('Xóa sản phẩm này?')"
                                       class="action-btn action-delete">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- MODAL: Thêm Sản phẩm -->
<div class="modal fade" id="addProductModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-box-seam"></i> Thêm sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="products?action=add" method="post" id="addProductForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Tên sản phẩm *</label>
                            <input type="text" class="form-control" name="Name" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Danh mục *</label>
                            <select class="form-select" name="CategoryID" required>
                                <option value="1">Laptop</option>
                                <option value="2">Điện thoại</option>
                                <option value="3">Phụ kiện</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Giá *</label>
                            <input type="number" class="form-control" name="Price" min="0" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Mô tả ngắn *</label>
                            <textarea class="form-control" name="ShortDescription" rows="2" required></textarea>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Mô tả đầy đủ</label>
                            <textarea class="form-control" name="FullDescription" rows="4"></textarea>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">URL hình ảnh 1</label>
                            <input type="url" class="form-control" name="ImageUrls"
                                   placeholder="https://example.com/image1.jpg">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">URL hình ảnh 2</label>
                            <input type="url" class="form-control" name="ImageUrls"
                                   placeholder="https://example.com/image2.jpg">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" name="IsFeatured">
                                <option value="1" selected>Nổi bật</option>
                                <option value="0">Bình thường</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-primary" type="submit">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL: Sửa Sản phẩm -->
<c:if test="${not empty editProduct}">
    <div class="modal fade show" id="editProductModal" tabindex="-1" style="display:block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-pencil-square"></i> Cập nhật sản phẩm
                    </h5>
                    <a href="products" class="btn-close"></a>
                </div>

                <form action="products?action=edit" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${editProduct.id}">

                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label">Tên sản phẩm *</label>
                                <input type="text" class="form-control"
                                       name="Name" value="${editProduct.name}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Danh mục *</label>
                                <select class="form-select" name="CategoryID" required>
                                    <option value="1" ${editProduct.categoryID == 1 ? 'selected' : ''}>Laptop</option>
                                    <option value="2" ${editProduct.categoryID == 2 ? 'selected' : ''}>Điện thoại</option>
                                    <option value="3" ${editProduct.categoryID == 3 ? 'selected' : ''}>Phụ kiện</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Giá *</label>
                                <input type="number" class="form-control"
                                       name="Price" value="${editProduct.price}" min="0" required>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Mô tả ngắn *</label>
                                <textarea class="form-control" name="ShortDescription" rows="2" required>${editProduct.shortDescription}</textarea>
                            </div>

                            <div class="col-12">
                                <label class="form-label">Mô tả đầy đủ</label>
                                <textarea class="form-control" name="FullDescription" rows="4">${editProduct.fullDescription}</textarea>
                            </div>

                            <!-- Hiển thị các ảnh hiện tại -->
                            <c:forEach items="${editImages}" var="img" varStatus="imgStatus">
                                <div class="col-md-6">
                                    <label class="form-label">URL hình ảnh ${imgStatus.index + 1}</label>
                                    <input type="url" class="form-control"
                                           name="ImageUrls" value="${img.url}"
                                           placeholder="https://example.com/image.jpg">
                                </div>
                            </c:forEach>

                            <!-- Thêm các ô nhập URL mới -->
                            <div class="col-md-6">
                                <label class="form-label">URL hình ảnh mới</label>
                                <input type="url" class="form-control"
                                       name="ImageUrls" placeholder="https://example.com/new-image.jpg">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="IsFeatured">
                                    <option value="1" ${editProduct.featured ? 'selected' : ''}>Nổi bật</option>
                                    <option value="0" ${not editProduct.featured ? 'selected' : ''}>Bình thường</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <a href="products" class="btn btn-secondary">Hủy</a>
                        <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal-backdrop fade show"></div>
</c:if>

</body>
</html>
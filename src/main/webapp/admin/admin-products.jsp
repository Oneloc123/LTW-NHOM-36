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
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination .page-link {
            color: #0d6efd;
            border: 1px solid #dee2e6;
        }
        .pagination .page-item.active .page-link {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: white;
        }
        .page-info {
            text-align: center;
            color: #6c757d;
            margin-top: 10px;
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
            <input type="hidden" name="page" value="1">
            <input type="text" class="form-control" name="keyword"
                   placeholder="Tìm kiếm sản phẩm theo tên..."
                   value="${param.keyword}">
            <button class="btn btn-outline-secondary"><i class="bi bi-search"></i></button>
        </form>

        <section class="filters mt-4">
            <form action="products" method="get">
                <input type="hidden" name="page" value="1">
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
                        <a href="products" class="btn btn-outline-secondary ms-2">
                            <i class="bi bi-arrow-clockwise"></i> Xóa lọc
                        </a>
                    </div>
                </div>
            </form>
        </section>

        <!-- Thông tin phân trang -->
        <div class="d-flex justify-content-between align-items-center mt-4 mb-3">
            <div class="text-muted">
                Hiển thị <strong>${products.size()}</strong> sản phẩm trên tổng số <strong>${totalProducts}</strong>
            </div>
            <div class="text-muted">
                Trang <strong>${currentPage}</strong>/<strong>${totalPages}</strong>
            </div>
        </div>

        <!-- Bảng sản phẩm -->
        <section class="product-table mt-2">
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
                        <c:choose>
                            <c:when test="${not empty products && products.size() > 0}">
                                <c:forEach items="${products}" var="p" varStatus="i">
                                    <tr>
                                        <td>${(currentPage - 1) * pageSize + i.index + 1}</td>
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
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center py-4">
                                        <i class="bi bi-box-seam text-muted" style="font-size: 3rem;"></i>
                                        <p class="mt-2 text-muted">Không có sản phẩm nào</p>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Phân trang -->
        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="pagination-container">
                <ul class="pagination">
                    <!-- Nút Trang trước -->
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link"
                           href="products?page=${currentPage - 1}&keyword=${param.keyword}&category=${param.category}&featured=${param.featured}"
                           aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>

                    <!-- Các nút trang -->
                    <c:choose>
                        <c:when test="${totalPages <= 10}">
                            <!-- Hiển thị tất cả các trang nếu tổng số trang <= 10 -->
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="products?page=${pageNum}&keyword=${param.keyword}&category=${param.category}&featured=${param.featured}">
                                            ${pageNum}
                                    </a>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <!-- Hiển thị phân trang với ellipsis -->
                            <c:set var="startPage" value="${currentPage - 2}"/>
                            <c:set var="endPage" value="${currentPage + 2}"/>

                            <c:if test="${startPage < 1}">
                                <c:set var="startPage" value="1"/>
                                <c:set var="endPage" value="5"/>
                            </c:if>

                            <c:if test="${endPage > totalPages}">
                                <c:set var="endPage" value="${totalPages}"/>
                                <c:set var="startPage" value="${totalPages - 4}"/>
                            </c:if>

                            <!-- Trang đầu -->
                            <c:if test="${startPage > 1}">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="products?page=1&keyword=${param.keyword}&category=${param.category}&featured=${param.featured}">
                                        1
                                    </a>
                                </li>
                                <c:if test="${startPage > 2}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:if>

                            <!-- Các trang giữa -->
                            <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                                <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="products?page=${pageNum}&keyword=${param.keyword}&category=${param.category}&featured=${param.featured}">
                                            ${pageNum}
                                    </a>
                                </li>
                            </c:forEach>

                            <!-- Trang cuối -->
                            <c:if test="${endPage < totalPages}">
                                <c:if test="${endPage < totalPages - 1}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link"
                                       href="products?page=${totalPages}&keyword=${param.keyword}&category=${param.category}&featured=${param.featured}">
                                            ${totalPages}
                                    </a>
                                </li>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

                    <!-- Nút Trang tiếp theo -->
                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link"
                           href="products?page=${currentPage + 1}&keyword=${param.keyword}&category=${param.category}&featured=${param.featured}"
                           aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>

            <!-- Thông tin hiển thị -->
            <div class="page-info">
                Hiển thị sản phẩm ${(currentPage - 1) * pageSize + 1}
                đến ${(currentPage * pageSize) > totalProducts ? totalProducts : (currentPage * pageSize)}
                trên tổng số ${totalProducts} sản phẩm
            </div>
        </c:if>

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

<script>
    // Lưu các tham số tìm kiếm khi click vào nút phân trang
    document.addEventListener('DOMContentLoaded', function() {
        // Cập nhật URL trong form tìm kiếm khi thay đổi trang
        const searchForm = document.querySelector('.filters form');
        const pageLinks = document.querySelectorAll('.page-link');

        pageLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                if (!this.classList.contains('disabled')) {
                    // Nếu là liên kết phân trang, không cần thêm gì cả
                    // URL đã được tạo sẵn trong href
                }
            });
        });

        // Reset về trang 1 khi tìm kiếm
        document.querySelector('form.input-group').addEventListener('submit', function() {
            this.querySelector('input[name="page"]').value = 1;
        });

        document.querySelector('.filters form').addEventListener('submit', function() {
            this.querySelector('input[name="page"]').value = 1;
        });
    });
</script>

</body>
</html>
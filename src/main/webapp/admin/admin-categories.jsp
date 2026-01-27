<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Danh mục | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
    <style>
        .category-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        .product-count {
            background-color: #e9ecef;
            color: #495057;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 0.85rem;
        }
        .action-disabled {
            opacity: 0.5;
            cursor: not-allowed;
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
                <li><a href="dashboard"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="products"><i class="bi bi-box"></i> Sản phẩm</a></li>
                <li><a href="categories" class="active"><i class="bi bi-tags"></i> Danh mục</a></li>
                <li><a href="orders"><i class="bi bi-cart"></i> Đơn hàng</a></li>
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
            <h3 class="fw-bold m-0"><i class="bi bi-tags"></i> Danh mục</h3>
            <div class="actions d-flex align-items-center gap-2">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    <i class="bi bi-plus-lg"></i> Thêm danh mục
                </button>
            </div>
        </header>

        <!-- Hiển thị thông báo lỗi -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- 🔎 SEARCH -->
        <div class="mb-4">
            <form class="input-group" action="categories" method="get">
                <input type="text" class="form-control" name="keyword"
                       placeholder="Tìm kiếm danh mục theo tên hoặc mô tả..."
                       value="${param.keyword}">
                <button class="btn btn-outline-secondary" type="submit" name="search">
                    <i class="bi bi-search"></i>
                </button>
            </form>

            <!-- Hiển thị kết quả tìm kiếm và nút xóa -->
            <c:if test="${not empty param.keyword}">
                <div class="mt-2 d-flex align-items-center">
            <span class="text-muted me-2">
                <i class="bi bi-funnel"></i>
                Đang tìm kiếm: <strong>"${param.keyword}"</strong>
            </span>
                    <a href="categories" class="btn btn-sm btn-outline-danger">
                        <i class="bi bi-x-lg"></i> Xóa bộ lọc
                    </a>
                </div>
            </c:if>
        </div>

        <!-- Bảng danh mục -->
        <section class="category-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty categories and fn:length(categories) > 0}">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Hình ảnh</th>
                                    <th>Tên danh mục</th>
                                    <th>Mô tả</th>
                                    <th>Số sản phẩm</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach items="${categories}" var="cat" varStatus="i">
                                    <tr>
                                        <td>${i.index + 1}</td>
                                        <td>
                                            <c:if test="${not empty cat.imageURL}">
                                                <img src="${cat.imageURL}" alt="${cat.name}"
                                                     class="category-img"
                                                     onerror="this.src='../assets/images/no-image.png'">
                                            </c:if>
                                            <c:if test="${empty cat.imageURL}">
                                                <img src="../assets/images/no-image.png" alt="No image" class="category-img">
                                            </c:if>
                                        </td>
                                        <td>${cat.name}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty cat.description}">
                                                    <c:if test="${fn:length(cat.description) > 50}">
                                                        ${fn:substring(cat.description, 0, 50)}...
                                                    </c:if>
                                                    <c:if test="${fn:length(cat.description) <= 50}">
                                                        ${cat.description}
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Không có mô tả</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="product-count">${categoryService.countProductsInCategory(cat.id)} SP</span>
                                        </td>
                                        <td>
                                            <a href="categories?action=view&id=${cat.id}" class="action-btn action-view">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="categories?action=edit&id=${cat.id}" class="action-btn action-edit">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <c:if test="${categoryService.canDeleteCategory(cat.id)}">
                                                <a href="categories?action=delete&id=${cat.id}"
                                                   onclick="return confirm('Xóa danh mục ${cat.name}?')"
                                                   class="action-btn action-delete">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </c:if>
                                            <c:if test="${not categoryService.canDeleteCategory(cat.id)}">
                                                <span class="action-btn action-disabled"
                                                      title="Không thể xóa danh mục có sản phẩm">
                                                    <i class="bi bi-trash text-muted"></i>
                                                </span>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-tags" style="font-size: 3rem; color: #6c757d;"></i>
                                <h5 class="mt-3">Không có danh mục nào</h5>
                                <p class="text-muted">
                                    <c:if test="${not empty param.keyword}">
                                        Không tìm thấy danh mục phù hợp với từ khóa "${param.keyword}"
                                    </c:if>
                                    <c:if test="${empty param.keyword}">
                                        Hãy thêm danh mục đầu tiên của bạn
                                    </c:if>
                                </p>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                    <i class="bi bi-plus-lg"></i> Thêm danh mục
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>

    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- MODAL: Thêm Danh mục -->
<div class="modal fade" id="addCategoryModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-tag"></i> Thêm danh mục</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="categories?action=add" method="post" id="addCategoryForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Tên danh mục *</label>
                            <input type="text" class="form-control" name="Name" required
                                   placeholder="Ví dụ: Laptop, Điện thoại...">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Mô tả</label>
                            <textarea class="form-control" name="Description" rows="3"
                                      placeholder="Mô tả về danh mục..."></textarea>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">URL hình ảnh</label>
                            <input type="url" class="form-control" name="ImageURL"
                                   placeholder="https://example.com/category-image.jpg">
                            <small class="text-muted">Kích thước đề xuất: 300x300px</small>
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

<!-- MODAL: Sửa Danh mục -->
<c:if test="${not empty editCategory}">
    <div class="modal fade show" id="editCategoryModal" tabindex="-1" style="display:block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-pencil-square"></i> Cập nhật danh mục
                    </h5>
                    <a href="categories" class="btn-close"></a>
                </div>

                <form action="categories?action=edit" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${editCategory.id}">

                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label">Tên danh mục *</label>
                                <input type="text" class="form-control"
                                       name="Name" value="${editCategory.name}" required>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" name="Description" rows="3">${editCategory.description}</textarea>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">URL hình ảnh</label>
                                <input type="url" class="form-control"
                                       name="ImageURL" value="${editCategory.imageURL}"
                                       placeholder="https://example.com/category-image.jpg">
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <a href="categories" class="btn btn-secondary">Hủy</a>
                        <button class="btn btn-primary" type="submit">Lưu thay đổi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal-backdrop fade show"></div>
</c:if>

<script>
    // Tự động hiển thị modal edit khi có editCategory
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty editCategory}">
        var editModal = new bootstrap.Modal(document.getElementById('editCategoryModal'));
        editModal.show();

        // Đóng modal khi click ra ngoài
        document.querySelector('.modal-backdrop').addEventListener('click', function() {
            window.location.href = 'categories';
        });
        </c:if>
    });
</script>

</body>
</html>
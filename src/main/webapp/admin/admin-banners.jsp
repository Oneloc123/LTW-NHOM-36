<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Banner | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
    <style>
        .banner-img {
            width: 100px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        .status-active {
            background-color: #d1e7dd;
            color: #0f5132;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #842029;
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
                <li><a href="products"><i class="bi bi-box"></i> Sản phẩm</a></li>
                <li><a href="categories"><i class="bi bi-tags"></i> Danh mục</a></li>
                <li><a href="admin-orders.jsp"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                <li><a href="users"><i class="bi bi-people"></i> Người dùng</a></li>
                <li><a href="blogs"><i class="bi bi-journal-text"></i> Blog</a></li>
                <li><a href="banners" class="active"><i class="bi bi-image"></i> Banner</a></li>
                <li><a href="/loggout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main -->
    <main class="main-content">

        <!-- HEADER -->
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-image"></i> Banner</h3>
            <div class="actions d-flex align-items-center gap-2">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBannerModal">
                    <i class="bi bi-plus-lg"></i> Thêm banner
                </button>
            </div>
        </header>

        <!-- 🔎 SEARCH -->
        <form class="input-group mb-4" action="banners" method="get">
            <input type="text" class="form-control" name="keyword"
                   placeholder="Tìm kiếm banner theo tiêu đề..."
                   value="${param.keyword}">
            <button class="btn btn-outline-secondary"><i class="bi bi-search"></i></button>
        </form>

        <section class="filters mt-4">
            <form action="banners" method="get">
                <div class="row g-3">
                    <div class="col-md-4">
                        <select class="form-select" name="status">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Hoạt động</option>
                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Ngừng hoạt động</option>
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

        <!-- Bảng banner -->
        <section class="banner-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Hình ảnh</th>
                            <th>Tiêu đề</th>
                            <th>Thứ tự</th>
                            <th>Ngày bắt đầu</th>
                            <th>Ngày kết thúc</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:forEach items="${banners}" var="b" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>
                                    <img src="${b.imageURL}" alt="${b.altText}"
                                         class="banner-img"
                                         onerror="this.src='../assets/images/no-image.png'">
                                </td>
                                <td>${b.title}</td>
                                <td>${b.sortOrder}</td>
                                <!-- Trong phần hiển thị ngày tháng, thay đổi cách truy cập: -->
                                <td>
                                    <c:if test="${not empty b.startDate}">
                                        <fmt:formatDate value="${b.startDateAsUtilDate}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                    <c:if test="${empty b.startDate}">
                                        -
                                    </c:if>
                                </td>

                                <td>
                                    <c:if test="${not empty b.endDate}">
                                        <fmt:formatDate value="${b.endDateAsUtilDate}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                    <c:if test="${empty b.endDate}">
                                        -
                                    </c:if>
                                </td>

                                <td>
                                    <fmt:formatDate value="${b.createAtAsUtilDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <a href="banners?action=view&id=${b.id}" class="action-btn action-view">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="banners?action=edit&id=${b.id}" class="action-btn action-edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="banners?action=delete&id=${b.id}"
                                       onclick="return confirm('Xóa banner này?')"
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

<!-- MODAL: Thêm Banner -->
<div class="modal fade" id="addBannerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-image"></i> Thêm banner</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="banners?action=add" method="post" id="addBannerForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Tiêu đề *</label>
                            <input type="text" class="form-control" name="Title" required>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">URL hình ảnh *</label>
                            <input type="url" class="form-control" name="ImageURL"
                                   placeholder="https://example.com/banner.jpg" required>
                            <small class="text-muted">Kích thước đề xuất: 1920x600px</small>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">URL liên kết</label>
                            <input type="url" class="form-control" name="LinkURL"
                                   placeholder="https://example.com/product/123">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Alt Text</label>
                            <input type="text" class="form-control" name="AltText"
                                   placeholder="Mô tả hình ảnh cho SEO">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Ngày bắt đầu</label>
                            <input type="date" class="form-control" name="StartDate">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Ngày kết thúc</label>
                            <input type="date" class="form-control" name="EndDate">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Thứ tự hiển thị *</label>
                            <input type="number" class="form-control" name="SortOrder"
                                   value="1" min="0" required>
                            <small class="text-muted">Số nhỏ hơn sẽ hiển thị trước</small>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" name="Status">
                                <option value="1" selected>Hoạt động</option>
                                <option value="0">Ngừng hoạt động</option>
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

<!-- MODAL: Sửa Banner -->
<c:if test="${not empty editBanner}">
    <div class="modal fade show" id="editBannerModal" tabindex="-1" style="display:block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-pencil-square"></i> Cập nhật banner
                    </h5>
                    <a href="banners" class="btn-close"></a>
                </div>

                <form action="banners?action=edit" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${editBanner.id}">

                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label">Tiêu đề *</label>
                                <input type="text" class="form-control"
                                       name="Title" value="${editBanner.title}" required>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">URL hình ảnh *</label>
                                <input type="url" class="form-control"
                                       name="ImageURL" value="${editBanner.imageURL}" required>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">URL liên kết</label>
                                <input type="url" class="form-control"
                                       name="LinkURL" value="${editBanner.linkURL}">
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Alt Text</label>
                                <input type="text" class="form-control"
                                       name="AltText" value="${editBanner.altText}">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Ngày bắt đầu</label>
                                <input type="date" class="form-control" name="StartDate"
                                       value="<fmt:formatDate value='${editBanner.startDate}' pattern='yyyy-MM-dd'/>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Ngày kết thúc</label>
                                <input type="date" class="form-control" name="EndDate"
                                       value="<fmt:formatDate value='${editBanner.endDate}' pattern='yyyy-MM-dd'/>">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Thứ tự hiển thị *</label>
                                <input type="number" class="form-control"
                                       name="SortOrder" value="${editBanner.sortOrder}" min="0" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="Status">
                                    <option value="1" ${editBanner.status == 1 ? 'selected' : ''}>Hoạt động</option>
                                    <option value="0" ${editBanner.status == 0 ? 'selected' : ''}>Ngừng hoạt động</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <a href="banners" class="btn btn-secondary">Hủy</a>
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
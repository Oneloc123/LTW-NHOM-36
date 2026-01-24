<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Blog | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
    <style>
        .blog-img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        .blog-summary {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
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
                <li><a href="blogs" class="active"><i class="bi bi-journal-text"></i> Blog</a></li>
                <li><a href="banners"><i class="bi bi-image"></i> Banner</a></li>
                <li><a href="/loggout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </aside>

    <!-- Main -->
    <main class="main-content">

        <!-- HEADER -->
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-journal-text"></i> Blog</h3>
            <div class="actions d-flex align-items-center gap-2">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBlogModal">
                    <i class="bi bi-plus-lg"></i> Thêm bài viết
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
            <form class="input-group" action="blogs" method="get">
                <input type="text" class="form-control" name="keyword"
                       placeholder="Tìm kiếm bài viết theo tiêu đề hoặc nội dung..."
                       value="${param.keyword}">
                <button class="btn btn-outline-secondary" type="submit">
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
                    <a href="blogs" class="btn btn-sm btn-outline-danger">
                        <i class="bi bi-x-lg"></i> Xóa bộ lọc
                    </a>
                </div>
            </c:if>
        </div>

        <!-- Bảng blog -->
        <section class="blog-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty blogs and fn:length(blogs) > 0}">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Hình ảnh</th>
                                    <th>Tiêu đề</th>
                                    <th>Tóm tắt</th>
                                    <th>Tác giả</th>
                                    <th>Ngày đăng</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach items="${blogs}" var="blog" varStatus="i">
                                    <tr>
                                        <td>${i.index + 1}</td>
                                        <td>
                                            <c:if test="${not empty blog.thumbnail}">
                                                <img src="${blog.thumbnail}" alt="${blog.title}"
                                                     class="blog-img"
                                                     onerror="this.src='../assets/images/no-image.png'">
                                            </c:if>
                                            <c:if test="${empty blog.thumbnail}">
                                                <img src="../assets/images/no-image.png" alt="No image" class="blog-img">
                                            </c:if>
                                        </td>
                                        <td>${blog.title}</td>
                                        <td class="blog-summary">
                                            <c:choose>
                                                <c:when test="${not empty blog.summary}">
                                                    <c:if test="${fn:length(blog.summary) > 100}">
                                                        ${fn:substring(blog.summary, 0, 100)}...
                                                    </c:if>
                                                    <c:if test="${fn:length(blog.summary) <= 100}">
                                                        ${blog.summary}
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Không có tóm tắt</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${blog.author}</td>
                                        <!-- Thay đổi phần hiển thị ngày tháng -->
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty blog.createdAt}">
                                                    <!-- Kiểm tra nhiều định dạng ngày tháng -->
                                                    <c:catch var="parseError">
                                                        <fmt:parseDate value="${blog.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </c:catch>

                                                    <c:if test="${not empty parseError}">
                                                        <!-- Nếu định dạng đầu không hợp lệ, thử định dạng khác -->
                                                        <c:catch var="parseError2">
                                                            <fmt:parseDate value="${blog.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate2" type="both" />
                                                            <fmt:formatDate value="${parsedDate2}" pattern="dd/MM/yyyy HH:mm" />
                                                        </c:catch>

                                                        <c:if test="${not empty parseError2}">
                                                            <!-- Nếu cả 2 định dạng đều lỗi, hiển thị nguyên gốc -->
                                                            ${blog.createdAt}
                                                        </c:if>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="blogs?action=view&id=${blog.id}" class="action-btn action-view">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <a href="blogs?action=edit&id=${blog.id}" class="action-btn action-edit">
                                                <i class="bi bi-pencil-square"></i>
                                            </a>
                                            <a href="blogs?action=delete&id=${blog.id}"
                                               onclick="return confirm('Xóa bài viết ${blog.title}?')"
                                               class="action-btn action-delete">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="bi bi-journal-text" style="font-size: 3rem; color: #6c757d;"></i>
                                <h5 class="mt-3">Không có bài viết nào</h5>
                                <p class="text-muted">
                                    <c:if test="${not empty param.keyword}">
                                        Không tìm thấy bài viết phù hợp với từ khóa "${param.keyword}"
                                    </c:if>
                                    <c:if test="${empty param.keyword}">
                                        Hãy thêm bài viết đầu tiên của bạn
                                    </c:if>
                                </p>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBlogModal">
                                    <i class="bi bi-plus-lg"></i> Thêm bài viết
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

<!-- MODAL: Thêm Blog -->
<div class="modal fade" id="addBlogModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-journal-plus"></i> Thêm bài viết</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <form action="blogs?action=add" method="post" id="addBlogForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label">Tiêu đề *</label>
                            <input type="text" class="form-control" name="Title" required
                                   placeholder="Nhập tiêu đề bài viết...">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">URL hình thumbnail</label>
                            <input type="url" class="form-control" name="Thumbnail"
                                   placeholder="https://example.com/blog-thumbnail.jpg">
                            <small class="text-muted">Kích thước đề xuất: 800x400px</small>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Tóm tắt</label>
                            <textarea class="form-control" name="Summary" rows="3"
                                      placeholder="Tóm tắt ngắn gọn về bài viết..."></textarea>
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Nội dung *</label>
                            <textarea class="form-control" name="Content" rows="10" required
                                      placeholder="Nhập nội dung bài viết..."></textarea>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Tác giả</label>
                            <input type="text" class="form-control" name="Author"
                                   placeholder="Admin" value="Admin">
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-primary" type="submit">Đăng bài</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- MODAL: Sửa Blog -->
<c:if test="${not empty editBlog}">
    <div class="modal fade show" id="editBlogModal" tabindex="-1" style="display:block;">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-pencil-square"></i> Chỉnh sửa bài viết
                    </h5>
                    <a href="blogs" class="btn-close"></a>
                </div>

                <form action="blogs?action=edit" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="id" value="${editBlog.id}">

                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label">Tiêu đề *</label>
                                <input type="text" class="form-control"
                                       name="Title" value="${editBlog.title}" required>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">URL hình thumbnail</label>
                                <input type="url" class="form-control"
                                       name="Thumbnail" value="${editBlog.thumbnail}"
                                       placeholder="https://example.com/blog-thumbnail.jpg">
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Tóm tắt</label>
                                <textarea class="form-control" name="Summary" rows="3">${editBlog.summary}</textarea>
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Nội dung *</label>
                                <textarea class="form-control" name="Content" rows="10" required>${editBlog.content}</textarea>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Tác giả</label>
                                <input type="text" class="form-control"
                                       name="Author" value="${editBlog.author}">
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <a href="blogs" class="btn btn-secondary">Hủy</a>
                        <button class="btn btn-primary" type="submit">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal-backdrop fade show"></div>
</c:if>

<script>
    // Tự động hiển thị modal edit khi có editBlog
    document.addEventListener('DOMContentLoaded', function() {
        <c:if test="${not empty editBlog}">
        var editModal = new bootstrap.Modal(document.getElementById('editBlogModal'));
        editModal.show();

        // Đóng modal khi click ra ngoài
        document.querySelector('.modal-backdrop').addEventListener('click', function() {
            window.location.href = 'blogs';
        });
        </c:if>
    });
</script>

</body>
</html>
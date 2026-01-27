
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Người dùng | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
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
                <li><a href="categories" ><i class="bi bi-tags"></i> Danh mục</a></li>
                <li><a href="orders"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                <li><a href="users" class="active"><i class="bi bi-people"></i> Người dùng</a></li>
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
            <h3 class="fw-bold m-0"><i class="bi-people"></i> Người dùng</h3>
            <div class="actions d-flex align-items-center gap-2">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="bi bi-plus-lg"></i> Thêm người dùng
                </button>
            </div>
        </header>

        <!-- 🔎 SEARCH (👉 SỬA) -->
        <form class="input-group mb-4" action="users" method="get">
            <input type="text" class="form-control" name="keyword"
                   placeholder="Tìm kiếm người dùng theo tên..."
                   value="${param.keyword}">
            <button class="btn btn-outline-secondary"><i class="bi bi-search"></i></button>
        </form>
        <section class="filters mt-4">
            <form action="users" method="get">
                <div class="row g-3">
                    <div class="col-md-4">
                        <select class="form-select" name="role">
                            <option value="">Tất cả vai trò</option>
                            <option value="USER"
                            ${param.role == 'USER' ? 'selected' : ''}>USER</option>
                            <option value="ADMIN"
                            ${param.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <select class="form-select" name="status">
                            <option value="">Tất cả trạng thái</option>
                            <option value="1"
                            ${param.status == '1' ? 'selected' : ''}>Hoạt động</option>
                            <option value="0"
                            ${param.status == '0' ? 'selected' : ''}>Đã khoá</option>
                        </select>
                    </div>

                    <!-- GIỮ keyword search -->
                    <input type="hidden" name="keyword" value="${param.keyword}"/>

                    <div class="col-md-4 text-end">
                        <button class="btn btn-primary">
                            <i class="bi bi-funnel"></i> Lọc
                        </button>
                    </div>
                </div>
            </form>
        </section>


        <!-- Bảng người dùng -->
        <section class="blog-table mt-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Tên</th>
                            <th>Email</th>
                            <th>Vai trò</th>
                            <th>Trạng thái</th>
                            <th>Ngày tạo</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>

                        <!-- 👉 SỬA: render dữ liệu từ Servlet -->
                        <tbody>
                        <c:forEach items="${users}" var="u" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${u.fullName}</td>
                                <td>${u.email}</td>
                                <td>${u.role}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${u.active}">
                                            <span class="badge badge-danger-soft">Bị khóa</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-success-soft">Hoạt động</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${u.createAt}</td>
                                <td>
                                    <a href="users?action=view&id=${u.id}" class="action-btn action-view">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="users?action=edit&id=${u.id}" class="action-btn action-edit">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <a href="users?action=delete&id=${u.id}"
                                       onclick="return confirm('Xóa người dùng này?')"
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

<!-- MODAL: Thêm Người Dùng -->
<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title fw-bold"><i class="bi bi-person-plus"></i> Thêm người dùng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">
                <!-- 👉 SỬA: submit về Servlet -->
                <form action="users?action=add" method="post" id="addUserForm">

                    <div class="row g-3">

                        <div class="col-md-6">
                            <label class="form-label">UserName</label>
                            <input type="text" class="form-control" name="UserName" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" name="FullName" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="Email" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Mật khẩu</label>
                            <input type="password" class="form-control" name="Password" required>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="Phone">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Vai trò</label>
                            <select class="form-select" name="Role">
                                <option value="admin">Admin</option>
                                <option value="user" selected>User</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Trạng thái</label>
                            <select class="form-select" name="IsActive">
                                <option value="1" selected>Hoạt động</option>
                                <option value="0">Bị khóa</option>
                            </select>
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
</div>
<%-- modal edit--%>
<c:if test="${not empty editUser}">
    <div class="modal fade show" id="editUserModal" tabindex="-1" style="display:block;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title fw-bold">
                        <i class="bi bi-pencil-square"></i> Cập nhật người dùng
                    </h5>
                    <a href="users" class="btn-close"></a>
                </div>

                <form action="users?action=edit" method="post">
                    <div class="modal-body">

                        <input type="hidden" name="id" value="${editUser.id}">

                        <div class="row g-3">

                            <div class="col-md-6">
                                <label class="form-label">UserName</label>
                                <input type="text" class="form-control"
                                       name="UserName" value="${editUser.username}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" class="form-control"
                                       name="FullName" value="${editUser.fullName}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control"
                                       name="Email" value="${editUser.email}" required>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control"
                                       name="Phone" value="${editUser.phoneNumber}">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Vai trò</label>
                                <select class="form-select" name="Role">
                                    <option value="admin"
                                        ${editUser.role == 'admin' ? 'selected' : ''}>Admin</option>
                                    <option value="user"
                                        ${editUser.role == 'user' ? 'selected' : ''}>User</option>
                                </select>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Trạng thái</label>
                                <select class="form-select" name="IsActive">
                                    <option value="1"
                                        ${editUser.active ? 'selected' : ''}>Hoạt động</option>
                                    <option value="0"
                                        ${!editUser.active ? 'selected' : ''}>Bị khóa</option>
                                </select>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer">
                        <a href="users" class="btn btn-secondary">Hủy</a>
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

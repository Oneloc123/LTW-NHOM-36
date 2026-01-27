<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thanh toán | TechX Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">


</head>

<body>

<div class="admin-container">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
        <nav>
            <ul>
                <li><a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="products"><i class="bi bi-box"></i> Sản phẩm</a></li>
                <li><a href="categories" ><i class="bi bi-tags"></i> Danh mục</a></li>
                <li><a href="admin-orders.jsp"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                <li><a href="admin-payment.jsp" class="active"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                <li><a href="users"><i class="bi bi-people"></i> Người dùng</a></li>
                <li><a href="blogs"><i class="bi bi-journal-text"></i> Blog</a></li>
                <li><a href="banners"><i class="bi bi-image"></i> Banner</a></li>
                <li><a href="/loggout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
            </ul>
        </nav>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main-content ">

        <!-- HEADER -->
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi bi-credit-card"></i> Quản lý Thanh toán</h3>

        </header>



        <!-- FILTERS -->
        <section class="filters d-flex gap-3    ">

            <div class="filter-box input-group mb-4 " style="max-width: 50%; ">
                <select class="form-select">
                    <option value="">Trạng thái</option>
                    <option>Hoàn tất</option>
                    <option>Đang xử lý</option>
                    <option>Thất bại</option>
                </select>
            </div>

            <div class="input-group mb-4">
                <input type="text" class="form-control" id="searchInput" placeholder="Tìm kiếm đơn hàng...">
                <button class="btn btn-outline-secondary"><i class="bi bi-search"></i></button>
            </div>

        </section>

        <!-- TABLE -->
        <section class="blog-table ">
            <div class="card shadow-sm">
                <div class="card-body">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Người dùng</th>
                            <th>Số tiền</th>
                            <th>Phương thức</th>
                            <th>Ngày tạo</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#1001</td>
                            <td>Nguyễn Văn A</td>
                            <td>1,200,000₫</td>
                            <td>MoMo</td>
                            <td>12/11/2025</td>
                            <td><span class="badge badge-success-soft">Hoàn tất</span></td>
                            <td> <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                            </td>
                        </tr>

                        <tr>
                            <td>#1002</td>
                            <td>Trần B</td>
                            <td>850,000₫</td>
                            <td>VNPAY</td>
                            <td>10/11/2025</td>
                            <td><span class="badge badge-warning-soft">Đang xử lý</span></td>
                            <td> <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                            </td>
                        </tr>

                        <tr>
                            <td>#1002</td>
                            <td>Trần C</td>
                            <td>850,000₫</td>
                            <td>VNPAY</td>
                            <td>10/11/2025</td>
                            <td><span class="badge badge-danger-soft">Thất bại</span></td>
                            <td> <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
        <!-- Pagination -->
        <div class="d-flex justify-content-end mt-3">
        </div>
        <nav>
            <ul class="pagination custom-pagination">
                <li class="page-item disabled"><a class="page-link">Trước</a></li>
                <li class="page-item active"><a class="page-link">1</a></li>
                <li class="page-item"><a class="page-link">2</a></li>
                <li class="page-item"><a class="page-link">3</a></li>
                <li class="page-item"><a class="page-link">Sau</a></li>
            </ul>
        </nav>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
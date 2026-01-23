<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | TechX</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../assets/admin-css/style.css">

    <style>
        /* ===== STAT CARDS ===== */
        .stat-card {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 30px;
        }

        .stat-card .icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
        }
    </style>


</head>

<body>

    <div class="admin-container">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.html"class="active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="admin-products.jsp"><i class="bi bi-box"></i> Sản phẩm</a></li>
                    <li><a href="admin-categories.jsp"><i class="bi bi-tags"></i> Danh mục</a></li>
                    <li><a href="admin-orders.jsp"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                    <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                    <li><a href="admin-users.jsp"><i class="bi bi-people"></i> Người dùng</a></li>
                    <li><a href="admin-blog.jsp"><i class="bi bi-journal-text"></i> Blog</a></li>
                    <li><a href="admin-banners.jsp"><i class="bi bi-image"></i> Banner</a></li>
                    <li><a href="admin-login.jsp"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                </ul>
            </nav>
        </aside>

        <!-- MAIN CONTENT -->
        <main class="main-content ">

            <!-- HEADER -->
            <header class="header d-flex justify-content-between align-items-center">
                <h3 class="fw-bold m-0"><i class="bi-speedometer2"></i> Dashboard</h3>

                <div class="d-flex align-items-center gap-3">

                    <img src="../assets/img/user-default.png" class="avatar">
                </div>
            </header>

            <!-- STAT CARDS -->
            <section class="row g-4 stat-cards ">

                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-primary"><i class="bi bi-currency-dollar"></i></div>
                        <div>
                            <h4>1.284.000.000₫</h4>
                            <p>Doanh thu tháng</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-info"><i class="bi bi-cart-check"></i></div>
                        <div>
                            <h4>1.256</h4>
                            <p>Đơn hàng</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-success"><i class="bi bi-people"></i></div>
                        <div>
                            <h4>842</h4>
                            <p>Người dùng</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 ">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-warning"><i class="bi bi-box-seam"></i></div>
                        <div>
                            <h4>215</h4>
                            <p>Sản phẩm</p>
                        </div>
                    </div>
                </div>

            </section>

            <!-- CHART + ORDERS -->
            <section class="row mt-4 g-4">

                <!-- CHART -->
                <div class="col-lg-7">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="fw-bold mb-3"><i class="bi bi-graph-up me-2"></i>Thống kê doanh thu</h5>

                            <div class="chart-box">
                                <p class="text-muted text-center mt-5">Biểu đồ sẽ hiển thị tại đây (Chart.js)</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- RECENT ORDERS -->
                <div class="col-lg-5">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h5 class="fw-bold mb-3"><i class="bi bi-receipt me-2"></i>Đơn hàng gần đây</h5>

                            <table class="table align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Khách hàng</th>
                                        <th>Giá trị</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Nguyễn Văn A</td>
                                        <td>22.900.000₫</td>
                                        <td><span class="order-status success">Thành công</span></td>
                                    </tr>

                                    <tr>
                                        <td>2</td>
                                        <td>Trần Thị B</td>
                                        <td>12.500.000₫</td>
                                        <td><span class="order-status pending">Đang xử lý</span></td>
                                    </tr>

                                    <tr>
                                        <td>3</td>
                                        <td>Lê Minh C</td>
                                        <td>8.200.000₫</td>
                                        <td><span class="order-status fail">Hủy</span></td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>

            </section>

        </main>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
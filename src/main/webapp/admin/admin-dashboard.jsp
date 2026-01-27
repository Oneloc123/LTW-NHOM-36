<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

        /* Status badges */
        .order-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .status-success { background-color: #d4edda; color: #155724; }
        .status-pending { background-color: #fff3cd; color: #856404; }
        .status-fail { background-color: #f8d7da; color: #721c24; }

        /* Chart placeholder */
        .chart-box {
            min-height: 300px;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        /* Avatar */
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #dee2e6;
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
                <li><a href="dashBoard" class="active"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                <li><a href="products"><i class="bi bi-box"></i> Sản phẩm</a></li>
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

    <!-- MAIN CONTENT -->
    <main class="main-content ">

        <!-- HEADER -->
        <header class="header d-flex justify-content-between align-items-center">
            <h3 class="fw-bold m-0"><i class="bi-speedometer2"></i> Dashboard</h3>

            <div class="d-flex align-items-center gap-3">
                <span class="text-muted">
                    <i class="bi bi-calendar"></i>
                    <fmt:formatDate value="<%=new java.util.Date()%>" pattern="dd/MM/yyyy HH:mm" />
                </span>
                <img src="../assets/img/user-default.png" class="avatar">
            </div>
        </header>

        <!-- STAT CARDS -->
        <section class="row g-4 stat-cards ">
            <c:if test="${not empty stats}">
                <!-- Doanh thu tháng -->
                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-primary"><i class="bi bi-currency-dollar"></i></div>
                        <div>
                            <h4><fmt:formatNumber value="${stats.monthlyRevenue}" type="currency" currencyCode="VND"/></h4>
                            <p>Doanh thu tháng</p>
                        </div>
                    </div>
                </div>

                <!-- Tổng đơn hàng -->
                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-info"><i class="bi bi-cart-check"></i></div>
                        <div>
                            <h4>${stats.totalOrders}</h4>
                            <p>Tổng đơn hàng</p>
                        </div>
                    </div>
                </div>

                <!-- Người dùng -->
                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-success"><i class="bi bi-people"></i></div>
                        <div>
                            <h4>${stats.totalUsers}</h4>
                            <p>Người dùng</p>
                        </div>
                    </div>
                </div>

                <!-- Sản phẩm -->
                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-warning"><i class="bi bi-box-seam"></i></div>
                        <div>
                            <h4>${stats.totalProducts}</h4>
                            <p>Sản phẩm</p>
                        </div>
                    </div>
                </div>

                <!-- Thêm các thẻ thống kê khác -->
                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-secondary"><i class="bi bi-cart-plus"></i></div>
                        <div>
                            <h4>${stats.monthlyOrders}</h4>
                            <p>Đơn hàng tháng</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-success"><i class="bi bi-check-circle"></i></div>
                        <div>
                            <h4>${stats.successfulOrders}</h4>
                            <p>Đơn thành công</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-warning"><i class="bi bi-clock-history"></i></div>
                        <div>
                            <h4>${stats.pendingOrders}</h4>
                            <p>Đang xử lý</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card card shadow-sm">
                        <div class="icon bg-danger"><i class="bi bi-currency-exchange"></i></div>
                        <div>
                            <h4><fmt:formatNumber value="${stats.totalRevenue}" type="currency" currencyCode="VND"/></h4>
                            <p>Doanh thu tổng</p>
                        </div>
                    </div>
                </div>
            </c:if>
        </section>

        <!-- CHART + ORDERS -->
        <section class="row mt-4 g-4">

            <!-- CHART -->
            <div class="col-lg-7">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">
                            <i class="bi bi-graph-up me-2"></i>Thống kê doanh thu 30 ngày qua
                        </h5>

                        <div class="chart-box">
                            <c:choose>
                                <c:when test="${not empty monthlyRevenue}">
                                    <!-- Nếu có dữ liệu biểu đồ -->
                                    <canvas id="revenueChart" height="300"></canvas>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted text-center mt-5">
                                        <i class="bi bi-bar-chart" style="font-size: 3rem;"></i><br>
                                        Dữ liệu biểu đồ sẽ hiển thị tại đây (Chart.js)
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- RECENT ORDERS -->
            <div class="col-lg-5">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold m-0"><i class="bi bi-receipt me-2"></i>Đơn hàng gần đây</h5>
                            <a href="admin-orders.jsp" class="btn btn-sm btn-outline-primary">
                                Xem tất cả
                            </a>
                        </div>

                        <div class="table-responsive">
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
                                <c:choose>
                                    <c:when test="${not empty recentOrders and recentOrders.size() > 0}">
                                        <c:forEach items="${recentOrders}" var="order" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>
                                                    <div>
                                                        <strong>Đơn #${order.id}</strong>
                                                        <br>
                                                        <small class="text-muted">${order.email}</small>
                                                    </div>
                                                </td>
                                                <td>
                                                    <strong>
                                                        <fmt:formatNumber value="${order.totalAmount}" type="currency"/>
                                                    </strong>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'delivered'}">
                                                            <span class="order-status status-success">Thành công</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'pending' or order.status == 'processing'}">
                                                            <span class="order-status status-pending">Đang xử lý</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'cancelled'}">
                                                            <span class="order-status status-fail">Hủy</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'shipped'}">
                                                            <span class="order-status status-info">Đang giao</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="order-status">${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="4" class="text-center py-4">
                                                <i class="bi bi-cart-x text-muted" style="font-size: 2rem;"></i>
                                                <p class="text-muted mt-2">Không có đơn hàng nào</p>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

        </section>

        <!-- QUICK ACTIONS -->
        <section class="row mt-4">
            <div class="col-12">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3"><i class="bi bi-lightning-charge me-2"></i>Hành động nhanh</h5>
                        <div class="row g-3">
                            <div class="col-md-3">
                                <a href="products" class="btn btn-outline-primary w-100">
                                    <i class="bi bi-plus-circle me-2"></i>Thêm sản phẩm
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="admin-orders.jsp" class="btn btn-outline-success w-100">
                                    <i class="bi bi-cart-check me-2"></i>Xem đơn hàng
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="users" class="btn btn-outline-info w-100">
                                    <i class="bi bi-person-plus me-2"></i>Thêm người dùng
                                </a>
                            </div>
                            <div class="col-md-3">
                                <a href="#" class="btn btn-outline-warning w-100">
                                    <i class="bi bi-bar-chart me-2"></i>Xem báo cáo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    // Auto-refresh dashboard mỗi 60 giây
    setTimeout(function() {
        window.location.reload();
    }, 60000); // 60 giây

    // Hiển thị thời gian real-time
    function updateCurrentTime() {
        const now = new Date();
        const options = {
            weekday: 'long',
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit'
        };
        document.getElementById('currentTime').textContent = now.toLocaleDateString('vi-VN', options);
    }

    // Cập nhật mỗi giây
    updateCurrentTime();
    setInterval(updateCurrentTime, 1000);
</script>

</body>
</html>
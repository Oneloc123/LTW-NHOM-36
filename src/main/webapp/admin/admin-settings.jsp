<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Cài đặt hệ thống | TechX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/admin-settings.css">

</head>

<body>
    <div class="admin-container">

        <!-- Sidebar -->
        <aside class="sidebar">
            <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="admin-products.jsp"><i class="bi bi-box"></i> Sản phẩm</a></li>
                    <li><a href="admin-orders.jsp" class="active"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                    <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                    <li><a href="admin-users.jsp"><i class="bi bi-people"></i> Người dùng</a></li>
                    <li><a href="admin-blogs.jsp"><i class="bi bi-journal-text"></i> Blog</a></li>
                    <li><a href="/loggout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main -->
        <main class="flex-grow-1 p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-gear"></i> Cài đặt hệ thống</h2>
                <button class="btn btn-primary"><i class="bi bi-save me-1"></i> Lưu thay đổi</button>
            </div>

            <div class="row g-4">
                <!-- Cài đặt chung -->
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white">
                            <i class="bi bi-sliders me-2"></i> Cài đặt chung
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="mb-3">
                                    <label class="form-label">Tên website</label>
                                    <input type="text" class="form-control" value="TechX - Shop Công nghệ">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email liên hệ</label>
                                    <input type="email" class="form-control" value="support@techx.vn">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Hotline</label>
                                    <input type="text" class="form-control" value="1900 6789">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Địa chỉ cửa hàng</label>
                                    <input type="text" class="form-control" value="123 Trần Hưng Đạo, TP.HCM">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Cài đặt giao diện -->
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white">
                            <i class="bi bi-palette me-2"></i> Cài đặt giao diện
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="form-label">Chủ đề màu</label>
                                <select class="form-select">
                                    <option>Light</option>
                                    <option selected>Dark</option>
                                    <option>Tech Neon</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Logo hiện tại</label>
                                <div class="d-flex align-items-center">
                                    <img src="https://via.placeholder.com/60x60?text=TechX" class="rounded me-3"
                                        alt="Logo">
                                    <input type="file" class="form-control">
                                </div>
                            </div>
                            <div class="form-check form-switch mb-3">
                                <input class="form-check-input" type="checkbox" id="darkModeSwitch" checked>
                                <label class="form-check-label" for="darkModeSwitch">Kích hoạt chế độ ban đêm</label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Cài đặt bảo mật -->
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white">
                            <i class="bi bi-shield-lock me-2"></i> Bảo mật
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="mb-3">
                                    <label class="form-label">Mật khẩu hiện tại</label>
                                    <input type="password" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mật khẩu mới</label>
                                    <input type="password" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Xác nhận mật khẩu</label>
                                    <input type="password" class="form-control">
                                </div>
                                <button class="btn btn-outline-danger"><i class="bi bi-key me-1"></i> Đổi mật
                                    khẩu</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Thông báo -->
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-dark text-white">
                            <i class="bi bi-bell me-2"></i> Thông báo
                        </div>
                        <div class="card-body">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" checked>
                                <label class="form-check-label">Nhận thông báo qua email</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" checked>
                                <label class="form-check-label">Hiển thị thông báo trên dashboard</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox">
                                <label class="form-check-label">Nhận thông báo khuyến mãi</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
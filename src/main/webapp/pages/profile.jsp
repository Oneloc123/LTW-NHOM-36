<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Tài khoản người dùng | TechX</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- CSS chung -->
    <link rel="stylesheet" href="../assets/css/header.css" />
    <link rel="stylesheet" href="../assets/css/footer.css" />

    <style>
        /* Reset CSS */

        :root {
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --secondary: #64748b;
            --light: #f8fafc;
            --dark: #1e293b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --gray: #94a3b8;
            --gray-light: #e2e8f0;
        }

        body {
            background: linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 50%, #fbc2eb 100%);
            color: var(--dark);
            line-height: 1.6;
        }

        body {
            background: #f4f6f9;
            font-family: "Segoe UI", sans-serif;
        }

        /* Main Content */
        .main-content {
            display: flex;
            margin: 30px 0;
            gap: 30px;
        }

        /* Sidebar */
        .main-content  .sidebar {
            width: 280px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            padding: 25px;
            height: fit-content;
        }

        .main-content  .user-info {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--gray-light);
            margin-bottom: 20px;
        }

        .main-content  .user-avatar-large {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 15px;
            border: 4px solid var(--gray-light);
            position: relative;
            cursor: pointer;
        }

        .main-content .user-avatar-large img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .main-content .avatar-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s;
            border-radius: 50%;
        }

        .main-content .user-avatar-large:hover .avatar-overlay {
            opacity: 1;
        }

        .main-content .user-name {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .main-content .user-role {
            color: var(--secondary);
            font-size: 14px;
            margin-bottom: 15px;
        }

        .main-content .user-stats {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }

        .main-content  .stat {
            text-align: center;
        }

        .main-content  .stat-value {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary);
        }

        .main-content   .stat-label {
            font-size: 12px;
            color: var(--secondary);
        }

        .main-content  .sidebar-menu {
            list-style: none;
        }

        .main-content  .sidebar-menu li {
            margin-bottom: 10px;
        }

        .main-content  .sidebar-menu a {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: var(--dark);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .main-content .sidebar-menu a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .main-content  .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: var(--primary);
            color: white;
        }

        /* Content Area */
        .main-content  .content {
            flex: 1;
        }

        .main-content .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .main-content  .content-title {
            font-size: 24px;
            font-weight: 600;
        }

        .main-content .btn {
            padding: 10px 20px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s;
            display: inline-flex;
            align-items: center;
        }

        .main-content .btn i {
            margin-right: 8px;
        }

        .main-content .btn:hover {
            background: var(--primary-dark);
        }

        .main-content  .btn-outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }

        .main-content  .btn-outline:hover {
            background: var(--primary);
            color: white;
        }

        /* Profile Card */
        .main-content  .profile-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            padding: 30px;
            margin-bottom: 30px;
        }

        .main-content .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--gray-light);
        }

        .main-content  .card-title {
            font-size: 18px;
            font-weight: 600;
        }

        .main-content  .form-group {
            margin-bottom: 20px;
        }

        .main-content  .form-row {
            display: flex;
            gap: 20px;
        }

        .main-content  .form-row .form-group {
            flex: 1;
        }

        .main-content  label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }

        .main-content   .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--gray-light);
            border-radius: 6px;
            font-size: 15px;
            transition: border 0.3s;
        }

        .main-content  .form-control:focus {
            outline: none;
            border-color: var(--primary);
        }

        /* Orders */
        .main-content  .orders-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        .main-content  .orders-table th, .orders-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid var(--gray-light);
        }

        .main-content  .orders-table th {
            background-color: #f8fafc;
            font-weight: 600;
            color: var(--secondary);
        }

        .main-content  .orders-table tr:hover {
            background-color: #f8fafc;
        }

        .main-content  .status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .main-content  .status-delivered {
            background-color: #d1fae5;
            color: var(--success);
        }

        .main-content  .status-pending {
            background-color: #fef3c7;
            color: var(--warning);
        }

        .main-content  .status-cancelled {
            background-color: #fee2e2;
            color: var(--danger);
        }

        /* Wishlist */
        .main-content  .wishlist-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .main-content .product-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .main-content .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
        }

        .main-content .product-image {
            height: 160px;
            overflow: hidden;
        }

        .main-content  .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .main-content .product-card:hover .product-image img {
            transform: scale(1.05);
        }

        .main-content .product-info {
            padding: 15px;
        }

        .main-content  .product-category {
            font-size: 12px;
            color: var(--secondary);
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .main-content  .product-name {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .main-content  .product-price {
            font-size: 18px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 15px;
        }

        .main-content  .product-actions {
            display: flex;
            justify-content: space-between;
        }

        .main-content .btn-sm {
            padding: 8px 15px;
            font-size: 14px;
        }

        .avatar-upload {
            text-align: center;
            margin-bottom: 25px;
        }

        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            overflow: hidden;
            margin: 0 auto 15px;
            border: 4px solid var(--gray-light);
            position: relative;
        }

        .avatar-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-actions {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .main-content .btn-secondary {
            background: var(--secondary);
        }

        .main-content .btn-secondary:hover {
            background: #475569;
        }

        .main-content  .btn-danger {
            background: var(--danger);
        }

        .main-content  .btn-danger:hover {
            background: #dc2626;
        }


        .profile-img-container {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto 20px;
        }
        .profile-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #007bff;
        }
        .change-img-btn {
            position: absolute;
            bottom: 10px;
            right: 10px;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .btn-custom {
            min-width: 120px;
        }
        .form-actions {
            border-top: 1px solid #dee2e6;
            padding-top: 20px;
            margin-top: 20px;
        }
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- Main Content -->
<div class="container">
    <div class="main-content">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="user-info">
                <div class="user-avatar-large" id="avatarTrigger">
                    <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" alt="User Avatar" id="currentAvatar">
                    <div class="avatar-overlay">
                        <i class="fas fa-camera text-white"></i>
                    </div>
                </div>
                <div class="user-name">${user.getLastName()}</div>
                <div class="user-role">Thành viên Bạc</div>
                <div class="user-stats">
                    <div class="stat">
                        <div class="stat-value">12</div>
                        <div class="stat-label">Đơn hàng</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">8</div>
                        <div class="stat-label">Đánh giá</div>
                    </div>
                    <div class="stat">
                        <div class="stat-value">2</div>
                        <div class="stat-label">Năm</div>
                    </div>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li><a href="#" class="active"><i class="fas fa-user"></i> Thông tin cá nhân</a></li>
                <li><a href="../Order-History"><i class="fas fa-shopping-bag"></i> Đơn hàng của tôi</a></li>
                <li><a href="../favorites"><i class="fas fa-heart"></i> Sản phẩm yêu thích</a></li>
                <li><a href="../changePassword"><i class="fas fa-lock"></i> Đổi mật khẩu</a></li>
                <li><a href="../loggout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
            </ul>
        </div>

        <!-- Content Area -->
        <div class="content">
            <div class="content-header">
                <h1 class="content-title">Thông tin cá nhân</h1>
                <button class="btn" id="updateProfileBtn" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fas fa-edit"></i> Cập nhật thông tin</button>
            </div>

            <!-- Profile Information -->
            <div class="profile-card">
                <div class="card-header">
                    <h2 class="card-title">Thông tin cơ bản</h2>
                </div>
                <form id="profileForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">Họ</label>
                            <input type="text" id="firstName" class="form-control" value="${user.getFirstName()}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Tên</label>
                            <input type="text" id="lastName" class="form-control" value="${user.getLastName()}" readonly>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" class="form-control" value="${user.getEmail()}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="phone">Số điện thoại</label>
                            <input type="text" id="phone" class="form-control" value="${user.getPhoneNumber()}" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="birthday">Ngày tạo</label>
                        <input type="date" id="birthday" class="form-control" value="${user.getPhoneNumber()}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="address">Địa chỉ</label>
                        <input type="text" id="address" class="form-control" value="123 Đường ABC, Quận 1, TP.HCM" readonly>
                    </div>
                </form>
            </div>

            <!-- Recent Orders -->
            <div class="profile-card">
                <div class="card-header">
                    <h2 class="card-title">Đơn hàng gần đây</h2>
                    <a href="/pages/order-history.jsp" class="btn btn-outline">Xem tất cả</a>
                </div>
                <div class="table-responsive">
                    <table class="orders-table">
                        <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Ngày đặt</th>
                            <th>Sản phẩm</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>#TS2023001</td>
                            <td>15/08/2023</td>
                            <td>iPhone 14 Pro Max</td>
                            <td>32.990.000₫</td>
                            <td><span class="status status-delivered">Đã giao</span></td>
                        </tr>
                        <tr>
                            <td>#TS2023002</td>
                            <td>10/08/2023</td>
                            <td>MacBook Pro 14"</td>
                            <td>45.990.000₫</td>
                            <td><span class="status status-delivered">Đã giao</span></td>
                        </tr>
                        <tr>
                            <td>#TS2023003</td>
                            <td>05/08/2023</td>
                            <td>AirPods Pro 2</td>
                            <td>7.990.000₫</td>
                            <td><span class="status status-pending">Đang xử lý</span></td>
                        </tr>
                        <tr>
                            <td>#TS2023004</td>
                            <td>01/08/2023</td>
                            <td>Apple Watch Series 8</td>
                            <td>10.990.000₫</td>
                            <td><span class="status status-cancelled">Đã hủy</span></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Wishlist -->
            <div class="profile-card">
                <div class="card-header">
                    <h2 class="card-title">Sản phẩm yêu thích</h2>
                    <a href="/pages/wishList.html" class="btn btn-outline">Xem tất cả</a>
                </div>
                <div class="wishlist-grid">
                    <!-- Product 1 -->
                    <div class="product-card">
                        <div class="product-image">
                            <img src="https://images.unsplash.com/photo-1511385348-a52b4a160dc2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" alt="Laptop">
                        </div>
                        <div class="product-info">
                            <div class="product-category">Laptop</div>
                            <div class="product-name">Dell XPS 13</div>
                            <div class="product-price">25.990.000₫</div>
                            <div class="product-actions">
                                <button class="btn btn-sm"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ</button>
                                <button class="btn btn-sm btn-outline"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 2 -->
                    <div class="product-card">
                        <div class="product-image">
                            <img src="https://images.unsplash.com/photo-1592750475338-74b7b21085ab?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" alt="Tablet">
                        </div>
                        <div class="product-info">
                            <div class="product-category">Máy tính bảng</div>
                            <div class="product-name">iPad Pro 12.9"</div>
                            <div class="product-price">28.990.000₫</div>
                            <div class="product-actions">
                                <button class="btn btn-sm"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ</button>
                                <button class="btn btn-sm btn-outline"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>

                    <!-- Product 3 -->
                    <div class="product-card">
                        <div class="product-image">
                            <img src="https://images.unsplash.com/photo-1572569511254-d8f925fe2cbb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" alt="Headphones">
                        </div>
                        <div class="product-info">
                            <div class="product-category">Tai nghe</div>
                            <div class="product-name">Sony WH-1000XM4</div>
                            <div class="product-price">7.990.000₫</div>
                            <div class="product-actions">
                                <button class="btn btn-sm"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ</button>
                                <button class="btn btn-sm btn-outline"><i class="fas fa-trash"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--  modal  --%>
<!-- Modal - Bootstrap tự động xử lý đóng/mở -->
<div class="modal fade" id="profileModal" tabindex="-1"
     aria-labelledby="profileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h5 class="modal-title" id="profileModalLabel">
                    <i class="fas fa-user-cog me-2"></i>Chỉnh Sửa Thông Tin Cá Nhân
                </h5>
                <!-- Nút đóng - Bootstrap tự động xử lý -->
                <button type="button" class="btn-close btn-close-white"
                        data-bs-dismiss="modal"
                        aria-label="Đóng"></button>
            </div>

            <!-- Form chính -->
            <form id="profileForm" action="../profile" method="post">
                <div class="modal-body">
                    <!-- Phần ảnh đại diện -->
                    <div class="text-center mb-4">
                        <div class="profile-img-container">
                            <img src="https://via.placeholder.com/150"
                                 alt="Ảnh đại diện"
                                 class="profile-img"
                                 id="profileImage">
                            <!-- Nút thay đổi ảnh -->
                            <button type="button"
                                    class="btn btn-warning change-img-btn"
                                    onclick="toggleImageForm()"
                                    title="Thay đổi ảnh">
                                <i class="fas fa-camera"></i>
                            </button>
                        </div>

                        <!-- Form upload ảnh (ẩn ban đầu) -->
                        <div id="imageForm" class="mt-3" style="display: none;">
                            <div class="input-group">
                                <input type="file"
                                       class="form-control"
                                       id="imageUpload"
                                       accept="image/*">
                                <button class="btn btn-success"
                                        type="button"
                                        onclick="uploadImage()">
                                    <i class="fas fa-upload me-1"></i>Tải lên
                                </button>
                            </div>
                            <small class="text-muted">Chấp nhận: JPG, PNG, GIF. Tối đa 2MB</small>
                        </div>
                    </div>

                    <!-- Form thông tin cá nhân -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName" class="form-label">
                                <i class="fas fa-user me-1"></i>Họ *
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="firstName"
                                   name="modalFirstName"
                                   placeholder="Nhập họ của bạn"
                                   required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName" class="form-label">
                                <i class="fas fa-user me-1"></i>Tên *
                            </label>
                            <input type="text"
                                   class="form-control"
                                   id="lastName"
                                   name="modalLastName"
                                   placeholder="Nhập tên của bạn"
                                   required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope me-1"></i>Email *
                        </label>
                        <input type="email"
                               class="form-control"
                               id="email"
                               name="modalEmail"
                               placeholder="example@gmail.com"
                               required>
                    </div>

                    <div class="mb-3">
                        <label for="phone" class="form-label">
                            <i class="fas fa-phone me-1"></i>Số điện thoại *
                        </label>
                        <input type="tel"
                               class="form-control"
                               id="phone"
                               name="modalPhone"
                               placeholder=""
                               required>
                    </div>

                    <div class="mb-4">
                        <label for="address" class="form-label">
                            <i class="fas fa-home me-1"></i>Địa chỉ *
                        </label>
                        <textarea class="form-control"
                                  id="address"
                                  rows="3"
                                  placeholder="Nhập địa chỉ đầy đủ"
                                  required></textarea>
                    </div>

                    <!-- Nút bấm trong form -->
                    <div class="form-actions">
                        <div class="d-flex justify-content-end gap-2">
                            <!-- Nút Huỷ - Bootstrap tự động đóng modal -->
                            <button type="button"
                                    class="btn btn-secondary btn-custom"
                                    data-bs-dismiss="modal">
                                <i class="fas fa-times me-1"></i>Huỷ
                            </button>

                            <!-- Nút Lưu - Gọi hàm xử lý -->
                            <button type="submit" name="action" value="save"
                                    class="btn btn-primary btn-custom"
                            <%--                                      onclick="saveProfile()">--%>
                            <i class="fas fa-save me-1"></i>Lưu Thông Tin
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<footer class="footer bg-light text-dark pt-5 pb-4 mt-5 border-top">
    <div class="container">
        <div class="row gy-4">

            <div class="col-md-4">
                <a href="/index.jsp" class="d-flex align-items-center text-decoration-none mb-3">
                    <i class="bi bi-camera fs-3 text-primary me-2"></i>
                    <span class="fw-bold fs-5 text-primary">TechX</span>
                </a>
                <p class="text-muted">
                    Nơi bạn tìm thấy những thiết bị công nghệ độc đáo, hiện đại và sáng tạo.
                </p>
            </div>

            <div class="col-md-2">
                <h6 class="fw-bold text-uppercase mb-3">Danh mục</h6>
                <ul class="list-unstyled">
                    <li><a href="/pages/products.html#mini-tech" class="footer-link">Công nghệ mini</a></li>
                    <li><a href="/pages/products.html#ai-device" class="footer-link">Thiết bị AI</a></li>
                    <li><a href="/pages/products.html#creative" class="footer-link">Phụ kiện sáng tạo</a></li>
                    <li><a href="/pages/products.html#fun-tech" class="footer-link">Đồ chơi công nghệ</a></li>
                </ul>
            </div>

            <div class="col-md-2">
                <h6 class="fw-bold text-uppercase mb-3">Hỗ trợ</h6>
                <ul class="list-unstyled">
                    <li><a href="/pages/contact.html" class="footer-link">Liên hệ</a></li>
                    <li><a href="/pages/forgot-password.jsp" class="footer-link">Quên mật khẩu</a></li>
                    <li><a href="/pages/order-history.jsp" class="footer-link">Theo dõi đơn hàng</a></li>
                    <li><a href="/pages/404.html" class="footer-link">Trung tâm trợ giúp</a></li>
                </ul>
            </div>

            <div class="col-md-4">
                <h6 class="fw-bold text-uppercase mb-3">Liên hệ</h6>
                <p><i class="bi bi-geo-alt-fill text-primary me-2"></i>123 Nguyễn Huệ, TP.HCM</p>
                <p><i class="bi bi-telephone-fill text-primary me-2"></i>+84 987 654 321</p>
                <p><i class="bi bi-envelope-fill text-primary me-2"></i>support@htcamera.vn</p>
            </div>

        </div>

        <hr />

        <div class="text-center small text-muted">
            © 2025 <strong>TechX</strong>. All rights reserved.
        </div>
    </div>
</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap 5 JS Bundle với Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // // Hiển thị/ẩn form upload ảnh
    // function toggleImageForm() {
    //     const imageForm = document.getElementById('imageForm');
    //     imageForm.style.display = imageForm.style.display === 'none' ? 'block' : 'none';
    // }

    // // Upload và hiển thị ảnh mới
    // function uploadImage() {
    //     const fileInput = document.getElementById('imageUpload');
    //     if (fileInput.files && fileInput.files[0]) {
    //         // Kiểm tra kích thước
    //         if (fileInput.files[0].size > 2 * 1024 * 1024) {
    //             alert('Kích thước ảnh không được vượt quá 2MB!');
    //             return;
    //         }
    //
    //         const reader = new FileReader();
    //         reader.onload = function(e) {
    //             document.getElementById('profileImage').src = e.target.result;
    //             document.getElementById('imageForm').style.display = 'none';
    //             alert('Ảnh đã được cập nhật thành công!');
    //             fileInput.value = ''; // Reset input file
    //         };
    //         reader.readAsDataURL(fileInput.files[0]);
    //     } else {
    //         alert('Vui lòng chọn một tệp ảnh!');
    //     }
    // }

    // Xử lý lưu thông tin
    // function saveProfile() {
    //     // Lấy giá trị từ form
    //     const firstName = document.getElementById('firstName').value.trim();
    //     const lastName = document.getElementById('lastName').value.trim();
    //     const email = document.getElementById('email').value.trim();
    //     const phone = document.getElementById('phone').value.trim();
    //     const address = document.getElementById('address').value.trim();

    // Validation cơ bản
    // if (!firstName || !lastName || !email || !phone || !address) {
    //     alert('Vui lòng điền đầy đủ tất cả các trường thông tin có dấu *!');
    //     return;
    // }

    // Kiểm tra email
    // const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    // if (!emailRegex.test(email)) {
    //     alert('Vui lòng nhập địa chỉ email hợp lệ!');
    //     return;
    // }

    // Hiển thị thông tin (trong thực tế sẽ gửi AJAX đến server)
    <%--alert(`Thông tin đã được lưu thành công!\n\n` +--%>
    <%--    `Họ: ${firstName}\n` +--%>
    <%--    `Tên: ${lastName}\n` +--%>
    <%--    `Email: ${email}\n` +--%>
    <%--    `SĐT: ${phone}\n` +--%>
    <%--    `Địa chỉ: ${address}`);--%>

    // Ở đây bạn có thể thêm AJAX call để gửi dữ liệu đến server
    // $.ajax({
    //     url: 'saveProfile.jsp',
    //     type: 'POST',
    //     data: {
    //         firstName: firstName,
    //         lastName: lastName,
    //         email: email,
    //         phone: phone,
    //         address: address
    //     },
    //     success: function(response) {
    //         // Xử lý response
    //     }
    // });
    // }
</script>
</body>

</html>
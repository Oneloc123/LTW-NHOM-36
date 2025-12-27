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

        /* Modal */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .modal.active {
            display: flex;
        }

        .modal-content {
            background: white;
            border-radius: 10px;
            width: 100%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: modalFadeIn 0.3s ease;
        }

        @keyframes modalFadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 25px;
            border-bottom: 1px solid var(--gray-light);
        }

        .modal-title {
            font-size: 20px;
            font-weight: 600;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: var(--secondary);
            transition: color 0.3s;
        }

        .modal-close:hover {
            color: var(--dark);
        }

        .modal-body {
            padding: 25px;
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

        .modal-footer {
            padding: 20px 25px;
            border-top: 1px solid var(--gray-light);
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
  </style>
</head>

<body>
  <!-- HEADER -->
  <header class="header-scope navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
    <div class="container">
      <a class="navbar-brand d-flex align-items-center fw-bold text-primary" href="/DoCongNghe_Nhom36_war/home">
        <i class="bi bi-camera fs-4 me-2"></i>
        TechX
      </a>

      <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <i class="bi bi-list fs-2 text-primary"></i>
      </button>

      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav align-items-lg-center gap-lg-3">
          <li class="nav-item"><a class="nav-link " href="/DoCongNghe_Nhom36_war/home">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="/DoCongNghe_Nhom36_war/shop">Cửa hàng</a></li>

                                  <li class="nav-item"><a class="nav-link" href="/pages/products.html">Sản phẩm</a></li>


          <li class="nav-item"><a class="nav-link" href="/pages/blog.html">Blog</a></li>
          <li class="nav-item"><a class="nav-link" href="/pages/contact.html">Liên hệ</a></li>
          <li class="nav-item"><a class="nav-link" href="/pages/order-history.jsp">Đơn hàng</a></li>
           <!-- Dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="navbarDropdown" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            Tài khoản 
                        </a>
                        <ul class="dropdown-menu border-0 shadow rounded-3" aria-labelledby="navbarDropdown">
                            <li><a class="dropdown-item" href="/DoCongNghe_Nhom36_war//Profile">Thông tin tài khoản</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="/DoCongNghe_Nhom36_war//Wishlist">Danh sách sản phẩm yêu thích</a></li>
                            <li><a class="dropdown-item" href="notification.html">Xem thông báo</a></li>
                            <li><a class="dropdown-item" href="viewed-product.html">Sản phẩm đã xem</a>
                            </li>
                           
                        </ul>
                    </li>
        </ul>

        <div class="ms-lg-3 mt-3 mt-lg-0 d-flex align-items-center gap-2">
          <a href="/DoCongNghe_Nhom36_war/login" class="btn btn-outline-primary btn-sm">
            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
          </a>
          <a href="/pages/cart.html" class="btn btn-primary btn-sm">
            <i class="bi bi-cart3 me-1"></i>Giỏ hàng
          </a>
        </div>
      </div>
    </div>
  </header>

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
                    <div class="user-name">"${user.getLastName()}"</div>
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
                    <li><a href="/pages/order-history.jsp"><i class="fas fa-shopping-bag"></i> Đơn hàng của tôi</a></li>
                    <li><a href="/pages/wishList.html"><i class="fas fa-heart"></i> Sản phẩm yêu thích</a></li>
                    <li><a href="/DoCongNghe_Nhom36_war//changePassword"><i class="fas fa-lock"></i> Đổi mật khẩu</a></li>
                    <li><a href="/DoCongNghe_Nhom36_war/loggout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a></li>
                </ul>
            </div>

            <!-- Content Area -->
            <div class="content">
                <div class="content-header">
                    <h1 class="content-title">Thông tin cá nhân</h1>
                    <button class="btn" id="updateProfileBtn"><i class="fas fa-edit"></i> Cập nhật thông tin</button>
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
                            <label for="birthday">Ngày sinh</label>
                            <input type="date" id="birthday" class="form-control" value="1990-05-15" readonly>
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

    <!-- Update Profile Modal -->
    <div class="modal" id="updateProfileModal" style="margin-top: 50px;">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">Cập nhật thông tin cá nhân</h3>
                <button class="modal-close" id="closeModal">&times;</button>
            </div>
            <div class="modal-body">
                <div class="avatar-upload">
                    <div class="avatar-preview">
                        <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=80" alt="Avatar Preview" id="avatarPreview">
                    </div>
                    <div class="avatar-actions">
                        <button class="btn btn-sm"><i class="fas fa-upload"></i> Tải ảnh lên</button>
                        <button class="btn btn-sm btn-secondary"><i class="fas fa-camera"></i> Chụp ảnh</button>
                        <button class="btn btn-sm btn-danger"><i class="fas fa-trash"></i> Xóa ảnh</button>
                    </div>
                </div>
                
                <form id="updateProfileForm">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="modalFirstName">Họ</label>
                            <input type="text" id="modalFirstName" class="form-control" value="Nguyễn Văn">
                        </div>
                        <div class="form-group">
                            <label for="modalLastName">Tên</label>
                            <input type="text" id="modalLastName" class="form-control" value="A">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="modalEmail">Email</label>
                            <input type="email" id="modalEmail" class="form-control" value="nguyenvana@example.com">
                        </div>
                        <div class="form-group">
                            <label for="modalPhone">Số điện thoại</label>
                            <input type="text" id="modalPhone" class="form-control" value="0909123456">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="modalBirthday">Ngày sinh</label>
                        <input type="date" id="modalBirthday" class="form-control" value="1990-05-15">
                    </div>
                    <div class="form-group">
                        <label for="modalAddress">Địa chỉ</label>
                        <input type="text" id="modalAddress" class="form-control" value="123 Đường ABC, Quận 1, TP.HCM">
                    </div>
                    <div class="form-group">
                        <label for="modalBio">Giới thiệu bản thân</label>
                        <textarea id="modalBio" class="form-control" rows="3" placeholder="Giới thiệu ngắn về bản thân...">Tôi là một người đam mê công nghệ và thích khám phá những sản phẩm mới nhất trên thị trường.</textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline" id="cancelUpdate">Hủy bỏ</button>
                <button class="btn" id="saveProfile">Lưu thay đổi</button>
            </div>
        </div>
    </div>


  <!-- FOOTER -->
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
   <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Modal elements
            const updateProfileBtn = document.getElementById('updateProfileBtn');
            const updateProfileModal = document.getElementById('updateProfileModal');
            const closeModal = document.getElementById('closeModal');
            const cancelUpdate = document.getElementById('cancelUpdate');
            const saveProfile = document.getElementById('saveProfile');
            const avatarTrigger = document.getElementById('avatarTrigger');
            
            // Form elements
            const profileForm = document.getElementById('profileForm');
            const updateProfileForm = document.getElementById('updateProfileForm');
            const formControls = profileForm.querySelectorAll('.form-control');
            
            // Open modal
            updateProfileBtn.addEventListener('click', function() {
                updateProfileModal.classList.add('active');
                document.body.style.overflow = 'hidden';
                
                // Copy current values to modal form
                document.getElementById('modalFirstName').value = document.getElementById('firstName').value;
                document.getElementById('modalLastName').value = document.getElementById('lastName').value;
                document.getElementById('modalEmail').value = document.getElementById('email').value;
                document.getElementById('modalPhone').value = document.getElementById('phone').value;
                document.getElementById('modalBirthday').value = document.getElementById('birthday').value;
                document.getElementById('modalAddress').value = document.getElementById('address').value;
            });
            
            // Close modal
            function closeModalFunc() {
                updateProfileModal.classList.remove('active');
                document.body.style.overflow = 'auto';
            }
            
            closeModal.addEventListener('click', closeModalFunc);
            cancelUpdate.addEventListener('click', closeModalFunc);
            
            // Close modal when clicking outside
            updateProfileModal.addEventListener('click', function(e) {
                if (e.target === updateProfileModal) {
                    closeModalFunc();
                }
            });
            
            // Save profile changes
            saveProfile.addEventListener('click', function() {
                // Update main form with modal values
                document.getElementById('firstName').value = document.getElementById('modalFirstName').value;
                document.getElementById('lastName').value = document.getElementById('modalLastName').value;
                document.getElementById('email').value = document.getElementById('modalEmail').value;
                document.getElementById('phone').value = document.getElementById('modalPhone').value;
                document.getElementById('birthday').value = document.getElementById('modalBirthday').value;
                document.getElementById('address').value = document.getElementById('modalAddress').value;
                
                // Update user name in sidebar and header
                const fullName = document.getElementById('modalFirstName').value + ' ' + document.getElementById('modalLastName').value;
                document.querySelector('.user-name').textContent = fullName;
                document.querySelector('.user-menu span').textContent = fullName;
                
                // Show success message
                alert('Thông tin cá nhân đã được cập nhật thành công!');
                
                closeModalFunc();
            });
            
            // Avatar upload trigger
            avatarTrigger.addEventListener('click', function() {
                updateProfileModal.classList.add('active');
                document.body.style.overflow = 'hidden';
            });
            
            // Add to cart functionality for wishlist items
            const addToCartBtns = document.querySelectorAll('.product-actions .btn:first-child');
            
            addToCartBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const productName = this.closest('.product-card').querySelector('.product-name').textContent;
                    alert(`Đã thêm ${productName} vào giỏ hàng!`);
                });
            });
            
            // Remove from wishlist functionality
            const removeFromWishlistBtns = document.querySelectorAll('.product-actions .btn-outline');
            
            removeFromWishlistBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    const productCard = this.closest('.product-card');
                    const productName = productCard.querySelector('.product-name').textContent;
                    
                    if (confirm(`Bạn có chắc muốn xóa ${productName} khỏi danh sách yêu thích?`)) {
                        productCard.style.opacity = '0';
                        setTimeout(() => {
                            productCard.remove();
                        }, 300);
                    }
                });
            });
        });
    </script>
</body>

</html>
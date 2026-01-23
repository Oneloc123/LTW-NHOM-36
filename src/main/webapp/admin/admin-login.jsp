<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập Admin | TechX</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../assets/admin-css/admin-login.css">

</head>
<body>

<div class="admin-login-container">
    <div class="login-card shadow-lg p-4 rounded">
        <div class="text-center mb-4">
            <i class="bi bi-cpu fs-1 text-primary"></i>
            <h2 class="fw-bold mt-2">TechX Admin</h2>
            <p class="text-muted">Đăng nhập để quản lý hệ thống</p>
        </div>

        <form action="admin-dashboard.jsp" method="get">
            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" class="form-control" id="username" placeholder="Nhập tên đăng nhập" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" placeholder="Nhập mật khẩu" required>
            </div>

            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                </div>
                <a href="#" class="text-decoration-none text-primary">Quên mật khẩu?</a>
            </div>

            <button type="submit" class="btn btn-primary w-100 fw-bold">Đăng nhập</button>
        </form>

        <div class="divider my-4 text-center text-muted">hoặc</div>

        <div class="d-flex justify-content-center gap-3">
            <button class="btn btn-outline-dark"><i class="bi bi-google"></i> Google</button>
            <button class="btn btn-outline-primary"><i class="bi bi-facebook"></i> Facebook</button>
        </div>

        <footer class="text-center mt-4 small text-muted">
            © 2025 TechX Admin. All rights reserved.
        </footer>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

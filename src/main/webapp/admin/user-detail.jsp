<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết người dùng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header fw-bold">
            <i class="bi bi-person"></i> Chi tiết người dùng
        </div>

        <div class="card-body">
            <table class="table table-bordered">
                <tr>
                    <th>ID</th>
                    <td>${user.id}</td>
                </tr>
                <tr>
                    <th>UserName</th>
                    <td>${user.username}</td>
                </tr>
                <tr>
                    <th>Họ tên</th>
                    <td>${user.fullName}</td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td>${user.email}</td>
                </tr>
                <tr>
                    <th>Số điện thoại</th>
                    <td>${user.phoneNumber}</td>
                </tr>
                <tr>
                    <th>Vai trò</th>
                    <td>${user.role}</td>
                </tr>
                <tr>
                    <th>Trạng thái</th>
                    <td>
                        <c:choose>
                            <c:when test="${user.active}">
                                <span class="badge bg-success">Hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-danger">Bị khóa</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
                <tr>
                    <th>Ngày tạo</th>
                    <td>${user.createAt}</td>
                </tr>
            </table>
        </div>

        <div class="card-footer text-end">
            <a href="users" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>
</div>

</body>
</html>

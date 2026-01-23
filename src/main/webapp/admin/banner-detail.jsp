<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Banner</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .banner-detail-img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .info-label {
            font-weight: bold;
            color: #495057;
        }
    </style>
</head>

<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header fw-bold">
            <i class="bi bi-image"></i> Chi tiết Banner
        </div>

        <div class="card-body">
            <div class="row">
                <!-- Hình ảnh banner -->
                <div class="col-md-5">
                    <div class="text-center mb-3">
                        <img src="${banner.imageURL}"
                             alt="${banner.altText}"
                             class="banner-detail-img"
                             onerror="this.src='../assets/images/no-image.png'">
                    </div>

                    <c:if test="${not empty banner.linkURL}">
                        <div class="text-center mt-3">
                            <a href="${banner.linkURL}" target="_blank" class="btn btn-outline-primary">
                                <i class="bi bi-link-45deg"></i> Xem liên kết
                            </a>
                        </div>
                    </c:if>
                </div>

                <!-- Thông tin banner -->
                <div class="col-md-7">
                    <table class="table table-bordered">
                        <tr>
                            <td class="info-label" width="40%">ID</td>
                            <td>${banner.id}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Tiêu đề</td>
                            <td>${banner.title}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Alt Text</td>
                            <td>${banner.altText}</td>
                        </tr>
                        <tr>
                            <td class="info-label">URL hình ảnh</td>
                            <td>
                                <small><a href="${banner.imageURL}" target="_blank">${banner.imageURL}</a></small>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">URL liên kết</td>
                            <td>
                                <c:if test="${not empty banner.linkURL}">
                                    <small><a href="${banner.linkURL}" target="_blank">${banner.linkURL}</a></small>
                                </c:if>
                                <c:if test="${empty banner.linkURL}">
                                    -
                                </c:if>
                            </td>
                        </tr>
                        <!-- Sử dụng helper methods để format date -->
                        <tr>
                            <td class="info-label">Ngày bắt đầu</td>
                            <td>
                                <c:if test="${not empty banner.startDate}">
                                    <fmt:formatDate value="${banner.startDateAsUtilDate}" pattern="dd/MM/yyyy"/>
                                </c:if>
                                <c:if test="${empty banner.startDate}">
                                    Không giới hạn
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">Ngày kết thúc</td>
                            <td>
                                <c:if test="${not empty banner.endDate}">
                                    <fmt:formatDate value="${banner.endDate}" pattern="dd/MM/yyyy"/>
                                </c:if>
                                <c:if test="${empty banner.endDate}">
                                    Không giới hạn
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">Thứ tự hiển thị</td>
                            <td>${banner.sortOrder}</td>
                        </tr>
                        <tr>
                            <td class="info-label">Trạng thái</td>
                            <td>
                                <c:choose>
                                    <c:when test="${banner.status == 1}">
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Ngừng hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">Ngày tạo</td>
                            <td>
                                <fmt:formatDate value="${banner.createAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">Ngày cập nhật</td>
                            <td>
                                <fmt:formatDate value="${banner.updateAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="info-label">Trạng thái hiện tại</td>
                            <td>
                                <c:choose>
                                    <c:when test="${banner.status == 0}">
                                        <span class="badge bg-secondary">Ngừng hoạt động</span>
                                    </c:when>
                                    <c:when test="${not empty banner.endDate and banner.endDate.time lt today.time}">
                                        <span class="badge bg-danger">Hết hạn</span>
                                    </c:when>
                                    <c:when test="${not empty banner.startDate and banner.startDate.time gt today.time}">
                                        <span class="badge bg-warning">Chưa đến ngày</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">Đang hiển thị</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="card-footer text-end">
            <a href="banners" class="btn btn-secondary">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>
    </div>
</div>

<script>
    // Định nghĩa biến today cho JSTL (nếu cần)
    var today = new Date();
</script>

</body>
</html>
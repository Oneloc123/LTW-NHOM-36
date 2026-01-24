<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <title>Cửa hàng - TechX</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css"/>
</head>

<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main class="container mt-4">

    <h3 class="section-title mb-4">Tất cả sản phẩm</h3>

    <c:choose>
        <c:when test="${not empty list}">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">

                <c:forEach var="product" items="${list}">
                    <div class="col">
                        <div class="product-card h-100">

                            <!-- Image -->
                            <a href="${pageContext.request.contextPath}/product?id=${product.id}">
                                <img src="${empty product.imagesTop
                                    ? pageContext.request.contextPath.concat('/assets/img/default-product.jpg')
                                    : product.imagesTop}"
                                     class="product-img"
                                     alt="${product.name}">
                            </a>

                            <div class="p-3 d-flex flex-column">

                                <!-- Category -->
                                <div class="text-muted small mb-1">
                                    <c:choose>
                                        <c:when test="${product.categoryID == 1}">Công nghệ mini</c:when>
                                        <c:when test="${product.categoryID == 2}">Thiết bị AI</c:when>
                                        <c:when test="${product.categoryID == 3}">Phụ kiện sáng tạo</c:when>
                                        <c:when test="${product.categoryID == 4}">Đồ chơi công nghệ</c:when>
                                    </c:choose>
                                </div>

                                <!-- Name -->
                                <h6 class="fw-bold">
                                    <a class="text-decoration-none text-dark"
                                       href="${pageContext.request.contextPath}/product?id=${product.id}">
                                            ${product.name}
                                    </a>
                                </h6>

                                <!-- Price -->
                                <p class="text-danger fw-bold mb-2">
                                    <fmt:formatNumber value="${product.price}"
                                                      type="currency"
                                                      currencySymbol="₫"
                                                      maxFractionDigits="0"/>
                                </p>

                                <!-- Add cart -->
                                <form action="${pageContext.request.contextPath}/add-cart" method="post" class="mt-auto">
                                    <input type="hidden" name="id" value="${product.id}">
                                    <input type="hidden" name="q" value="1">
                                    <button class="btn btn-primary w-100">
                                        <i class="bi bi-cart-plus"></i> Thêm vào giỏ
                                    </button>
                                </form>

                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </c:when>

        <c:otherwise>
            <div class="text-center text-muted py-5">
                <i class="bi bi-search fs-1"></i>
                <p class="mt-3">Không có sản phẩm nào</p>
            </div>
        </c:otherwise>
    </c:choose>

</main>

<%--<%@ include file="/WEB-INF/views/common/footer.jsp" %>--%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

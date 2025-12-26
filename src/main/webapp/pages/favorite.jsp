<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h3>Sản phẩm yêu thích</h3>

<form method="get" action="favorites" class="row mb-3">
    <div class="col-md-4">
        <input type="text" name="keyword" class="form-control"
               placeholder="Tìm sản phẩm..." value="${param.keyword}">
    </div>
    <div class="col-md-3">
        <select name="status" class="form-select">
            <option value="">-- Trạng thái --</option>
            <option value="AVAILABLE">Còn hàng</option>
            <option value="RENTED">Đã thuê</option>
        </select>
    </div>
    <div class="col-md-2">
        <button class="btn btn-primary">Lọc</button>
    </div>
</form>

<div class="row">
    <c:forEach items="${favorites}" var="p">
        <div class="col-md-4 mb-3">
            <div class="card">
                <img src="${p.imageUrl}" class="card-img-top">
                <div class="card-body">
                    <h5>${p.productName}</h5>
                    <p>${p.price} đ</p>
                    <span class="badge bg-info">${p.status}</span>
                </div>
                <div class="card-footer text-center">
                    <a href="product-detail?id=${p.productId}" class="btn btn-sm btn-outline-primary">
                        Xem chi tiết
                    </a>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<nav>
    <ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${i == currentPage ? 'active' : ''}">
                <a class="page-link"
                   href="favorites?page=${i}&keyword=${param.keyword}&status=${param.status}">
                        ${i}
                </a>
            </li>
        </c:forEach>
    </ul>
</nav>


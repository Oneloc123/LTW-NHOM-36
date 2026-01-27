<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<style>
    /* Không cho chữ menu xuống dòng */
    .navbar-nav .nav-link {
        white-space: nowrap;
    }
</style>
<!-- ================= Header ================= -->
<div class="header-scope">
    <header class="navbar navbar-expand-lg bg-white shadow-sm sticky-top header-main py-2">
        <div class="container">

            <!-- Logo -->
            <a class="navbar-brand d-flex align-items-center fw-bold text-primary"
               href="${pageContext.request.contextPath}/home">
                <i class="bi bi-camera fs-4 me-2"></i>
                <span>TechX</span>
            </a>

            <!-- Toggle (mobile) -->
            <button class="navbar-toggler border-0" type="button"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarNav"
                    aria-controls="navbarNav"
                    aria-expanded="false"
                    aria-label="Toggle navigation">
                <i class="bi bi-list fs-2 text-primary"></i>
            </button>

            <!-- Nav links -->
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav align-items-lg-center gap-lg-3">
                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'home' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/home">Trang chủ</a>
                    </li>


                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'products' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'blog' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/blog">Blog</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'contact' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/contact">Liên hệ</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'orders' ? 'active' : ''}"
                           href="${pageContext.request.contextPath}/user/orders">Đơn hàng</a>
                    </li>

                    <!-- Dropdown -->
                    <%
                        if (session.getAttribute("id") != null) {
                    %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle ${currentPage == 'profile' ? 'active' : ''}"
                           href="#"
                           id="navbarDropdown"
                           role="button"
                           data-bs-toggle="dropdown"
                           aria-expanded="false">
                            Tài khoản
                        </a>

                        <ul class="dropdown-menu border-0 shadow rounded-3"
                            aria-labelledby="navbarDropdown">

                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/profile">
                                    Thông tin tài khoản
                                </a>
                            </li>

                            <li><hr class="dropdown-divider"></li>

                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/wishlist">
                                    Danh sách yêu thích
                                </a>
                            </li>

                            <li><hr class="dropdown-divider"></li>

                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/loggout">
                                    đăng xuất
                                </a>
                            </li>
                        </ul>
                    </li>
                    <%
                        }
                    %>


                </ul>

                <!-- Login & Cart -->
                <div class="ms-lg-3 mt-3 mt-lg-0 d-flex align-items-center gap-2">

                    <%
                        if (session.getAttribute("id") == null) {
                    %>
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-outline-primary btn-sm d-flex align-items-center">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập
                    </a>
                    <%
                        }
                    %>

                    <a href="${pageContext.request.contextPath}/cart"
                       class="btn btn-primary btn-sm d-flex align-items-center">
                        <i class="bi bi-cart3 me-1"></i> Giỏ hàng
                    </a>
                </div>
            </div>
        </div>
    </header>
</div>

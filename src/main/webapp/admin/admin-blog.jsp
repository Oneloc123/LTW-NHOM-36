<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quản lý Blog | TechX</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="../assets/admin-css/style.css">
</head>

<body>

    <div class="admin-container">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="admin-products.jsp"><i class="bi bi-box"></i> Sản phẩm</a></li>
                    <li><a href="admin-categories.jsp"><i class="bi bi-tags"></i> Danh mục</a></li>
                    <li><a href="admin-orders.jsp"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                    <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                    <li><a href="admin-users.jsp"><i class="bi bi-people"></i> Người dùng</a></li>
                    <li><a href="admin-blog.html" class="active"><i class="bi bi-journal-text"></i> Blog</a></li>
                    <li><a href="admin-banners.jsp"><i class="bi bi-image"></i> Banner</a></li>
                    <li><a href="admin-login.jsp"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                </ul>
            </nav>
        </aside>

        <!-- MAIN -->
        <main class="main-content">

            <!-- Header -->
            <header class="header d-flex justify-content-between align-items-center">
                <h3 class="fw-bold m-0"> <i class=" bi-journal-text"></i> Quản lý Blog</h3>
                <div class="actions d-flex align-items-center gap-2">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        <i class="bi bi-plus-lg"></i> Thêm bài viết
                    </button>
                </div>
            </header>

            <!-- Search Bar -->
            <div class="input-group mb-4">
                <input type="text" class="form-control" id="searchInput" placeholder="Tìm sản phẩm theo tên...">
                <button class="btn btn-outline-secondary"><i class="bi bi-search"></i></button>
            </div>

            <!-- Bộ lọc -->
            <section class="filters mt-4">
                <div class="row g-3">
                    <div class="col-md-4">
                        <select class="form-select">
                            <option value="">Tất cả chuyên mục</option>
                            <option>Công nghệ mới</option>
                            <option>Đánh giá thiết bị</option>
                            <option>Khuyến mãi</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <select class="form-select">
                            <option value="">Tất cả trạng thái</option>
                            <option>Đã xuất bản</option>
                            <option>Bản nháp</option>
                            <option>Đang duyệt</option>
                        </select>
                    </div>
                    <div class="col-md-4 text-end">
                        <button class="btn btn-primary"><i class="bi bi-funnel m"></i> Lọc</button>
                    </div>
                </div>
            </section>

            <!-- TABLE -->
            <section class="blog-table mt-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Ảnh</th>
                                    <th>Tiêu đề</th>
                                    <th>Tác giả</th>
                                    <th>Chuyên mục</th>
                                    <th>Ngày đăng</th>
                                    <th>Cập nhật</th>
                                    <th>Lượt xem</th>
                                    <th>Bình luận</th>
                                    <th>Trạng thái</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>

                                <!-- Row 1 -->
                                <tr>
                                    <td>1</td>
                                    <td><img src="https://mac24h.vn/images/detailed/93/Macbook_Pro_M3_2023_Mac24h.png"
                                            class="product-img" alt="MacBook"></td>
                                    <td>Công nghệ AI mới trên robot</td>
                                    <td>Nguyễn Văn A</td>
                                    <td>Công nghệ mới</td>
                                    <td>25/10/2025</td>
                                    <td>26/10/2025</td>
                                    <td>1532</td>
                                    <td class="text-center">8</td>
                                    <td><span class="badge badge-success-soft">Đã xuất bản</span></td>

                                    <td class="text-center">
                                        <div class="box-btn">
                                            <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                            <button class="action-btn action-edit"><i
                                                    class="bi bi-pencil-square"></i></button>
                                            <button class="action-btn action-delete"><i
                                                    class="bi bi-trash"></i></button>
                                        </div>
                                    </td>

                                </tr>

                                <tr>
                                    <td>2</td>
                                    <td><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL2sCsS4Fp8xzLyHlES-RlK7pLhWB19EtCRw&s"
                                            class="product-img" alt="S24"></td>
                                    <td>Công nghệ AI mới trên robot</td>
                                    <td>Nguyễn Văn A</td>
                                    <td>Công nghệ mới</td>
                                    <td>25/10/2025</td>
                                    <td>26/10/2025</td>
                                    <td>1532</td>
                                    <td class="text-center">8</td>
                                    <td><span class="badge badge-warning-soft">Chờ xử lý</span></td>

                                    <td class="text-center">
                                        <div class="box-btn">
                                            <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                            <button class="action-btn action-edit"><i
                                                    class="bi bi-pencil-square"></i></button>
                                            <button class="action-btn action-delete"><i
                                                    class="bi bi-trash"></i></button>
                                        </div>
                                    </td>


                                <tr>
                                    <td>3</td>
                                    <td><img src="https://bizweb.dktcdn.net/100/021/944/products/huawei-watch-fit-3-den-techwearvn.jpg?v=1747740005877"
                                            class="product-img" alt="Watch"></td>
                                    <td>Công nghệ AI mới trên robot</td>
                                    <td>Nguyễn Văn A</td>
                                    <td>Công nghệ mới</td>
                                    <td>25/10/2025</td>
                                    <td>26/10/2025</td>
                                    <td>1532</td>
                                    <td class="text-center">8</td>
                                    <td><span class="badge badge-danger-soft">Đã gỡ</span></td>

                                    <td class="text-center">
                                        <div class="box-btn">
                                            <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                            <button class="action-btn action-edit"><i
                                                    class="bi bi-pencil-square"></i></button>
                                            <button class="action-btn action-delete"><i
                                                    class="bi bi-trash"></i></button>
                                        </div>
                                    </td>

                                </tr>



                            </tbody>
                        </table>

                        <!-- Pagination -->


                    </div>
                </div>
            </section>

            <!-- Pagination -->
            <div class="d-flex justify-content-end mt-3">
                <nav>
                    <ul class="pagination custom-pagination">
                        <li class="page-item disabled"><a class="page-link">Trước</a></li>
                        <li class="page-item active"><a class="page-link">1</a></li>
                        <li class="page-item"><a class="page-link">2</a></li>
                        <li class="page-item"><a class="page-link">3</a></li>
                        <li class="page-item"><a class="page-link">Sau</a></li>
                    </ul>
                </nav>
            </div>

        </main>

    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>

</html>
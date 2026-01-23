<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechX Admin | Product Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
        rel="stylesheet">
    <link rel="stylesheet" href="../assets/admin-css/style.css">

</head>

<body>
    <!-- Sidebar -->
    <div class="admin-container">

        
        <!-- SIDEBAR -->
        <aside class="sidebar">
            <h2 class="logo"><i class="bi bi-cpu me-2"></i>TechX Admin</h2>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp"><i class="bi bi-speedometer2"></i> Dashboard</a></li>
                    <li><a href="admin-products.html" class="active"><i class="bi bi-box"></i> Sản phẩm</a></li>
                    <li><a href="admin-categories.jsp"><i class="bi bi-tags"></i> Danh mục</a></li>
                    <li><a href="admin-orders.jsp"><i class="bi bi-cart"></i> Đơn hàng</a></li>
                    <li><a href="admin-payment.jsp"><i class="bi bi-credit-card"></i> Thanh toán</a></li>
                    <li><a href="admin-users.jsp"><i class="bi bi-people"></i> Người dùng</a></li>
                    <li><a href="admin-blog.jsp"><i class="bi bi-journal-text"></i> Blog</a></li>
                    <li><a href="admin-banners.jsp"><i class="bi bi-image"></i> Banner</a></li>
                    <li><a href="admin-login.jsp"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">

            <!-- HEADER -->
            <header class="header d-flex justify-content-between align-items-center">
                <h3 class="fw-bold m-0"><i class="bi-box"></i> Danh sách sản phẩm</h3>
                <div class="actions d-flex align-items-center gap-2">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        <i class="bi bi-plus-lg"></i> Thêm sản phẩm
                    </button>
                </div>
            </header>



            <!-- Search Bar -->
            <div class="input-group mb-4">
                <input type="text" class="form-control" id="searchInput" placeholder="Tìm sản phẩm theo tên...">
                <button class="btn  btn-primary"><i class="bi bi-search"></i></button>
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
                        <button class="btn btn-primary"><i class="bi bi-funnel"></i> Lọc</button>
                    </div>
                </div>
            </section>

            <!-- Product Table -->
            <section class="blog-table mt-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <table class="table table-hover align-middle">
                            <thead class=" table-light">
                                <tr>
                                    <th>#</th>
                                    <th>Ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Danh mục</th>
                                    <th>Giá</th>
                                    <th>Tồn kho</th>
                                    <th>Trạng thái</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody id="productTable">
                                <tr>
                                    <td>1</td>
                                    <td><img src="https://mac24h.vn/images/detailed/93/Macbook_Pro_M3_2023_Mac24h.png"
                                            class="product-img" alt="MacBook"></td>
                                    <td>MacBook Pro M3 2023</td>
                                    <td>Laptop</td>
                                    <td>₫48,990,000</td>
                                    <td>15</td>
                                    <td><span class="badge badge-success-soft">Còn hàng</span></td>
                                    <td class="">
                                        <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                        <button class="action-btn action-edit"><i
                                                class="bi bi-pencil-square"></i></button>
                                        <button class="action-btn action-delete"><i class="bi bi-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRL2sCsS4Fp8xzLyHlES-RlK7pLhWB19EtCRw&s"
                                            class="product-img" alt="S24"></td>
                                    <td>Samsung Galaxy S24 Ultra</td>
                                    <td>Điện thoại</td>
                                    <td>₫32,990,000</td>
                                    <td>20</td>
                                    <td><span class="badge badge-success-soft">Còn hàng</span></td>
                                    <td class="">
                                        <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                        <button class="action-btn action-edit"><i
                                                class="bi bi-pencil-square"></i></button>
                                        <button class="action-btn action-delete"><i class="bi bi-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td><img src="https://bizweb.dktcdn.net/100/021/944/products/huawei-watch-fit-3-den-techwearvn.jpg?v=1747740005877"
                                            class="product-img" alt="Watch"></td>
                                    <td>Huawei Watch Fit 3</td>
                                    <td>Đồng hồ</td>
                                    <td>₫3,990,000</td>
                                    <td>45</td>
                                    <td><span class="badge badge-success-soft">Còn hàng</span></td>
                                    <td class="">
                                        <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                        <button class="action-btn action-edit"><i
                                                class="bi bi-pencil-square"></i></button>
                                        <button class="action-btn action-delete"><i class="bi bi-trash"></i></button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td><img src="https://bizweb.dktcdn.net/100/021/944/products/huawei-watch-fit-3-den-techwearvn.jpg?v=1747740005877"
                                            class="product-img" alt="Watch"></td>
                                    <td>Huawei Watch Fit 3</td>
                                    <td>Đồng hồ</td>
                                    <td>₫3,990,000</td>
                                    <td>0</td>
                                    <td><span class="badge badge-danger-soft">Hết hàng</span></td>
                                    <td class="">
                                        <button class="action-btn action-view"><i class="bi bi-eye"></i></button>
                                        <button class="action-btn action-edit"><i
                                                class="bi bi-pencil-square"></i></button>
                                        <button class="action-btn action-delete"><i class="bi bi-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

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



            <footer class="text-center py-3 mt-4 border-top text-muted">
                © 2025 TechX Admin Panel
            </footer>
        </main>
    </div>

    <!-- Modal Add Product -->
    <div class="modal fade" id="addProductModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title">Thêm sản phẩm mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Tên sản phẩm</label>
                                <input type="text" class="form-control" placeholder="Nhập tên sản phẩm">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Danh mục</label>
                                <select class="form-select">
                                    <option>Điện thoại</option>
                                    <option>Laptop</option>
                                    <option>Phụ kiện</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Giá (₫)</label>
                                <input type="number" class="form-control" placeholder="Nhập giá">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Số lượng tồn kho</label>
                                <input type="number" class="form-control" placeholder="Nhập số lượng">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Ảnh sản phẩm (URL)</label>
                                <input type="text" class="form-control" placeholder="Dán link hình ảnh sản phẩm">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Mô tả</label>
                                <textarea class="form-control" rows="3"
                                    placeholder="Mô tả chi tiết sản phẩm..."></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button class="btn btn-primary">Lưu sản phẩm</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle Sidebar
        $("#menu-toggle").click(() => $("#wrapper").toggleClass("toggled"));

        // Search function
        $("#searchInput").on("keyup", function () {
            const value = $(this).val().toLowerCase();
            $("#productTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    </script>
</body>

</html>
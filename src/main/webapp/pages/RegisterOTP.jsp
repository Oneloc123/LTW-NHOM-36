<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Xác nhận OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card p-4 shadow">
                <h4 class="text-center mb-3">Xác nhận OTP đăng ký</h4>

                <form method="post" action="${pageContext.request.contextPath}/register-otp">
                    <input type="text" name="otp" class="form-control text-center mb-3"
                           placeholder="Nhập 6 số OTP" required>

                    <button class="btn btn-primary w-100">Xác nhận</button>
                </form>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger mt-3 text-center">${error}</div>
                </c:if>
            </div>
        </div>
    </div>
</div>

</body>
</html>

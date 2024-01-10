<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Trang chủ Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/changes.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>

<body>
    <c:if test="${empty sessionScope.usertype or sessionScope.usertype ne 'admin' or empty sessionScope.username or empty sessionScope.password}">
        <c:redirect url="login.jsp?message=Truy cập bị từ chối, đăng nhập với tư cách quản trị viên!!" />
    </c:if>

    <jsp:include page="headerAdmin.jsp" />

    <style>
        .icon {
            font-size: 24px;
            margin-right: 8px;
        }
    </style>

    <form action="./ProductServlet" method="post">
        <section class="section-content padding-y">
            <div class="container">
                <div class="card bg-light">
                    <div class="card-body p-5 text-center">
                        <h1 class="display-5 mb-5" style="font-size: 2.5em; margin-bottom: 90px; color: #333; text-align: center; text-transform: uppercase; font-weight: bold; font-family: 'Helvetica Neue', sans-serif; letter-spacing: 2px; text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.2);">QUẢN LÝ SHOP ĐIỆN TỬ</h1>
                        
                        <style>
    .card {
        border: 1px solid #ddd;
        border-radius: 10px;
        margin: 10px;
        padding: 20px; /* Add padding for content */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add box shadow for a subtle lift */
        background-color: #fff; /* Optional: Set a background color */
    }

    .card span {
        color: #333; /* Set font color */
        display: block; /* Add spacing between icon and text */
        margin-top: 10px; /* Adjust top margin for better spacing */
    }

    .card p {
        color: #555; /* Set font color */
        margin: 0; /* Remove default margins */
    }
</style>

<div class="row">
    <div class="col-md-4">
        <div class="card">
            <div class="card-body text-center">
                <span class="glyphicon glyphicon-user" style="font-size: 2em;"></span>
                <span style="font-size: 3em;">Tổng ${totalUsers} người dùng</span>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card">
            <div class="card-body text-center">
                <span class="glyphicon glyphicon-list-alt" style="font-size: 2em;"></span>
                <p style="font-size: 3em;">Tổng ${totalProducts} sản phẩm</p>
            </div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card">
            <div class="card-body text-center">
                <span class="glyphicon glyphicon-print" style="font-size: 2em;"></span>
                <span style="font-size: 3em;">Tổng ${totalOrders} đơn hàng</span>
            </div>
        </div>
    </div>
</div>
                        
                    </div>
                </div> <!-- card.// -->
            </div> <!-- container.// -->
        </section> <!-- section-content.// -->

        <!-- ... Other form elements ... -->

    </form>

    <jsp:include page="footer.jsp" />
</body>

</html>

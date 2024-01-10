<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Trang chủ Admin</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body style="background-color: #E6F9E6;">
<div class="container-fluid text-center" style="margin-top: 45px; background-color: #33cc33; color: white; padding-top: 65px;">
</div>
	<!--Company Header Starting  -->	
	<style>
    .form-inline {
        display: flex;
        justify-content: flex-end; /* Align items to the right */
        align-items: center;
    }

    .input-group {
        max-width: 400px; /* Adjust the maximum width as needed */
        display: flex;
    }

    .form-control {
        width: calc(100% - 40px); /* Adjust the width of the input field */
        border-radius: 5px 0 0 5px;
    }

    .input-group-btn {
        width: 40px; /* Adjust the width of the button container */
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .btn-danger {
        border-radius: 0 5px 5px 0;
        margin-right: 50px;
    }
</style>
	
	
	
	
	<!-- Company Header Ending -->

	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	if (userType == null) { //LOGGED OUT
	%>

	<%
	} else if ("customer".equalsIgnoreCase(userType)) { //CUSTOMER HEADER

	int notf = new CartServiceImpl().getCartCount((String) session.getAttribute("username"));
	%>
	
	<%
	} else { //ADMIN HEADER
	%>
	<style>
    .navbar-nav li a {
        font-size: 16px; /* Adjust the font size as needed */
        margin-right: 10px; /* Adjust the right margin between links */
        letter-spacing: -1px; /* Adjust the letter-spacing as needed */
    }
</style>
	
</style>
	
	<nav class="navbar navbar-default navbar-fixed-top">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                                    class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="./ProductServlet"><span
                                    class="glyphicon glyphicon-home">&nbsp;</span>Trang chủ ADMIN</a>

                        </div>
                        <div class="collapse navbar-collapse" id="myNavbar">
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="adminStock.jsp"><span
                                            class="glyphicon glyphicon-list-alt">&nbsp;</span>Quản lý
                                        sản phẩm</a></li>
                                <li class="nav-item">
                                    <a class="nav-link" href="managerUser.jsp"><span
                                            class="glyphicon glyphicon-user">&nbsp;</span>
                                        <i class="bi bi-people"></i> Quản lý người dùng

                                    </a>
                                </li>
<li class="nav-item">
                                    <a class="nav-link" href="./Revenue"><span
                                            class="	glyphicon glyphicon-signal">&nbsp;</span>
                                        <i class="bi bi-people"></i> Thống kê

                                    </a>
                                </li>
                                <li><a href="shippedItems.jsp"><span class="glyphicon glyphicon-check">&nbsp;</span>Đã
                                        vận chuyển</a></li>

                                <li><a href="unshippedItems.jsp"><span
                                            class="  glyphicon glyphicon-print">&nbsp;</span>Đơn đặt hàng</a></li>
                                <!-- <li><a href=""> <span class="glyphicon glyphicon-shopping-cart"></span>&nbsp;Cart</a></li> -->
                                <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"><span
                                            class="  glyphicon glyphicon-list">&nbsp;</span>Cập nhật
                                         <span class="caret"></span>
                                    </a>

                                    <ul class="dropdown-menu">
                                        <li><a href="addProduct.jsp">Thêm sản phẩm</a></li>
                                        <li><a href="removeProduct.jsp">Xóa sản phẩm</a></li>
                                        <li><a href="updateProductById.jsp">Cập nhật sản phẩm</a></li>
                                    </ul>
                                </li>
                                <li><a href="./LogoutSrv"><span class="glyphicon glyphicon-log-out">&nbsp;</span>Đăng
                                        xuất</a></li>

                            </ul>
                        </div>
                    </div>
                </nav>
	<%
	}
	%>
	<!-- End of Navigation Bar -->
</body>
</html>
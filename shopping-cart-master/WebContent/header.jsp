<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ page import="com.shashi.service.impl.*, com.shashi.service.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Tiêu đề đăng xuất</title>
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
	<!--Company Header Starting  -->
	<div class="container-fluid text-center" style="margin-top: 45px; background-color: #33cc33; color: white; padding-top: 25px;">
    <form class="form-inline justify-content-center align-items-center" action="index.jsp" method="get">
        <div class="input-group">
            <input type="text" class="form-control" name="search" placeholder="Tên sản phẩm" required>
            <div class="input-group-btn">
                <input type="submit" class="btn btn-danger" value="Tìm kiếm" />
            </div>
        </div>
    </form>
    <p style="color: blue; font-weight: bold; margin-top: 15px; margin-bottom: 15px;" id="message"></p>
</div>
	
	
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

	<!-- Starting Navigation Bar -->
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>Shopping Center</a>
			</div>
			
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					
					<li><a href="index.jsp">SẢN PHẨM</a></li>
					<li><a href="login.jsp">ĐĂNG NHẬP</a></li>
					<li><a href="register.jsp">ĐĂNG KÝ</a></li>
					
				</ul>
			</div>
		</div>
	</nav>
	<%
	} else if ("customer".equalsIgnoreCase(userType)) { //CUSTOMER HEADER

	int notf = new CartServiceImpl().getCartCount((String) session.getAttribute("username"));
	%>
	<nav class="navbar navbar-default navbar-fixed-top">

		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="userHome.jsp"><span
					class="glyphicon glyphicon-home">&nbsp;</span>SHOPPING CENTER</a>
			</div>


			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="userHome.jsp"><span
							class="">SẢN PHẨM</span></a></li>
					
					<%
					if (notf == 0) {
					%>
					<li><a href="cartDetails.jsp"> <span
							class="glyphicon glyphicon-shopping-cart"></span>GIỎ HÀNG
					</a></li>

					<%
					} else {
					%>
					<li><a href="cartDetails.jsp"
						style="margin: 0px; padding: 0px;" id="mycart"><i
							data-count="<%=notf%>"
							class="fa fa-shopping-cart fa-3x icon-white badge"
							style="background-color: #333; margin: 0px; padding: 0px; padding-bottom: 0px; padding-top: 5px;font-size:14px">
						</i></a></li>
					<%
					} 
					%>
					<li><a href="orderDetails.jsp">ĐƠN ĐẶT HÀNG</a></li>
					<li><a href="userProfile.jsp">HỒ SƠ</a></li>
					<li><a href="./LogoutSrv">ĐĂNG XUẤT</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<%
	} else { //ADMIN HEADER
	%>
	
	<%
	}
	%>
	<!-- End of Navigation Bar -->
</body>
</html>
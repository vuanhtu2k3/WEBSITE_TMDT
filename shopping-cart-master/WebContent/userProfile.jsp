<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Thông tin người dùng</title>
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

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Đăng nhập lại!!");
	}

	UserService dao = new UserServiceImpl();
	UserBean user = dao.getUserDetails(userName, password);
	if (user == null)
		user = new UserBean("Test User", "98765498765L", "test@gmail.com", "Bắc Từ Liêm, Hà Nội", 87659, "lksdjf");
	%>



	<jsp:include page="header.jsp" />

	<div class="container bg-secondary">
		<div class="row">
			<div class="col">
				<nav aria-label="breadcrumb" class="bg-light rounded-3 p-3 mb-4">
					<ol class="breadcrumb mb-0">
						<li class="breadcrumb-item"><a href="index.jsp">Trang chủ </a></li>
						<li class="breadcrumb-item"><a href="profile.jsp">Thông tin người dùng</a></li>
					</ol>
				</nav>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-4">
				<div class="card mb-4">
					<div class="card-body text-center">
						<img src="images/profile.jpg" class="rounded-circle img-fluid"
							style="width: 150px;">
						<h5 class="my-3">
							Xin chào
							<%=user.getName()%>
						
						</h5>
						<!-- <p class="text-muted mb-1">Full Stack Developer</p>
						<p class="text-muted mb-4">Bay Area, San Francisco, CA</p> -->
					</div>
				</div>
				<div class="card mb-4 mb-lg-0">
					<div class="card-body p-0">
						<ul class="list-group list-group-flush rounded-3">

							<li
								class="text-center list-group-item d-flex justify-content-between align-items-center p-3">
								<h1>Thông tin của tôi</h1>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-lg-8">
				<div class="card mb-4">
					<div class="card-body">
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Tên đầy đủ</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getName()%></p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Email</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getEmail()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">SDT</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getMobile()%>
								</p>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-sm-3">
								<p class="mb-0">Địa chỉ</p>
							</div>
							<div class="col-sm-9">
								<p class="text-muted mb-0"><%=user.getAddress()%>
								</p>
							</div>
						</div>
						<hr>
						
					</div>
				</div>
			</div>
		</div>
	</div>

	<br>
	<br>
	<br>

	<%@ include file="footer.jsp"%>

</body>
</html>
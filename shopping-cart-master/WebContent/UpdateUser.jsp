<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Cập nhật người dùng </title>
<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</head>
<body style="background-color: #E6F9E6;">
	<%
	/* Checking the user credentials */
	String utype = (String) session.getAttribute("usertype");
	String uname = (String) session.getAttribute("username");
	String pwd = (String) session.getAttribute("password");
	String email = request.getParameter("email");
	UserBean listUser = new UserServiceImpl().getUserDetaill(email);

	if (utype == null || !utype.equals("admin")) {
		response.sendRedirect("login.jsp?message=Truy cập bị từ chối, đăng nhập với tư cách quản trị viên!!");
		return;
	} else if (uname == null || pwd == null) {
		response.sendRedirect("login.jsp?message=Phiên đã hết hạn, hãy đăng nhập lại!!");
		return;
	}
	%>

	<jsp:include page="headerAdmin.jsp" />

	<%
	String message = request.getParameter("message");
	%>
	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			<form action="./UpdateUsersrv" method="post"
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						
							
						<h2 style="color: green;">Mẫu cập nhật thông tin người dùng</h2>
					</div>

					<%
					if (message != null) {
					%>
					<p style="color: blue;">
						<%=message%>
					</p>
					<%
					}
					%>
				</div>
				<div class="row">
    <% if (listUser != null) { %>
        <input type="hidden" name="email" class="form-control"
               value="<%=listUser.getEmail()%>" id="last_name" required>
    <% } %>
</div>	
				
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">Tên người dùng</label> <input type="text"
							placeholder="Nhập tên người dùng" name="name" class="form-control"
							value="<%=listUser.getName()%>" id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						
						<label for="producttype">Số điện thoại</label> <input type="text"
							placeholder="Nhập số điện thoại" name="mobile" class="form-control"
							value="<%=listUser.getMobile()%>" id="last_name" required>
							
					</div>
				</div>
				<div class="form-group">
					<label for="producttype">Địa chỉ</label> <input type="text"
							placeholder="Nhập địa chỉ" name="address" class="form-control"
							value="<%=listUser.getAddress()%>" id="last_name" required>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">PinCode</label> <input type="text"
							value="<%=listUser.getPinCode()%>"
							placeholder="Nhập pincode:" name="pincode" class="form-control"
							id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="last_name">Mật khẩu</label> <input type="text"
							value="<%=listUser.getPassword()%>"
							placeholder="Nhập mật khẩu" class="form-control"
							id="last_name" name="password" required>
					</div>
				</div>
				<div class="row text-center">
					<div class="col-md-4" style="margin-bottom: 2px;">
						<button formaction="adminViewProduct.jsp" class="btn btn-danger">Hủy</button>
					</div>
					<div class="col-md-4">
						<button type="submit" class="btn btn-success">Cập nhật sản phẩm</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
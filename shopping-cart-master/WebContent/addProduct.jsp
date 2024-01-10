<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Thêm sản phẩm </title>
<meta name="viewport" content="width=device-width,initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/changes.css">
</head>
<body style="background-color: #E6F9E6;">
	<%
	/* Checking the user credentials */
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("admin")) {

		response.sendRedirect("login.jsp?message=Truy cập bị từ chối, đăng nhập với tư cách quản trị viên!!");

	}

	else if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Phiên đã hết hạn, hãy đăng nhập lại!!");

	}
	%>

	<jsp:include page="headerAdmin.jsp" />

	<%
	String message = request.getParameter("message");
	%>
	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			<form action="./AddProductSrv" method="post"
				enctype="multipart/form-data" class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #FFE5CC; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<h2 style="color: green;">Mẫu bổ sung sản phẩm</h2>
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
				<div></div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">Tên sản phẩm</label> <input type="text"
							placeholder="Nhập tên sản phẩm" name="name" class="form-control"
							id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="producttype">Loại sản phẩm</label> <select name="type"
							id="producttype" class="form-control" required>
							<option value="mobile">Điện thoại</option>
							<option value="tv">TV</option>
							<option value="camera">Máy ảnh</option>
							<option value="laptop">LAPTOP</option>
							<option value="tablet">Máy tính bảng</option>
							<option value="speaker">Loa</option>
							<option value="other">Một số thiết bị khác</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="last_name">Mô tả sản phẩm</label>
					<textarea name="info" class="form-control" id="last_name" required></textarea>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">Đơn giá: </label> <input type="number"
							placeholder="Nhập đơn giá" name="price" class="form-control"
							id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="last_name">Số lượng </label> <input type="number"
							placeholder="Nhập số lượng" name="quantity"
							class="form-control" id="last_name" required>
					</div>
				</div>
				<div>
					<div class="col-md-12 form-group">
						<label for="last_name">Ảnh sản phẩm</label> <input type="file"
							placeholder="Select Image" name="image" class="form-control"
							id="last_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 text-center" style="margin-bottom: 2px;">
						<button type="reset" class="btn btn-danger">Cài lại</button>
					</div>
					<div class="col-md-6 text-center">
						<button type="submit" class="btn btn-success">Thêm sản phẩm</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
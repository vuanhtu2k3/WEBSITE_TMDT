<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Đăng nhập</title>
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

	<%@ include file="header.jsp"%>

	<%
	String message = request.getParameter("message");
	%>
	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			<form action="./LoginSrv" method="post"
				class="col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2"
				style="border: 2px solid black; border-radius: 10px; background-color: white; padding: 10px; margin-top:20px">
				<div style="font-weight: bold;" class="text-center">
				
    
                     <style>
    h2 {
        color: green;
        text-align: center;
        margin-top: 20px;
        font-size: 24px;
        font-family: 'Your Chosen Font', sans-serif; /* Replace 'Your Chosen Font' with the actual font name */
        font-weight: bold; /* Adjust font weight as needed */
        letter-spacing: 2px; /* Adjust letter spacing as needed */
        text-transform: uppercase; /* Convert text to uppercase */
        text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5); /* Add a subtle text shadow */
    }
    
</style>

<h2>Đăng nhập</h2>
                     
					
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
					<div class="col-md-12 form-group">
						<label for="last_name">Tên tài khoản </label> <input type="email"
							placeholder="Nhập tên tài khoản" name="username" class="form-control"
							id="last_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="last_name">Mật khẩu</label> <input type="password"
							placeholder="Nhập mật khẩu" name="password" class="form-control"
							id="last_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="userrole">Đăng nhập với tư cách</label> <select name="usertype"
							id="userrole" class="form-control" required>
							<option value="customer" selected>Khách hàng</option>
							<option value="admin">ADMIN</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 text-center">
						<button type="submit" class="btn btn-success">Đăng nhập</button>
					</div>
				</div>
			</form>

		</div>
	</div>

	<%@ include file="footer.jsp"%>

</body>
</html>
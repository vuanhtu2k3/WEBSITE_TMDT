<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Quản lý người dùng</title>
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
	String userType = (String) session.getAttribute("usertype");
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userType == null || !userType.equals("admin")) {

		response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");

	}

	else if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");

	}
	%>

	<jsp:include page="headerAdmin.jsp" />

	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Tất cả người dùng</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #2c6c4b; color: white; font-size: 18px;">
					<tr>
						<th>Tên người dùng</th>						
						<th>Email</th>
						<th>Số điện thoại</th>
						<th>Đia chỉ</th>
						<th> Mã Code </th>
						<th>Mật khẩu </th>
						<th colspan="2" style="text-align: center">Hành động</th>
					</tr>
				</thead>
				<tbody style="background-color: white; font-size: 16px;">



					<%
					
					UserServiceImpl userDao = new UserServiceImpl();
				    List<UserBean> listUser = new ArrayList<UserBean>();
				    
				    listUser = userDao.getAllUser();
				    for(UserBean user: listUser){
				    	
				    										
					%>

					<tr>					
						<%
						String name = user.getName();				
						name = name.substring(0, Math.min(name.length(), 25)) + "..";
						%>
						<td><%=name%></td>
						<td><%=user.getEmail().toUpperCase()%></td>
						<td><%=String.valueOf(user.getMobile())%></td>
						<td><%=user.getAddress()%></td>
						<td><%= user.getPinCode() %></td>
					<td>
  <span class="hidden-password" onclick="toggleVisibility(<%= user.getPinCode() %>);">&#8226;&#8226;&#8226;&#8226;&#8226;</span>

  <script>
    function toggleVisibility(pinCode) {
      var passwordSpan = document.querySelector('.hidden-password');

      if (passwordSpan.innerHTML === '&#8226;&#8226;&#8226;&#8226;&#8226;') {
        passwordSpan.innerHTML = pinCode;
      } else {
        passwordSpan.innerHTML = '&#8226;&#8226;&#8226;&#8226;&#8226;';
      }
    }
  </script>

  <style>
    .hidden-password {
      cursor: pointer; /* Biểu tượng chuột để chỉ ra sự tương tác */
    }
  </style>
</td>
					
						<td>
							<form method="post">
							
								<button type="submit"
								
									formaction="UpdateUser.jsp?email=<%=user.getEmail()%>"
									class="btn btn-primary">Cập nhật</button>
							</form>
						</td>
						<td>
							<form method="post">
								<button type="submit"
									formaction="./RemoveUsersrv?email=<%=user.getEmail()  %>"
									class="btn btn-danger">Xóa</button>
							</form>
						</td>

					</tr>

					<%
					}
					%>
					<%
					if (listUser.size() == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="7" style="text-align: center;">Không có người dùng nào</td>

					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Quản lý sản phẩm</title>
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

		response.sendRedirect("login.jsp?message=Truy cập bị từ chối, đăng nhập với tư cách quản trị viên!!");

	}

	else if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Phiên đã hết hạn, hãy đăng nhập lại!!");

	}
	%>

	<jsp:include page="headerAdmin.jsp" />

	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Tất cả sản phẩm</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #2c6c4b; color: white; font-size: 18px;">
					<tr>
						<th>Ảnh</th>
						<th>Mã sản phẩm</th>
						<th>Tên sản phẩm</th>
						<th>Thể loại</th>
						<th>Giá</th>
						<th>Số lượng bán </th>
						<th>Số lượng </th>
						<th colspan="2" style="text-align: center">Hành động</th>
					</tr>
				</thead>
				<tbody style="background-color: white; font-size: 16px;">



					<%
					ProductServiceImpl productDao = new ProductServiceImpl();
					List<ProductBean> products = new ArrayList<ProductBean>();
					products = productDao.getAllProducts();
					for (ProductBean product : products) {
					%>

					<tr>
						<td><img src="./ShowImage?pid=<%=product.getProdId()%>"
							style="width: 50px; height: 50px;"></td>
						<td><a
							href="./updateProduct.jsp?prodid=<%=product.getProdId()%>"><%=product.getProdId()%></a></td>
						<%
						String name = product.getProdName();
						name = name.substring(0, Math.min(name.length(), 25)) + "..";
						%>
						<td><%=name%></td>
						<td><%=product.getProdType().toUpperCase()%></td>
						<td><%=product.getProdPrice()%></td>
						<td><%=new OrderServiceImpl().countSoldItem(product.getProdId())%></td>
						<td><%=product.getProdQuantity()%></td>
						<td>
							<form method="post">
								<button type="submit"
									formaction="updateProduct.jsp?prodid=<%=product.getProdId()%>"
									class="btn btn-primary">Cập nhật</button>
							</form>
						</td>
						<td>
							<form method="post">
								<button type="submit"
									formaction="./RemoveProductSrv?prodid=<%=product.getProdId()%>"
									class="btn btn-danger">Xóa</button>
							</form>
						</td>

					</tr>

					<%
					}
					%>
					<%
					if (products.size() == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="7" style="text-align: center;">Không có sản phẩm nào</td>

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
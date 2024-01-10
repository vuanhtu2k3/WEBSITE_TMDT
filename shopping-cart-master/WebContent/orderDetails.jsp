<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Chi tiết đặt hàng</title>
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
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Phiên đã hết hạn, hãy đăng nhập lại!!");

	}

	OrderService dao = new OrderServiceImpl();
	List<OrderDetails> orders = dao.getAllOrderDetails(userName);
	%>



<jsp:include page="headerAdmin.jsp" />

	<!-- <script>document.getElementById('mycart').innerHTML='<i data-count="20" class="fa fa-shopping-cart fa-3x icon-white badge" style="background-color:#333;margin:0px;padding:0px; margin-top:5px;"></i>'</script>
 -->
	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Chi tiết đặt hàng</div>
	<!-- Start of Product Items List -->
	<div class="container">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: black; color: white; font-size: 14px; font-weight: bold;">
					<tr>
						<th>Ảnh</th>
						<th>Tên sản phẩm</th>
						<th>Thứ tự</th>
						<th>Số lượng</th>
						<th>Giá </th>
						<th>Thời gian</th>
						<th>Trạng thái</th>
					</tr>
				</thead>
				<tbody
					style="background-color: white; font-size: 15px; font-weight: bold;">
					<%
					for (OrderDetails order : orders) {
					%>

					<tr>
						<td><img src="./ShowImage?pid=<%=order.getProductId()%>"
							style="width: 50px; height: 50px;"></td>
						<td><%=order.getProdName()%></td>
						<td><%=order.getOrderId()%></td>
						<td><%=order.getQty()%></td>
						<td><%=order.getAmount()%></td>
						<td><%=order.getTime()%></td>
						<td class="text-success"><%=order.getShipped() == 0 ? "Đã đặt hàng" : "Đã giao hàng"%></td>
					</tr>

					<%
					}
					%>

				</tbody>
			</table>
		</div>
	</div>
	<!-- ENd of Product Items List -->


	<%@ include file="footer.jsp"%>
</body>
</html>
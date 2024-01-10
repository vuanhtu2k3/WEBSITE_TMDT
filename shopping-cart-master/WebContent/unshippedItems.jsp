<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.beans.*,com.shashi.service.*,java.util.*"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trang Admin </title>
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

		response.sendRedirect("loginFirst.jsp");

	}

	if (userName == null || password == null) {

		response.sendRedirect("loginFirst.jsp");
	}
	%>

<jsp:include page="headerAdmin.jsp" />

	<div class="text-center"
		style="color: green; font-size: 24px; font-weight: bold;">Chưa vận chuyển
		</div>
	<div class="container-fluid">
		<div class="table-responsive ">
			<table class="table table-hover table-sm">
				<thead
					style="background-color: #700fb7; color: white; font-size: 16px;">
					<tr>
						<th>ID giao dịch</th>
						<th>Mã sản phẩm</th>
						<th>Id email người dùng</th>
						<th>Địa chỉ</th>
						<th>Số lượng</th>
						<th>Trạng thái</th>
						<th>Hoạt động</th>
					</tr>
				</thead>
				<tbody style="background-color: white;">

					<%
					OrderServiceImpl orderdao = new OrderServiceImpl();

					List<OrderBean> orders = new ArrayList<OrderBean>();
					orders = orderdao.getAllOrders();
					int count = 0;
					for (OrderBean order : orders) {
						String transId = order.getTransactionId();
						String prodId = order.getProductId();
						int quantity = order.getQuantity();
						int shipped = order.getShipped();
						String userId = new TransServiceImpl().getUserId(transId);
						String userAddr = new UserServiceImpl().getUserAddr(userId);
						if (shipped == 0) {
							count++;
					%>

					<tr>
						<td><%=transId%></td>
						<td><a href="./updateProduct.jsp?prodid=<%=prodId%>"><%=prodId%></a></td>
						<td><%=userId%></td>
						<td><%=userAddr%></td>
						<td><%=quantity%></td>
						<td>SẴN SÀNG CHUYỂN HÀNG</td>
						<td><a
							href="ShipmentServlet?orderid=<%=order.getTransactionId()%>&amount=<%=order.getAmount()%>&userid=<%=userId%>&prodid=<%=order.getProductId()%>"
							class="btn btn-success">Vận chuyển ngay bây giờ</a></td>
					</tr>

					<%
					}
					}
					%>
					<%
					if (count == 0) {
					%>
					<tr style="background-color: grey; color: white;">
						<td colspan="7" style="text-align: center;">Không có mặt hàng nào</td>

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
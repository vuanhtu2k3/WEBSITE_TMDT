<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Thiết bị điện tử</title>
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
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Phiên đã hết hạn, hãy đăng nhập lại!!");
	}

	ProductServiceImpl prodDao = new ProductServiceImpl();
	List<ProductBean> products = new ArrayList<ProductBean>();

	String search = request.getParameter("search");
	String type = request.getParameter("type");
	String message = "Tất cả sản phẩm";
	if (search != null) {
		products = prodDao.searchAllProducts(search);
		message = " Kết quả cho '" + search + "'";
	} else if (type != null) {
		products = prodDao.getAllProductsByType(type);
		message = "Kết quả cho mục '" + type + "'";
	} else {
		products = prodDao.getAllProducts();
	}
	if (products.isEmpty()) {
		message = "Không tìm thấy mục nào cho tìm kiếm '" + (search != null ? search : type) + "'";
		products = prodDao.getAllProducts();
	}
	%>



	<jsp:include page="header.jsp" />

	
	<!-- <script>document.getElementById('mycart').innerHTML='<i data-count="20" class="fa fa-shopping-cart fa-3x icon-white badge" style="background-color:#333;margin:0px;padding:0px; margin-top:5px;"></i>'</script>
 -->
	<!-- Start of Product Items List -->
	<div class="container">
	<style>
    .imgditich {
        position: relative;
        width: 100%;
        height: 400px; /* Đặt chiều cao cố định (thay đổi theo ý muốn của bạn) */
        overflow: hidden;
        margin-bottom:50px;
        margin-top: 50px;
   
    }

    #img1 {
        width: 100%;
        height: 100%; /* Chiều cao 100% để giữ tỷ lệ khung hình */
        cursor: pointer;
       
    }
</style>
<div class="imgditich">
    <img id="img1" onclick="changeImage()" src="images/eaut21.jpg" alt="Ảnh 1">

    <script>
        var index = 1;
        var isPaused = false;

        function changeImage() {
            var imgs = ["images/eaut22.jpg", "images/eaut20.png"];
            
            if (!isPaused) {
                document.getElementById("img1").src = imgs[index];
                index++;
                if (index === imgs.length) {
                    index = 0;
                }
            }
        }

        setInterval(changeImage, 2200);

        var preloadedImages = [];
        for (var i = 0; i < imgs.length; i++) {
            preloadedImages[i] = new Image();
            preloadedImages[i].src = imgs[i];
        }

        function togglePause() {
            isPaused = !isPaused;
        }
    </script>
</div>
	
	<div class="text-center"
	
		style="color: black; font-size: 20px; font-weight: bold;padding: 20px;  text-transform: uppercase;
      margin: 10px;"><%=message%></div>
	<style>
.category-sidebar {
    width: 30%;
}

.product-content {
    width: 70%;
}

</style>
          <div class="row">
        <div class="col-md-3 category-sidebar">
    <div class="card bg-light mb-3">
        <div class="card-header bg-primary text-white text-uppercase">
            <i class="fa fa-list" style="padding-top: 10px; padding-right: 20px; padding-bottom: 10px; padding-left: 20px;"></i>
             Danh mục Sản phẩm
        </div>
        <div class="list-group category-list">
            <a href="index.jsp?type=mobile" class="list-group-item list-group-item-action category-item">Điện thoại</a>
            <a href="index.jsp?type=tv" class="list-group-item list-group-item-action category-item">TVs</a>
            <a href="index.jsp?type=laptop" class="list-group-item list-group-item-action category-item">Laptops</a>
            <a href="index.jsp?type=camera" class="list-group-item list-group-item-action category-item">Máy ảnh</a>
            <a href="index.jsp?type=speaker" class="list-group-item list-group-item-action category-item">Loa</a>
            <a href="index.jsp?type=tablet" class="list-group-item list-group-item-action category-item">Máy tính bảng</a>
        </div>
    
</div>
        </div>
         <div class="col-md-9 product-content">
		<div class="row text-center">

			<%
			for (ProductBean product : products) {
				int cartQty = new CartServiceImpl().getCartItemCount(userName, product.getProdId());
			%>
			<div class="col-sm-4" style='height: 350px;'>
				<div class="thumbnail">
					<img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product"
						style="height: 130px; max-width: 180px">
					<p class="productname"><%=product.getProdName()%>
					</p>
					<%
					String description = product.getProdInfo();
					description = description.substring(0, Math.min(description.length(), 100));
					%>
					<p class="productinfo"><%=description%>..
					</p>
					<p class="price">
						
					<%
  try {
   
    double productPrice = product.getProdPrice();


    long integerPrice = (long) productPrice;


    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

   
    String formattedPrice = currencyFormat.format(integerPrice);

   
    out.println(formattedPrice + " ");
  } catch (Exception e) {
   
    out.println("Error displaying price");
    e.printStackTrace();
  }
%>
					</p>
					<form method="post">
						<%
						if (cartQty == 0) {
						%>
						<button type="submit"
							formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							class="btn btn-success">Thêm vào giỏ hàng</button>
						&nbsp;&nbsp;&nbsp;
						<button type="submit"
							formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=1"
							class="btn btn-primary">Mua ngay</button>
						<%
						} else {
						%>
						
						<button type="submit"
							formaction="./AddtoCart?uid=<%=userName%>&pid=<%=product.getProdId()%>&pqty=0"
							class="btn btn-danger">Xóa  </button>
					
						<button type="submit" formaction="cartDetails.jsp"
							class="btn btn-success">Thanh toán</button>
						<%
						}
						%>
					</form>
					<br />
				</div>
			</div>

			<%
			}
			%>
</div>
		</div>
	</div>
	</div>
	<!-- ENd of Product Items List -->


	<%@ include file="footer.jsp"%>

</body>
</html>
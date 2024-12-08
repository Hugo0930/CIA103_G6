<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.prod.model.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Shop Homepage - Start Bootstrap Template</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="<%=request.getContextPath()%>/front-end/browsestore/css/styles.css"
	rel="stylesheet" />
</head>

<!-- 如果這網頁不是首頁，可以不用在這裡下  -->
<!-- ProdService prodSvc = new ProdService(); List -->
<!-- <ProdVO> list = prodSvc.getAll();  -->
<!-- req.setAttribute("list",list); -->

<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="#!">Start Bootstrap</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="#!">About</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">商品分類</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">全部商品</a></li>
							<li><hr class="dropdown-divider" /></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/prod/prod.do?action=get_by_type&prodTypeId=1">錄音相關</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/prod/prod.do?action=get_by_type&prodTypeId=2">周邊</a></li>
						</ul></li>
				</ul>
				<form class="d-flex">
					<button class="btn btn-outline-dark" type="submit">
						<i class="bi-cart-fill me-1"></i> Cart <span
							class="badge bg-dark text-white ms-1 rounded-pill">0</span>
					</button>
				</form>
			</div>
		</div>
	</nav>
	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">Shop in style</h1>
				<p class="lead fw-normal text-white-50 mb-0">With this shop
					hompeage template</p>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<div
				class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">


				<table id="example" class="display" style="width: 100%">
					<thead>
						<tr style="background-color: #CCCCFF">
							<th>圖片</th>
							<th>產品編號</th>
							<th>產品名稱</th>
							<th>產品價格</th>
							<th>數量</th>
							<th>刪除</th>

						</tr>
					</thead>

					</thead>
					<tbody>
						<c:forEach var="cartItem" items="${cartItems}">
    <tr>
        <!-- 產品圖片 -->
        <td><img
            src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${cartItem.prodId}"
            alt="Product Image" width="100px" height="100px"></td>
        <!-- 產品編號 -->
        <td>${cartItem.prodId}</td>
        <!-- 產品名稱 -->
        <td>${cartItem.prodName}</td> <!-- 這裡需要從prodList中獲取對應的名稱 -->
        <!-- 產品價格 -->
        <td>$${cartItem.prodPrice}</td> <!-- 顯示價格 -->
        <!-- 數量 -->
        <td>${cartItem.cartlistQty}</td>
        <!-- 刪除按鈕 -->
        <td>
            <form method="post"
                action="<%=request.getContextPath()%>/shopcart/shopcart.do">
                <input type="hidden" name="prodId" value="${cartItem.prodId}">
                <input type="hidden" name="action" value="remove_from_cart">
                <button type="submit" class="btn btn-danger">刪除</button>
            </form>
        </td>
    </tr>
</c:forEach>
					</tbody>
				</table>








			</div>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2023</p>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script
		src="<%=request.getContextPath()%>/front-end/browsestore/js/scripts.js"></script>
</body>
</html>

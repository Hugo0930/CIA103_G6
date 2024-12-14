<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>我的訂單明細 - VoiceBus</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link
	href="<%=request.getContextPath()%>/front-end/browsestore/css/styles.css"
	rel="stylesheet" />
<style>
td {
	vertical-align: middle;
}

.prod-img {
	width: 100px;
	height: 100px;
	object-fit: cover;
}

.review-content {
	max-width: 200px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
</head>

<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="#!">VoiceBus</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link"
						href="<%=request.getContextPath()%>/prod/prod.do?action=get_all">返回商城</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Header-->
	<header class="bg-dark py-5">
		<div class="container px-4 px-lg-5 my-5">
			<div class="text-center text-white">
				<h1 class="display-4 fw-bolder">我的訂單</h1>
				<p class="lead fw-normal text-white-50 mb-0">Order Details</p>
			</div>
		</div>
	</header>

	<!-- Section-->
	<!-- Section -->
	<section class="py-5">
		<div class="container px-4 px-lg-5 mt-5">
			<c:set var="currentOrderId" value="" />
			<c:forEach var="detail" items="${orderDetailsList}">
				<!-- 當是新的訂單編號時，創建新的表格 -->
				<c:if test="${currentOrderId ne detail.ordersId}">
					<c:if test="${not empty currentOrderId}">
						</tbody>
						</table>
		</div>
		</c:if>

		<div class="order-section mb-5">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<h4>訂單編號: ${detail.ordersId}</h4>
<!-- 				<a -->
<%-- 					href="<%=request.getContextPath()%>/orders/orders.do?action=get_order&orderId=${detail.ordersId}" --%>
<!-- 					class="btn btn-info"> 訂單詳情 </a> -->
			</div>
			<div class="table-responsive">
				<table class="table table-bordered text-center">
					<thead>
						<tr style="background-color: #CCCCFF;">
							<th>商品圖片</th>
							<th>商品編號</th>
							<th>商品名稱</th>
							<th>數量</th>
							<th>單價</th>
							<th>商品評價</th>
							<th>評價操作</th>
							<th>訂單操作</th>
							<!-- 新增欄位 -->
						</tr>
					</thead>
					<tbody>
						</c:if>

						<!-- 顯示訂單明細 -->
						<tr>
							<td><img
								src="<%=request.getContextPath()%>/prod/prod.do?action=get_pic&prodId=${detail.prodId}"
								alt="商品圖片" class="prod-img"></td>
							<td>${detail.prodId}</td>
							<td>${detail.prodName}</td>
							<td>${detail.ordersQty}</td>
							<td>$${detail.ordersUnitPrice}</td>
							<td>
								<div class="review-content">${empty detail.reportsContent ? '尚未評價' : detail.reportsContent}
								</div>
							</td>
							<td><c:choose>
									<c:when test="${empty detail.reportsContent}">
										<button type="button" class="btn btn-primary btn-sm"
											onclick="openReviewForm(${detail.ordersId}, ${detail.prodId})">
											填寫評價</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-secondary btn-sm"
											disabled>已評價</button>
									</c:otherwise>
								</c:choose></td>
							<td><a
								href="<%=request.getContextPath()%>/orders/orders.do?action=get_order&orderId=${detail.ordersId}"
								class="btn btn-info btn-sm"> 訂單詳情 </a></td>
						</tr>

						<c:set var="currentOrderId" value="${detail.ordersId}" />
						</c:forEach>

						<!-- 關閉最後一個表格 -->
						<c:if test="${not empty currentOrderId}">
					</tbody>
				</table>
			</div>
			</c:if>
		</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; VoiceBus
				2024</p>
		</div>
	</footer>

	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/front-end/browsestore/js/scripts.js"></script>

	<script>
        function openReviewForm(ordersId, prodId) {
            // 這裡實作評價表單的彈出視窗
            alert('將實作評價功能：訂單編號 ' + ordersId + ', 商品編號 ' + prodId);
        }
    </script>
</body>
</html>
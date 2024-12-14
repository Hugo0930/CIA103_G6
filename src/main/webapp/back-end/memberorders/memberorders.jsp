<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>客服Q&A</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/back-end/memberorders/css/homepage.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/back-end/memberorders/css/customer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/back-end/memberorders/css/memberorders.css">
</head>
<body>
	<!-- 漢堡 -->
	<div class="shadow"></div>
	<div class="top_side">
		<div class="hamburger active">
			<div class="bar top"></div>
			<div class="bar middle"></div>
			<div class="bar bottom"></div>
		</div>
		<!-- 大頭貼 -->
		<div class="head_shot">
			<a href="#"><img
				src="${pageContext.request.contextPath}/back-end/images/韓國瑜.jpg"
				alt="沒有圖片"></a>
		</div>
		<!-- 首頁 -->
		<div class="project_name">
			<a href="homepage.jsp">Voice Bus</a>
		</div>
	</div>
	<nav class="right_slide">
		<ul class="func_name">
			<!-- 員工帳號管理 -->
			<li class="main_item emp">
				<button class="btn_func" id="emp_btn">
					<i class="fa-solid fa-user"></i><span class="btn_name">員工管理</span>
				</button>
			</li>
			<div class="emp_btn_block">
				<ul class="sub_func_name">
					<li class="emp_sub_item">
						<button class="sub_btn_func">
							<a href="./employee_mgmt.html" class="sub_btn_name">員工帳號管理</a>
						</button>
					</li>
					<li class="emp_sub_item">
						<button class="sub_btn_func">
							<a href="./permission_mgmt.html" class="sub_btn_name">員工權限管理</a>
						</button>
					</li>
				</ul>
			</div>
			<!-- 會員帳號管理 -->
			<li class="main_item member">
				<button class="btn_func" id="member_btn">
					<i class="fa-solid fa-users"></i><span class="btn_name">會員管理</span>
				</button>
			</li>
			<div class="member_btn_block">
				<ul class="sub_func_name">
					<li class="member_sub_item">
						<button class="sub_btn_func">
							<a href="./member_mgmt.html" class="sub_btn_name">會員帳號管理</a>
						</button>
					</li>
				</ul>
			</div>
			<!-- 網頁管理 -->
			<li class="main_item web">
				<button class="btn_func" id="web_btn">
					<i class="fa-regular fa-window-restore"></i><span class="btn_name">網頁管理</span>
				</button>
			</li>
			<div class="web_btn_block">
				<ul class="sub_func_name">
					<li class="web_sub_item">
						<button class="sub_btn_func">
							<a href="./advertising_mgmt.html" class="sub_btn_name">廣告資訊管理</a>
						</button>
					</li>
					<li class="web_sub_item">
						<button class="sub_btn_func">
							<a href="./notification.mgmt.html" class="sub_btn_name">通知公告管理</a>
						</button>
					</li>
					<li class="web_sub_item">
						<form method="post"
							action="<%=request.getContextPath()%>/CustomerServiceServlet">
							<button type="submit" class="sub_btn_func">客服Q&A</button>
							<input type="hidden" name="action" value="get_all_case">
						</form>
					</li>
				</ul>
			</div>
			<!-- 商城管理 -->
			<li class="main_item shop">
				<button class="btn_func" id="shop_btn">
					<i class="fa-brands fa-shopify"></i><span class="btn_name">商城管理</span>
				</button>
			</li>
			<div class="shop_btn_block">
				<ul class="sub_func_name">
					<li class="shop_sub_item">
						<button class="sub_btn_func">
							<a href="./product_mgmt.html" class="sub_btn_name">商品管理</a>
						</button>
					</li>
					<li class="shop_sub_item">
						<form method="post"
							action="${pageContext.request.contextPath}/orders/orders.do">
							<button type="submit" class="sub_btn_func">訂單管理</button>
							<input type="hidden" name="action" value="getOrderSummary">
						</form>
					</li>
					<li class="shop_sub_item">
						<button class="sub_btn_func">
							<a href="./report_mgmt.html" class="sub_btn_name">評價檢舉管理</a>
						</button>
					</li>
				</ul>
			</div>
			<!-- 租借管理 -->
			<li class="main_item rent">
				<button class="btn_func" id="rent_btn">
					<i class="fa-solid fa-microphone-lines"></i><span class="btn_name">租借管理</span>
				</button>
			</li>
			<div class="rent_btn_block">
				<ul class="sub_func_name">
					<li class="rent_sub_item">
						<button class="sub_btn_func">
							<a href="./rental_record_mgmt.html" class="sub_btn_name">租借記錄管理</a>
						</button>
					</li>
					<li class="rent_sub_item">
						<form method="post"
							action="<%=request.getContextPath()%>/MyStudioServlet">
							<button type="submit" class="sub_btn_func" id="studio_mgmt">場地管理</button>
							<input type="hidden" name="page" value="1"> <input
								type="hidden" name="action" value="get_all">
						</form>
					</li>
				</ul>
			</div>
			<!-- 媒合管理 -->
			<li class="main_item">
				<button class="btn_func" id="match_btn">
					<i class="fa-brands fa-studiovinari"></i><span class="btn_name">媒合管理</span>
				</button>
			</li>
			<div class="match_btn_block">
				<ul class="sub_func_name">
					<li class="match_sub_item">
						<button class="sub_btn_func">
							<a href="./complaint_case_mgmt.html" class="sub_btn_name">申訴案件管理</a>
						</button>
					</li>
					<li class="match_sub_item">
						<button class="sub_btn_func">
							<a href="./case_mgmt.html" class="sub_btn_name">案件管理</a>
						</button>
					</li>
				</ul>
			</div>
		</ul>
		<!-- 登出 -->
		<button type="button" id="log_out">登出</button>
	</nav>
	<!-- 現在位置 -->
	<div class="container">
    <h2>
        <i class="fa-solid fa-house"></i>訂單管理
    </h2>
    <hr>
    <div class="table-responsive">  <!-- 移動 table-responsive 到這裡 -->
        <c:forEach var="order" items="${orderSummaryList}">
            <div class="order-section">
                <h5>訂單編號: ${order.ordersId}</h5>
                <p>收件人: ${order.memName} | 聯絡電話: ${order.memTel} | 收件地址: ${order.ordersAdd}</p>
                <table class="main">
                    <thead>
                        <tr>
                            <th>會員編號</th>
                            <th>會員姓名</th>
                            <th>訂單日期</th>
                            <th>商品名稱</th>
                            <th>單價</th>
                            <th>數量</th>
                            <th>小計</th>
                            <th>總金額</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detail" items="${order.orderDetails}">
                            <tr>
                                <td>${order.memId}</td>
                                <td>${order.memName}</td>
                                <td><fmt:formatDate value="${order.ordersDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <td>${detail.prodName}</td>
                                <td>$${detail.ordersUnitPrice}</td>
                                <td>${detail.ordersQty}</td>
                                <td>$${detail.subtotal}</td>
                                <td>$${order.ordersPaid}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:forEach>
    </div>
</div>

	<!-- 加入 JavaScript 處理狀態更新 -->
	<script>
		$(document)
				.ready(
						function() {
							// 監聽狀態選擇的改變
							$('.order-status')
									.change(
											function() {
												const orderId = $(this).data(
														'order-id');
												const newStatus = $(this).val();

												// 發送 AJAX 請求更新狀態
												$
														.ajax({
															url : '${pageContext.request.contextPath}/orders/orders.do',
															method : 'POST',
															data : {
																action : 'updateStatus',
																orderId : orderId,
																status : newStatus
															},
															success : function(
																	response) {
																alert('訂單狀態更新成功');
															},
															error : function() {
																alert('訂單狀態更新失敗');
															}
														});
											});
						});
	</script>
	</div>
	<script src="https://kit.fontawesome.com/155106be6f.js"
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath}/back-end/memberorders/vendor/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/back-end/memberorders/js/homepage.js"></script>
	<script
		src="${pageContext.request.contextPath}/back-end/memberorders/js/customer.js"></script>
</body>
</html>
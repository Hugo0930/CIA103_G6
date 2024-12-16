<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="zh">
<head>
<meta charset="UTF-8">
<title>單一申訴案件</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
body {
	background-color: #f4f7fc;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 50px;
	margin-bottom: 50px;
}

.card {
	background-color: white;
	border-radius: 15px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	padding: 20px;
}

.card-header {
	background-color: #007bff;
	color: white;
	font-size: 24px;
	text-align: center;
	border-top-left-radius: 15px;
	border-top-right-radius: 15px;
}

h3 {
	color: #333;
	text-align: center;
	margin-bottom: 30px;
}

.btn-primary, .btn-warning {
	background-color: #007bff;
	color: white;
	border-radius: 5px;
	padding: 10px 20px;
	border: none;
	font-size: 16px;
}

.btn-warning {
	background-color: #f39c12;
	color: white;
}

.btn-primary:hover, .btn-warning:hover {
	background-color: #0056b3;
}

footer {
	background-color: #2c3e50;
	color: white;
	padding: 15px;
	text-align: center;
}

footer a {
	color: #f39c12;
	text-decoration: none;
}

footer a:hover {
	text-decoration: underline;
}

.data-label {
	font-weight: bold;
	color: #555;
}

.data-value {
	color: #333;
}
</style>

</head>
<body>

	<!-- 頁面內容 -->
	<div class="container">

		<!-- 申訴案件詳細信息卡片 -->
		<div class="card">
			<div class="card-header">申訴案件詳情</div>

			<div class="card-body">

				<h3>申訴案件資料</h3>

				<!-- 申訴編號 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">申訴編號：</div>
					<div class="col-md-8 data-value">${complaintVO.complaintId}</div>
				</div>

				<!-- 會員編號 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">會員編號：</div>
					<div class="col-md-8 data-value">${complaintVO.memberId}</div>
				</div>

				<!-- 案件編號 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">案件編號：</div>
					<div class="col-md-8 data-value">${complaintVO.caseId}</div>
				</div>

				<!-- 申訴內容 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">申訴內容：</div>
					<div class="col-md-8 data-value">${complaintVO.complaintCon}</div>
				</div>

				<!-- 申訴日期 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">申訴日期：</div>
					<div class="col-md-8 data-value">
						<fmt:formatDate value="${complaintVO.complaintTime}"
							pattern="yyyy-MM-dd HH:mm:ss" />
					</div>
				</div>

				<!-- 申訴狀態 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">申訴狀態：</div>
					<div class="col-md-8 data-value">
						<c:choose>
							<c:when test="${complaintVO.complaintStatus == 0}">申訴成功</c:when>
							<c:when test="${complaintVO.complaintStatus == 1}">申訴失敗</c:when>
							<c:otherwise>未知</c:otherwise>
						</c:choose>
					</div>
				</div>

				<!-- 處理結果 -->
				<div class="row mb-3">
					<div class="col-md-4 data-label">處理結果：</div>
					<div class="col-md-8 data-value">${complaintVO.complaintResult}</div>
				</div>

				<!-- 按鈕區域 -->
				<div class="text-center mt-4">
					<!-- 返回首頁按鈕 -->
					<a
						href="<%=request.getContextPath()%>/back-end/complaint/select_page.jsp"
						class="btn btn-primary"> 回首頁 </a>

					<!-- 修改案件按鈕 -->
					<a
						href="<%= request.getContextPath() %>/complaintServlet?action=getOne_For_Update&complaintId=${complaintVO.complaintId}"
						class="btn btn-warning"> 修改 </a>

				</div>

			</div>
		</div>
	</div>

	<!-- 頁腳 -->
	<footer>
		<p>
			© 2024 所有版權歸公司所有. <a href="#">隐私政策</a> | <a href="#">聯繫我們</a>
		</p>
	</footer>

	<!-- 載入Bootstrap JS和jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

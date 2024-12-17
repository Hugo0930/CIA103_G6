<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="zh">
<head>
<meta charset="UTF-8">
<title>會員申訴案件 - listMemberComplaint.jsp</title>

<!-- 引入Bootstrap样式 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
body {
	background-color: #f4f7fc;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 50px;
	margin-bottom: 50px;
}

table {
	width: 100%;
	background-color: white;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

h3 {
	color: #2c3e50;
	text-align: center;
	margin-bottom: 30px;
}

.btn {
	background-color: #007bff;
	color: white;
	border-radius: 5px;
	padding: 10px 20px;
	border: none;
}

.btn:hover {
	background-color: #0056b3;
}

.btn-warning {
	background-color: #f39c12;
	color: white;
}

.btn-warning:hover {
	background-color: #e67e22;
}

footer {
	background-color: #2c3e50;
	color: white;
	padding: 15px;
	text-align: center;
}

.text-center {
	text-align: center;
}
</style>

</head>
<body>

	<!-- 頁面內容 -->
	<div class="container">

		<h3>會員的所有申訴案件</h3>

		<!-- 按鈕返回首頁 -->
		<div class="mb-4 text-center">
			<a href="<%=request.getContextPath()%>/back-end/complaint/select_page.jsp" class="btn btn-primary">回首頁</a>
		</div>

		<!-- 顯示會員ID -->
		<div class="alert alert-info text-center">
			會員編號：<strong>${sessionScope.memberId}</strong>
		</div>

		<!-- 錯誤消息區 -->
		<c:if test="${not empty errorMsgs}">
			<div class="alert alert-danger">
				<strong>發生錯誤：</strong>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li>${message}</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>

		<table class="table table-bordered">
			<thead class="thead-light">
				<tr>
					<th>申訴編號</th>
					<th>會員編號</th>
					<th>案件編號</th>
					<th>申訴內容</th>
					<th>申訴日期</th>
					<th>申訴狀態</th>
					<th>處理結果</th>
					<th>照片</th>
					<!-- 新增照片列 -->
				</tr>
			</thead>
			<tbody>
				<c:forEach var="complaintVO" items="${complaintList}">
					<tr>
						<!-- 申訴編號 -->
						<td>${complaintVO.complaintId}</td>

						<!-- 會員編號 -->
						<td>${complaintVO.memberId}</td>

						<!-- 案件編號 -->
						<td>${complaintVO.caseId}</td>

						<!-- 申訴內容 -->
						<td>${complaintVO.complaintCon}</td>

						<!-- 申訴日期 -->
						<td><fmt:formatDate value="${complaintVO.complaintTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>

						<!-- 申訴狀態 -->
						<td><c:choose>
								<c:when test="${complaintVO.complaintStatus == 0}">申訴成功</c:when>
								<c:when test="${complaintVO.complaintStatus == 1}">申訴失敗</c:when>
								<c:otherwise>未知</c:otherwise>
							</c:choose></td>

						<!-- 處理結果 -->
						<td>${complaintVO.complaintResult}</td>

						<!-- 照片 -->
						<td><c:forEach var="photo" items="${complaintVO.photoList}">
								<img src="${photo}" alt="申訴照片" style="width: 100px; height: 100px; margin: 5px; object-fit: cover;">
							</c:forEach></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- 頁腳 -->
	<footer>
		<p>
			© 2024 版權所有. <a href="#">隱私政策</a> | <a href="#">聯絡我們</a>
		</p>
	</footer>

	<!-- Bootstrap 和 jQuery JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

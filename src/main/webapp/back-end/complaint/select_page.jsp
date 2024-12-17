<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.complaint.model.*"%>

<html lang="zh">
<head>
<meta charset="UTF-8">
<title>申訴案件管理 - 首頁</title>

<!-- Google 字型 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- 依賴 (jQuery 和 Popper.js) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
body {
	background: linear-gradient(to right, #4facfe, #00f2fe);
	font-family: 'Roboto', sans-serif;
}

h3 {
	color: #ffffff;
	font-weight: 700;
	font-size: 36px;
}

.container {
	max-width: 960px;
	margin-top: 40px;
}

.card {
	margin-top: 20px;
	padding: 30px;
	border-radius: 15px;
	background-color: #ffffff;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card:hover {
	transform: translateY(-10px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
}

.sidebar {
	position: fixed;
	top: 0;
	left: 0;
	width: 250px;
	height: 100%;
	background-color: #f8f9fa;
	padding: 20px;
}

.sidebar img {
	width: 100%;
	border-radius: 10px;
	margin-bottom: 20px;
}

.sidebar h4 {
	color: #333;
	font-weight: 600;
}

.sidebar .btn {
	width: 100%;
	margin-bottom: 15px;
}

.content-area {
	margin-left: 270px;
	padding: 20px;
}

.alert-danger {
	margin-bottom: 20px;
	background-color: #f8d7da;
	color: #721c24;
	padding: 15px;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
	color: #fff;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004085;
}

.btn-primary:focus {
	box-shadow: 0 0 0 0.2rem rgba(38, 143, 255, 0.5);
}
</style>
</head>

<body>

	<!-- 側邊欄 -->
	<div class="sidebar">
		<img src="<%=request.getContextPath()%>/back-end/complaint/images/c8763.gif" alt="Sidebar Image" class="img-fluid">
		<h4>申訴案件管理</h4>
		<ul class="list-unstyled">
			<li><a href="<%=request.getContextPath()%>/back-end/complaint/listAllComplaint.jsp" class="btn btn-info"> <i class="fas fa-list"></i> 查看全部案件
			</a></li>
		</ul>
	</div>

	<!-- 內容區域 -->
	<div class="content-area">
		<div class="container">
			<div class="row mb-4 text-center">
				<div class="col-12">
					<h3>申訴案件管理</h3>
				</div>
			</div>

			<!-- 錯誤消息顯示區 -->
			<c:if test="${not empty errorMsgs}">
				<div class="alert alert-danger">
					<strong>請修正以下錯誤:</strong>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li>${message}</li>
						</c:forEach>
					</ul>
				</div>
			</c:if>

			<!-- 申訴資料查詢 -->
			<div class="card">
				<h4>申訴資料查詢:</h4>
				<form method="GET" action="<%=request.getContextPath()%>/complaintServlet" onsubmit="return validateForm()">
					<div class="form-group">
						<label><b>輸入申訴編號:</b></label> <input type="text" name="complaintId" id="complaintId" class="form-control" placeholder="輸入申訴編號">
					</div>
					<div class="form-group">
						<label><b>輸入會員編號:</b></label> <input type="text" name="memberId" id="memberId" class="form-control" placeholder="輸入會員編號">
					</div>
					<input type="hidden" name="action" value="getOne_For_Display">
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-search"></i> 查詢
					</button>
				</form>
			</div>
		</div>
	</div>

	<script>
		function validateForm() {
			const complaintId = document.getElementById('complaintId').value
					.trim();
			const memberId = document.getElementById('memberId').value.trim();
			if (!complaintId && !memberId) {
				alert('請輸入 申訴編號 或 會員編號 之一作為查詢條件！');
				return false;
			}
			return true;
		}
	</script>

</body>
</html>

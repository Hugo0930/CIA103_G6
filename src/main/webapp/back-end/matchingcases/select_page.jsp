<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>媒合案件管理 - 搜尋</title>

<!-- Google 字型 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<!-- Bootstrap 4.5.2 -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

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

.error-message {
	color: #ff0000;
	font-size: 0.9em;
}
</style>
</head>

<body>

	<!-- 側邊欄 -->
	<div class="sidebar">
		<img src="<%=request.getContextPath()%>/back-end/complaint/images/c8763.gif" alt="Sidebar Image" class="img-fluid">
		<h4>媒合案件管理</h4>
		<ul class="list-unstyled">
			<li><a href="${pageContext.request.contextPath}/matchingCases/list?action=list" class="btn btn-info"><i class="fas fa-list"></i> 查看所有案件</a></li>
		</ul>
	</div>

	<div class="content-area">
		<div class="container">
			<div class="row mb-4 text-center">
				<div class="col-12">
					<h3>搜尋媒合案件</h3>
				</div>
			</div>

			<!-- 🔥 錯誤消息顯示區 -->
			<c:if test="${not empty errorMsg}">
				<div class="alert alert-danger" role="alert">
					<strong>錯誤:</strong>
					<c:out value="${errorMsg}" escapeXml="true" />
				</div>
			</c:if>

			<!-- 搜尋案件 -->
			<div class="card">
				<h4>搜尋媒合案件</h4>
				<form method="GET" action="<%=request.getContextPath()%>/matchingCases/view">
					<div class="form-group">
						<label for="caseId"><b>輸入案件編號 (CASE_ID):</b></label> 
						<input 
							type="number" 
							name="caseId" 
							id="caseId" 
							class="form-control" 
							placeholder="請輸入正確的案件編號" 
							min="1" 
							max="99" 
							required 
						> 
						<small class="error-message">請輸入正確的數字</small>
					</div>
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-search"></i> 搜尋
					</button>
				</form>

			</div>
		</div>
	</div>

</body>
</html>

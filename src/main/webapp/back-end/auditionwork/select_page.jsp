
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>配音作品分頁查詢</title>

<!-- Google 字型 -->
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

<!-- Bootstrap 5.1.3 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- FontAwesome -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

<style>
body {
	background: linear-gradient(to right, #4facfe, #00f2fe);
	font-family: 'Roboto', sans-serif;
	color: #333;
}

.container {
	margin-top: 40px;
	max-width: 960px;
	background: #ffffff;
	border-radius: 15px;
	padding: 30px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	color: #007bff;
	font-weight: 700;
	font-size: 36px;
	margin-bottom: 20px;
}

.btn {
	font-size: 14px;
	padding: 10px 20px;
	border-radius: 25px;
	transition: all 0.3s ease;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
	color: white;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004085;
	transform: translateY(-2px);
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}

.btn-info {
	background-color: #17a2b8;
	border-color: #17a2b8;
	color: white;
}

.btn-info:hover {
	background-color: #117a8b;
	border-color: #0d5c70;
	transform: translateY(-2px);
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}

.btn-outline-primary {
	background-color: transparent;
	color: #007bff;
	border: 1px solid #007bff;
}

.btn-outline-primary:hover {
	background-color: #007bff;
	color: white;
	transform: translateY(-2px);
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
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
</style>
</head>
<body>
	<!-- 側邊欄 -->
	<div class="sidebar">
		<img src="<%=request.getContextPath()%>/back-end/complaint/images/c8763.gif" alt="Sidebar Image" class="img-fluid">
		<h4>配音作品管理</h4>
		<ul class="list-unstyled">
			<li><a href="<%=request.getContextPath()%>/back-end/auditionwork/listWork.jsp" class="btn btn-primary"> <i class="fas fa-list"></i> 所有配音作品
			</a></li>
		</ul>
	</div>

	<!-- 內容區域 -->
	<div class="content-area" style="margin-left: 270px; padding: 20px;">
		<div class="container">
			<h1>配音作品管理</h1>

			<form action="<%=request.getContextPath()%>/auditionWorkServlet" method="get">
				<input type="hidden" name="action" value="getOne">
				<div class="input-group mb-3">
					<input type="text" class="form-control" placeholder="輸入配音編號 (僅限數字)" name="workId" pattern="\d+" required>
					<button class="btn btn-primary" type="submit">
						<i class="fas fa-search"></i> 搜尋
					</button>
				</div>
			</form>


		</div>
	</div>
</body>
</html>

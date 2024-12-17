<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*"%>


<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>新增配音作品</title>
<!-- 引入 Bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
body {
	background: linear-gradient(to right, #74ebd5, #ACB6E5);
	font-family: Arial, sans-serif;
	color: #333;
}

.container {
	margin-top: 50px;
	max-width: 700px;
	background: #ffffff;
	border-radius: 15px;
	padding: 30px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

h1 {
	font-size: 28px;
	font-weight: 600;
	color: #4C6085;
	text-align: center;
	margin-bottom: 20px;
}

.btn-primary {
	background-color: #4C6085;
	border-color: #4C6085;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	background-color: #354b62;
	border-color: #354b62;
	transform: translateY(-2px);
	box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
}

.btn-secondary {
	background-color: #6c757d;
	border-color: #6c757d;
}

.btn-secondary:hover {
	background-color: #5a6268;
	border-color: #545b62;
}

.form-label {
	font-weight: 600;
	color: #4C6085;
}

.form-control:focus {
	border-color: #4C6085;
	box-shadow: 0 0 0 0.2rem rgba(76, 96, 133, 0.25);
}

.form-text {
	font-size: 0.9rem;
	color: #6c757d;
}

.required-label {
	color: #dc3545;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="container">
		<h1>新增配音作品</h1>

		<!-- 顯示錯誤訊息 -->
		<c:if test="${not empty errorMessage}">
			<div class="alert alert-danger" role="alert">${errorMessage}</div>
		</c:if>


		<form action="${pageContext.request.contextPath}/auditionWorkServlet?action=add" method="post" enctype="multipart/form-data">

			<!-- 會員編號 -->
			<div class="mb-3">
				<label for="memId" class="form-label">會員編號 <span class="required-label">*</span></label> <input type="text" class="form-control" id="memId" name="memId" value="5" placeholder="請輸入會員編號 (僅限數字)" required pattern="\d+">
				<div class="form-text">測試期間允許手動填寫，最終會從 Session 中獲取</div>
			</div>

			<!-- 作品標題 -->
			<div class="mb-3">
				<label for="title" class="form-label">作品標題 <span class="required-label">*</span></label> <input type="text" class="form-control" id="title" name="title" placeholder="請輸入作品標題" required maxlength="100">
				<div class="form-text">最多 100 個字元</div>
			</div>

			<!-- 作品描述 -->
			<div class="mb-3">
				<label for="description" class="form-label">作品描述</label>
				<textarea class="form-control" id="description" name="description" placeholder="請輸入作品描述 (選填)" rows="3" maxlength="500"></textarea>
				<div class="form-text">最多 500 個字元，這是可選的欄位</div>
			</div>

			<!-- 音檔上傳 -->
			<div class="mb-3">
				<label for="audioFile" class="form-label">上傳音檔 <span class="required-label">*</span></label> <input type="file" class="form-control" id="audioFile" name="audioFile" accept="audio/*" required>
				<div class="form-text">請選擇 mp3、wav 格式的音檔，且大小不得超過 5MB</div>
			</div>

			<!-- 提交按鈕 -->
			<div class="d-flex justify-content-between">
				<button type="submit" class="btn btn-primary">新增作品</button>
				<a href="select_page.jsp" class="btn btn-secondary">返回</a>
			</div>
		</form>
	</div>
</body>
</html>

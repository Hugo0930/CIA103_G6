<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>新增應徵記錄</title>

<!-- 引入 Bootstrap 5 的 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background-color: #f7f9fc;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 50px;
	max-width: 600px;
	background-color: #fff;
	padding: 40px;
	border-radius: 10px;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.form-label {
	font-weight: bold;
	color: #333;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #004085;
}

.form-control:focus {
	border-color: #007bff;
	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, .25);
}

.btn-container {
	text-align: center;
}

.form-heading {
	text-align: center;
	font-weight: bold;
	font-size: 1.8rem;
	margin-bottom: 20px;
	color: #333;
}

.form-text {
	font-size: 0.9rem;
	color: #6c757d;
}
</style>
</head>

<body>

	<div class="container">
		<h1 class="form-heading">新增應徵記錄</h1>

		<!-- 表單提交到 InsertApplyServlet，使用 enctype="multipart/form-data" 允許上傳檔案 -->
		<form action="${pageContext.request.contextPath}/InsertApplyServlet" method="post"
			enctype="multipart/form-data">
			
			<!-- 會員ID (自動從 session 獲取，僅顯示不允許編輯) -->
			<div class="mb-3">
				<label for="memId" class="form-label">會員ID</label> 
				<input type="text" id="memId" name="memId" class="form-control"
					value="<%=session.getAttribute("memberId") != null ? session.getAttribute("memberId") : 5%>"
					readonly> 
				<small class="form-text">會員ID 為系統自動填寫，無需手動輸入。</small>
			</div>

			<!-- 作品描述 -->
			<div class="mb-3">
				<label for="description" class="form-label">作品描述</label>
				<textarea id="description" name="description" class="form-control"
					placeholder="請輸入作品描述" rows="4" required></textarea>
				<small class="form-text">最多 500 個字元。</small>
			</div>

			<!-- 預算 -->
			<div class="mb-3">
				<label for="budget" class="form-label">預算</label> 
				<select id="budget" name="budget" class="form-control" required>
					<option value="" disabled selected>請選擇預算</option>
					<option value="1000">1000</option>
					<option value="1200">1200</option>
					<option value="1500">1500</option>
					<option value="2000">2000</option>
				</select>
			</div>

			<!-- 試音檔案上傳 -->
			<div class="mb-3">
				<label for="voiceFile" class="form-label">上傳試音檔案</label> 
				<input type="file" id="voiceFile" name="voiceFile" class="form-control"
					accept=".mp3,.wav" required>
				<small class="form-text">支援的格式：mp3, wav，檔案大小不超過 5MB。</small>
			</div>

			<!-- 備註欄位 -->
			<div class="mb-3">
				<label for="remarks" class="form-label">備註</label>
				<textarea id="remarks" name="remarks" class="form-control" 
					placeholder="可填寫與本次應徵相關的備註" rows="3"></textarea>
				<small class="form-text">此欄位為選填，最多 255 個字元。</small>
			</div>

			<!-- 提交按鈕 -->
			<button type="submit" class="btn btn-primary btn-block mt-3 w-100">提交</button>
		</form>

	</div>

	<!-- 引入 Bootstrap 5 的 JavaScript（選擇性，必要時可刪除） -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

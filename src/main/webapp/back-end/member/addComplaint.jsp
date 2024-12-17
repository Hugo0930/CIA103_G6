<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="zh">
<head>
<meta charset="UTF-8">
<title>新增申訴案件</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f7fc;
}

.container {
	margin-top: 50px;
	max-width: 900px;
	background-color: white;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h3 {
	text-align: center;
	margin-bottom: 20px;
}

.form-group label {
	font-weight: bold;
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

.preview-container img {
	width: 100px;
	height: 100px;
	margin: 10px;
	object-fit: cover;
	border-radius: 5px;
	display: block;
}

.preview-item {
	display: inline-block;
	text-align: center;
	margin-bottom: 15px;
	position: relative;
}

.preview-item span {
	display: block;
	font-size: 12px;
	color: #333;
	margin-top: 5px;
}

.delete-btn {
	position: absolute;
	top: 0;
	right: 0;
	background-color: red;
	color: white;
	border: none;
	border-radius: 50%;
	width: 20px;
	height: 20px;
	cursor: pointer;
	font-size: 12px;
	text-align: center;
}
</style>
</head>

<body>
	<div class="container">
		<h3>新增申訴案件</h3>

		<!-- 顯示錯誤訊息 -->
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

		<!-- 新增申訴表單 -->
		<form action="${pageContext.request.contextPath}/complaintServlet" method="post" enctype="multipart/form-data">
			<input type="hidden" name="action" value="insert">

			<!-- 			會員編號 (用於提交表單) -->
			<input type="hidden" name="memId" value="${sessionScope.memberId}">
			<!-- 			案件編號 (用於提交表單) -->
			<input type="hidden" name="caseId" value="${param.caseId}">

			<!-- 顯示會員編號 -->
			<div class="form-group">
				<label>會員編號：</label> <span class="form-control-plaintext">${sessionScope.memberId}</span>
			</div>

			<!-- 顯示案件編號 -->
			<div class="form-group">
				<label>案件編號：</label> <span class="form-control-plaintext">${param.caseId}</span>
			</div>

			<!-- 申訴內容 -->
			<div class="form-group">
				<label for="comCon">申訴內容:</label>
				<textarea class="form-control" id="comCon" name="complaintCon" placeholder="請描述您的申訴內容" rows="5" required></textarea>
			</div>

			<!-- 照片上傳 -->
			<div class="form-group">
				<label for="photos">上傳照片 (最多 5 張)</label> <input type="file" class="form-control-file" id="photos" name="photos" accept="image/*" multiple onchange="previewImages(event)">
			</div>

			<!-- 圖片預覽區 -->
			<div class="preview-container" id="preview-container"></div>

			<!-- 提交按鈕 -->
			<button type="submit" class="btn btn-primary btn-block">提交申訴</button>
		</form>
	</div>

	<script>
	let allFiles = []; // 全局存儲所有圖片
	const MAX_FILES = 5; // 限制最多上傳 5 張照片

	function previewImages(event) {
	    const files = Array.from(event.target.files);
	    const previewContainer = document.getElementById('preview-container');

	    // 總圖片數超過限制，則阻止上傳
	    if (allFiles.length + files.length > MAX_FILES) {
	        alert(`最多只能上傳 ${MAX_FILES} 張照片！`);
	        event.target.value = ''; // 清空文件輸入框
	        return;
	    }

	    files.forEach(file => {
	        if (file.type.startsWith('image/')) {
	            allFiles.push(file);
	            const reader = new FileReader();
	            reader.onload = (e) => {
	                const previewItem = document.createElement('div');
	                previewItem.classList.add('preview-item');

	                const img = document.createElement('img');
	                img.src = e.target.result;

	                const fileName = document.createElement('span');
	                fileName.textContent = file.name.length > 15 ? file.name.slice(0, 15) + '...' : file.name;

	                const deleteBtn = document.createElement('button');
	                deleteBtn.textContent = 'X';
	                deleteBtn.classList.add('delete-btn');
	                deleteBtn.addEventListener('click', () => {
	                    allFiles = allFiles.filter(f => f.name !== file.name); // 刪除選中的圖片
	                    previewItem.remove();
	                });

	                previewItem.appendChild(deleteBtn);
	                previewItem.appendChild(img);
	                previewItem.appendChild(fileName);
	                previewContainer.appendChild(previewItem);
	            };
	            reader.readAsDataURL(file);
	        } else {
	            alert(`檔案 "${file.name}" 格式不正確，請上傳圖片格式！`);
	        }
	    });

	    // 清空 input[type="file"]，使得可以再次選擇同一張圖片
	    event.target.value = '';
	}

	</script>
</body>
</html>

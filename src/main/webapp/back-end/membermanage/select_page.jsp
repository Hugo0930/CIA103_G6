<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>會員管理 - 搜尋頁面</title>

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

.alert-fixed {
	position: fixed;
	top: 20px;
	left: 50%;
	transform: translateX(-50%);
	z-index: 9999;
	width: 400px;
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

	<!-- 🔥 錯誤提示彈窗 -->
	<div id="errorAlert" class="alert alert-danger alert-dismissible fade show alert-fixed" role="alert" style="display: none;">
		<strong>錯誤!</strong> <span id="errorMessage"></span>
		<button type="button" class="close" onclick="closeAlert()">
			<span>&times;</span>
		</button>
	</div>

	<!-- 側邊欄 -->
	<div class="sidebar">
		<img src="<%=request.getContextPath()%>/back-end/complaint/images/c8763.gif" alt="Sidebar Image" class="img-fluid">
		<h4>會員管理</h4>
		<ul class="list-unstyled">
			<li><a href="<%=request.getContextPath()%>/back-end/membermanage/listAllMemberManage.jsp" class="btn btn-info"><i class="fas fa-list"></i> 查看全部會員</a></li>
		</ul>
	</div>

	<!-- 內容區域 -->
	<div class="content-area">
		<div class="container">
			<div class="row mb-4 text-center">
				<div class="col-12">
					<h3>會員管理</h3>
				</div>
			</div>

			<!-- 會員資料查詢 -->
			<div class="card">
				<h4>會員資料查詢</h4>
				<form method="GET" action="<%=request.getContextPath()%>/memberManageServlet" onsubmit="return validateForm()">
					<div class="form-group">
						<label><b>輸入會員編號 (MEM_ID):</b></label> <input type="text" name="memberId" id="memberId" class="form-control" placeholder="輸入會員編號">
					</div>
					<div class="form-group">
						<label><b>輸入會員姓名:</b></label> <input type="text" name="memberName" id="memberName" class="form-control" placeholder="輸入會員姓名">
					</div>
					<input type="hidden" name="action" value="getOne">
					<button type="submit" class="btn btn-primary">
						<i class="fas fa-search"></i> 查詢
					</button>
				</form>
			</div>
		</div>
	</div>

	<script>
	function validateForm() {
	    const memberId = document.getElementById('memberId').value.trim();
	    const memberName = document.getElementById('memberName').value.trim();

	    if (!memberId && !memberName) {
	        showAlert('請輸入 會員編號 或 會員姓名 之一作為查詢條件！');
	        return false;
	    }

	    if (memberId && !/^\d{1,10}$/.test(memberId)) {
	        showAlert('會員編號必須為 1-10 位數的數字！');
	        return false;
	    }

	    if (memberName && !/^[\u4e00-\u9fa5a-zA-Z\s]{1,30}$/.test(memberName)) {
	        showAlert('會員姓名格式不正確，僅允許中文、英文字母和空格，長度1-30個字元！');
	        return false;
	    }

	    return true;
	}

	function showAlert(message) {
	    const alertBox = document.createElement('div');
	    alertBox.className = 'alert alert-danger';
	    alertBox.textContent = message;
	    document.body.appendChild(alertBox);

	    setTimeout(() => {
	        alertBox.remove();
	    }, 3000);
	}

    </script>

</body>
</html>

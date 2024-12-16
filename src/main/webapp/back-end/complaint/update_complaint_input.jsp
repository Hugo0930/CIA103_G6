<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="zh">
<head>
<meta charset="UTF-8">
<title>申訴資料修改 - 更新申訴案件</title>

<!-- 引入 Bootstrap -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f7f7f7;
	padding-top: 40px;
}

h3 {
	color: #333;
	font-weight: 700;
	font-size: 36px;
	text-align: center;
}

.container {
	max-width: 900px;
	margin-top: 30px;
}

.card {
	margin-top: 20px;
	padding: 30px;
	border-radius: 15px;
	background-color: #ffffff;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.btn-success {
	background-color: #28a745;
}

.btn-secondary {
	background-color: #6c757d;
}

.alert-danger {
	margin-bottom: 20px;
	border-radius: 8px;
	background-color: #f8d7da;
	color: #721c24;
	padding: 15px;
}
</style>
</head>

<body>

	<div class="container">
		<h3>申訴資料修改</h3>

		<!-- 檢查是否有錯誤訊息 -->
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

		<!-- 申訴修改表單 -->
		<div class="card">
			<form method="post" action="<%=request.getContextPath()%>/complaintServlet">
				<!-- 申訴編號 -->
				<div class="form-group">
					<label>申訴編號：</label> <input type="text" class="form-control" name="complaintId" value="${complaintVO.complaintId}" readonly />
				</div>

				<!-- 會員編號 -->
				<div class="form-group">
					<label>會員編號：</label> <input type="text" class="form-control" name="memberId" value="${complaintVO.memberId}" readonly />
				</div>

				<!-- 案件編號 -->
				<div class="form-group">
					<label>案件編號：</label> <input type="text" class="form-control" name="caseId" value="${complaintVO.caseId}" readonly />
				</div>

				<!-- 申訴內容 -->
				<div class="form-group">
					<label>申訴案件內容：</label>
					<textarea class="form-control" name="complaintCon" rows="3" readonly>${complaintVO.complaintCon}</textarea>
				</div>

				<!-- 申訴日期 -->
				<div class="form-group">
					<label>申訴日期：</label> <input type="text" class="form-control" name="complaintTime" value="${complaintVO.complaintTime}" readonly />
				</div>

				<!-- 申訴狀態 -->
				<div class="form-group">
					<label>申訴狀態：</label>
						<select name="complaintStatus" class="form-control">
							<option value="0" <c:if test="${complaintVO.complaintStatus == 0}">selected</c:if>>待處理</option>
							<option value="1" <c:if test="${complaintVO.complaintStatus == 1}">selected</c:if>>處理中</option>
							<option value="2" <c:if test="${complaintVO.complaintStatus == 2}">selected</c:if>>已解決</option>
							<option value="3" <c:if test="${complaintVO.complaintStatus == 3}">selected</c:if>>已駁回</option>
							<option value="4" <c:if test="${complaintVO.complaintStatus == 4}">selected</c:if>>已取消</option>
							<option value="5" <c:if test="${complaintVO.complaintStatus == 5}">selected</c:if>>已過期</option>
							<option value="6" <c:if test="${complaintVO.complaintStatus == 6}">selected</c:if>>待補件</option>
							<option value="7" <c:if test="${complaintVO.complaintStatus == 7}">selected</c:if>>審核中</option>
					</select>
				</div>

				<!-- 處理結果 -->
				<div class="form-group">
					<label>處理結果：</label> <input type="text" class="form-control" name="complaintResult" value="${complaintVO.complaintResult}" />
				</div>

				<input type="hidden" name="action" value="update">
				<button type="submit" class="btn btn-success">送出修改</button>
				<a href="javascript:history.back()" class="btn btn-secondary">取消返回</a>
			</form>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>

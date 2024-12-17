<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>單一會員詳細資料</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	color: #333;
	max-width: 800px;
	margin: 0 auto;
}

h1 {
	text-align: center;
	color: #444;
}

p {
	font-size: 16px;
	margin: 10px 0;
}

.member-detail {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.btn-container {
	text-align: center;
	margin-top: 20px;
}

.btn-container a {
	display: inline-block;
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	text-decoration: none;
	border-radius: 4px;
	margin-right: 10px;
}

.btn-container a:hover {
	background-color: #0056b3;
}

.error-msg {
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>

	<h1>會員詳細資料</h1>

	<!-- 顯示錯誤訊息 -->
	<c:if test="${not empty errorMsg}">
		<p class="error-msg">${errorMsg}</p>
	</c:if>

	<div class="member-detail">
		<p>
			<strong>會員編號：</strong>${member.memberId}</p>
		<p>
			<strong>會員姓名：</strong>${member.memberName}</p>
		<p>
			<strong>會員身分證字號：</strong>${member.memberUid}</p>
		<p>
			<strong>會員生日：</strong>${member.memberBth}</p>
		<p>
			<strong>會員性別：</strong>
			<c:choose>
				<c:when test="${member.memberGender == 1}">男</c:when>
				<c:otherwise>女</c:otherwise>
			</c:choose>
		</p>
		<p>
			<strong>會員電子郵件：</strong>${member.memberEmail}</p>
		<p>
			<strong>會員手機電話：</strong>${member.memberTel}</p>
		<p>
			<strong>會員地址：</strong>${member.memberAdd}</p>
		<p>
			<strong>會員等級：</strong>
			<c:choose>
				<c:when test="${member.memberLvId == 0}">一般會員</c:when>
				<c:otherwise>白金會員</c:otherwise>
			</c:choose>
		</p>
		<p>
			<strong>會員狀態：</strong>
			<c:choose>
				<c:when test="${member.memberStatus == 0}">正常</c:when>
				<c:otherwise>停權</c:otherwise>
			</c:choose>
		</p>
	</div>

	<div class="btn-container">
		<a href="${pageContext.request.contextPath}/memberManageServlet?action=getUpdatePage&memberId=${member.memberId}" class="btn btn-warning">修改</a>
	</div>

</body>
</html>

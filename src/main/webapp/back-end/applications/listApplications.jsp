<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.caseapplications.model.*"%>
<!-- 會員可以自己可以看到自己的應徵紀錄 -->

<%
// 🟢 從 Session 中嘗試獲取 memberId
Integer memberId = (Integer) session.getAttribute("memberId");

// 🔥 如果 Session 中的 memberId 為 null，則使用一個假會員 ID（測試用）
if (memberId == null) {
	memberId = 5; // 模擬會員 ID
	session.setAttribute("memberId", memberId); // 🟢 將測試的 memberId 存入 session
}
CaseApplicationsService caseApplicationsSVC = new CaseApplicationsService();
List<CaseApplicationsVO> list = caseApplicationsSVC.getApplicationsByMemberId(memberId);
pageContext.setAttribute("applicationList", list);
%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>我的應徵紀錄</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background-color: #f7f9fc;
	font-family: Arial, sans-serif;
}

.container {
	margin-top: 50px;
	max-width: 900px;
	background: #fff;
	border-radius: 8px;
	padding: 30px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
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

.text-danger {
	font-size: 0.85rem;
}

.is-invalid {
	border-color: #dc3545 !important;
}

.invalid-feedback {
	display: block;
	color: #dc3545;
}

.badge {
	font-size: 0.85rem;
	padding: 5px 10px;
}

.badge-status-0 {
	background-color: #f0ad4e;
}

.badge-status-1 {
	background-color: #5cb85c;
}

.badge-status-2 {
	background-color: #d9534f;
}

.table thead th {
	background-color: #f2f2f2;
	text-align: center;
}

.table tbody td {
	text-align: center;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center mb-4">我的應徵紀錄</h2>

		<!-- 如果沒有應徵紀錄，則顯示提示 -->
		<c:if test="${empty applicationList}">
			<div class="alert alert-info text-center" role="alert">
				目前尚無應徵紀錄。</div>
		</c:if>

		<!-- 顯示應徵紀錄 -->
		<c:if test="${not empty applicationList}">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>應徵編號</th>
						<th>案件標題</th>
						<th>應徵時間</th>
						<th>應徵狀態</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="application" items="${applicationList}">
						<tr>
							<td>${application.appId}</td>
							<td>${application.title}</td>
							<td>${application.applyTime}</td>
							<td><c:choose>
									<c:when test="${application.status == 0}">
										<span class="badge badge-status-0">申請中</span>
									</c:when>
									<c:when test="${application.status == 1}">
										<span class="badge badge-status-1">已通過</span>
									</c:when>
									<c:when test="${application.status == 2}">
										<span class="badge badge-status-2">已駁回</span>
									</c:when>
									<c:otherwise>
										<span class="badge bg-secondary">未知狀態</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>

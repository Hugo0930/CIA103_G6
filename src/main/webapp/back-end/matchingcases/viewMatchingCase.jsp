<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<title>案件詳情</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<div class="container mt-5">
		<h1 class="text-center text-info">案件詳情</h1>

		<ul class="list-group">
			<li class="list-group-item"><strong>案件編號:</strong> <c:out value="${caseDetails.caseId}" /></li>
			<li class="list-group-item"><strong>接案會員編號:</strong> <c:out value="${caseDetails.receiverId}" /></li>
			<li class="list-group-item"><strong>發案會員編號:</strong> <c:out value="${caseDetails.memId}" /></li>
			<li class="list-group-item"><strong>標題:</strong> <c:out value="${caseDetails.title}" /></li>
			<li class="list-group-item"><strong>描述:</strong> <c:out value="${caseDetails.description}" /></li>
			<li class="list-group-item"><strong>預算:</strong> <fmt:formatNumber value="${caseDetails.budget}" type="currency" /></li>
			<li class="list-group-item"><strong>總金額:</strong> <fmt:formatNumber value="${caseDetails.caseTot}" type="currency" /></li>
			<li class="list-group-item"><strong>案件狀態:</strong> <c:choose>
					<c:when test="${caseDetails.status == 0}">媒合中</c:when>
					<c:when test="${caseDetails.status == 1}">已結案</c:when>
					<c:when test="${caseDetails.status == 2}">已取消</c:when>
					<c:otherwise>未知狀態</c:otherwise>
				</c:choose></li>
			<li class="list-group-item"><strong>開始日期:</strong> <fmt:formatDate value="${caseDetails.startDate}" pattern="yyyy-MM-dd" /></li>
			<li class="list-group-item"><strong>結束日期:</strong> <fmt:formatDate value="${caseDetails.endDate}" pattern="yyyy-MM-dd" /></li>
			<li class="list-group-item"><strong>建立時間:</strong> <fmt:formatDate value="${caseDetails.createdAt}" pattern="yyyy-MM-dd" /></li>
		</ul>

		<div class="text-center mt-4">
			<a href="${pageContext.request.contextPath}/matchingCases/list?action=list" class="btn btn-secondary">返回案件列表</a>
		</div>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

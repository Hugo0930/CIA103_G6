<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.apply.model.*"%>

<%
ApplyService applySvc = new ApplyService();
List<ApplyVO> pendingApplies = applySvc.getPendingApplies();
pageContext.setAttribute("pendingApplies", pendingApplies);
%>

<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>所有應徵中列表</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 8px;
}

th {
	background-color: #5cb85c;
	color: white;
}

tr:hover {
	background-color: #f1f1f1;
}
</style>
</head>
<body>

	<h1>所有應徵列表</h1>

	<c:if test="${not empty pendingApplies}">
		<table>
			<thead>
				<tr>
					<th>案件ID</th>
					<th>會員ID</th>
					<th>接案會員ID</th>
					<th>描述</th>
					<th>預算</th>
					<th>狀態</th>
					<th>備註</th>
					<th>上傳日期</th>
					<th>試音檔案</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="apply" items="${pendingApplies}">
					<tr>
						<td>${apply.caseId}</td>
						<td>${apply.memId}</td>
						<td>${apply.receiverId}</td>
						<td>${apply.description}</td>
						<td>${apply.budget}</td>

						<td>
							<c:choose>
								<c:when test="${apply.status == '0'}">應徵中</c:when>
								<c:when test="${apply.status == '1'}">已媒合</c:when>
								<c:when test="${apply.status == '2'}">未媒合</c:when>
								<c:when test="${apply.status == '3'}">發案中</c:when>
								<c:otherwise>未知狀態</c:otherwise>
							</c:choose>
						</td>

						<td>${apply.remarks}</td>
						<td>${apply.uploadDate}</td>

						<td>
							<audio controls>
								<source src="${pageContext.request.contextPath}/apply/playVoiceFile?caseId=${apply.caseId}&memId=${apply.memId}" type="audio/mpeg">
								您的瀏覽器不支援音頻播放。
							</audio>
							<br>
							<a href="${pageContext.request.contextPath}/apply/downloadVoiceFile?caseId=${apply.caseId}&memId=${apply.memId}" download>下載音頻</a>
						</td>

						<td><a href="${pageContext.request.contextPath}/apply/getByCaseServlet?caseId=${apply.caseId}&memId=${apply.memId}">查看詳情</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:if>

	<c:if test="${empty pendingApplies}">
		<p>目前沒有應徵記錄</p>
	</c:if>

</body>
</html>

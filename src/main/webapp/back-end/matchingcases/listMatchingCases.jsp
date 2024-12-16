<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.matchingcases.model.*"%>

<%
MatchingCasesService matchingcasesSvc = new MatchingCasesService();
List<MatchingCasesVO> list = matchingcasesSvc.getAllMatchingCases();
pageContext.setAttribute("list", list);
%>
<!DOCTYPE html>
<html>
<head>
<title>案件列表</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container mt-5">
		<h1 class="text-center text-success">案件列表</h1>
		<table class="table table-striped table-hover">
			<thead class="table-dark">
				<tr>
					<th>案件編號</th>
					<th>發案會員編號</th>
					<th>接案會員編號</th>
					<th>案件標題</th>
					<th>案件描述</th>
					<th>預算</th>
					<th>開始日期</th>
					<th>結束日期</th>
					<th>案件狀態</th>
					<th>建立時間</th>
					<th>案件金額</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty list}">
						<c:forEach var="matchingCase" items="${list}">
							<tr>
								<td>${matchingCase.caseId}</td>
								<td>${matchingCase.memId}</td>
								<td>${matchingCase.receiverId}</td>
								<td>${matchingCase.title}</td>
								<td>${matchingCase.description}</td>
								<td>${matchingCase.budget}</td>
								<td><fmt:formatDate value="${matchingCase.startDate}" pattern="yyyy-MM-dd" /></td>
								<td><fmt:formatDate value="${matchingCase.endDate}" pattern="yyyy-MM-dd" /></td>
								<td><c:choose>
										<c:when test="${matchingCase.status == 0}">媒合中</c:when>
										<c:when test="${matchingCase.status == 1}">已結案</c:when>
										<c:when test="${matchingCase.status == 2}">已取消</c:when>
									</c:choose></td>
								<td><fmt:formatDate value="${matchingCase.createdAt}" pattern="yyyy-MM-dd HH:mm" /></td>
								<td>${matchingCase.caseTot}</td>
								<td><a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/matchingCases/view?action=view&caseId=${matchingCase.caseId}">查看</a> <a class="btn btn-warning btn-sm" href="${pageContext.request.contextPath}/matchingCases/update?action=update&caseId=${matchingCase.caseId}">修改</a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="12" class="text-center">目前無案件記錄</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div class="text-center mt-4">
			<a href="${pageContext.request.contextPath}/back-end/matchingcases/select_page.jsp" class="btn btn-secondary">返回首頁</a>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

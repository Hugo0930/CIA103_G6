<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>案件列表</title>
<!-- 引入 Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f9;
	color: #333;
	margin: 0;
	padding: 0;
}

h1 {
	text-align: center;
	margin: 20px 0;
	color: #4CAF50;
}

table {
	width: 90%;
	margin: 0 auto;
	border-collapse: collapse;
	background-color: #fff;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

table th, table td {
	padding: 12px;
	text-align: center;
	border: 1px solid #e0e0e0;
}

table th {
	background-color: #4CAF50;
	color: white;
	font-size: 16px;
}

table td {
	font-size: 14px;
}

table tr:nth-child(even) {
	background-color: #f9f9f9;
}

table tr:hover {
	background-color: #f1f1f1;
}

.btn-action {
	padding: 6px 12px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	text-decoration: none;
	font-size: 14px;
}

.btn-action:hover {
	background-color: #0056b3;
}

.add-case {
	display: block;
	text-align: center;
	margin: 20px 0;
}

.add-case a {
	font-size: 16px;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.add-case a:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	<h1>案件列表</h1>
	<table>
		<thead>
			<tr>
				<th>案件編號</th>
				<th>標題</th>
				<th>描述</th>
				<th>預算</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${not empty allCases}">
					<c:forEach var="case" items="${allCases}">
						<tr>
							<td>${case.caseId}</td>
							<td>${case.title}</td>
							<td>${case.description}</td>
							<td>${case.budget}</td>
							<td><a class="btn-action"
								href="${pageContext.request.contextPath}/matchingcases?action=view&caseId=${case.caseId}">查看</a>
								<a class="btn-action"
								href="${pageContext.request.contextPath}/matchingcases?action=update&caseId=${case.caseId}">修改</a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="5" style="text-align: center;">目前無案件記錄</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<div class="add-case">
		<a href="${pageContext.request.contextPath}/matchingcases?action=add">新增案件</a>
	</div>

	<!-- 引入 Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.membermanage.model.*"%>

<%
    MemberManageService membermanageSvc = new MemberManageService();
    List<MemberManageVO> list = membermanageSvc.getAllMembers();
    pageContext.setAttribute("list",list);
%>
    <!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<title>會員列表</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	color: #333;
	max-width: 1200px;
	margin: 0 auto;
}

h1 {
	text-align: center;
	color: #444;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

th, td {
	padding: 12px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #007bff;
	color: white;
}

tr:nth-child(even) {
	background-color: #f9f9f9;
}

tr:hover {
	background-color: #f1f1f1;
}

a {
	color: #007bff;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
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

	<h1>會員列表</h1>

	<!-- 顯示錯誤訊息 -->
	<c:if test="${not empty errorMsg}">
		<p class="error-msg">${errorMsg}</p>
	</c:if>

	<!-- 會員列表表格 -->
	<table>
		<thead>
			<tr>
				<th>會員編號</th>
				<th>會員姓名</th>
				<th>會員等級</th>
				<th>會員狀態</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="member" items="${list}">
				<tr>
					<td>${member.memberId}</td>
					<td>${member.memberName}</td>
					<td><c:choose>
							<c:when test="${member.memberLvId == 0}">一般會員</c:when>
							<c:otherwise>白金會員</c:otherwise>
						</c:choose></td>
					<td><c:choose>
							<c:when test="${member.memberStatus == 0}">正常</c:when>
							<c:otherwise>停權</c:otherwise>
						</c:choose></td>
					<td><a href="${pageContext.request.contextPath}/memberManageServlet?action=getOne&memberId=${member.memberId}"> 查詢/修改 </a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<!-- 返回首頁 -->
	<div class="btn-container">
		<a href="${pageContext.request.contextPath}/back-end/membermanage/select_page.jsp">返回首頁</a>
	</div>

</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.complaint.model.*"%>

<%
ComplaintService complaintSvc = new ComplaintService();
List<ComplaintVO> list = complaintSvc.getAll();
pageContext.setAttribute("list", list);
%>
<html>
<head>
<title>所有申訴資料 - listAllComplaint.jsp</title>

<!-- 引入Bootstrap样式 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
body {
	background-color: #f4f7fc;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 50px;
	margin-bottom: 50px;
}

table {
	width: 100%;
	background-color: white;
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f2f2f2;
}

h3 {
	color: #2c3e50;
	text-align: center;
	margin-bottom: 30px;
}

button.btn {
	background-color: #007bff;
	color: white;
	border-radius: 5px;
	padding: 10px 20px;
	border: none;
}

button.btn:hover {
	background-color: #0056b3;
}

footer {
	background-color: #2c3e50;
	color: white;
	padding: 15px;
	text-align: center;
}

.btn-home {
	background-color: #17a2b8;
	color: white;
}

.btn-home:hover {
	background-color: #138496;
}

.text-center {
	text-align: center;
}
</style>

</head>
<body>

	<div class="container">

		<h3>所有申訴資料</h3>

		<div class="text-center mb-3">
			<a href="<%=request.getContextPath()%>/back-end/complaint/select_page.jsp" class="btn btn-info btn-lg">返回首頁</a>
		</div>

		<table class="table table-bordered">
			<thead class="thead-light">
				<tr>
					<th>申訴編號</th>
					<th>會員編號</th>
					<th>案件編號</th>
					<th>申訴內容</th>
					<th>申訴日期</th>
					<th>申訴狀態</th>
					<th>處理結果</th>
					<th>修改</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="complaintVO" items="${list}">
					<tr>
						<td>${complaintVO.complaintId}</td>
						<td>${complaintVO.memberId}</td>
						<td>${complaintVO.caseId}</td>
						<td>${complaintVO.complaintCon}</td>
						<td><fmt:formatDate value="${complaintVO.complaintTime}" pattern="yyyy-MM-dd" /></td>
						<td><c:choose>
								<c:when test="${complaintVO.complaintStatus == 0}">待處理</c:when>
								<c:when test="${complaintVO.complaintStatus == 1}">處理中</c:when>
								<c:when test="${complaintVO.complaintStatus == 2}">已解決</c:when>
								<c:when test="${complaintVO.complaintStatus == 3}">已駁回</c:when>
								<c:when test="${complaintVO.complaintStatus == 4}">已取消</c:when>
								<c:when test="${complaintVO.complaintStatus == 5}">已過期</c:when>
								<c:when test="${complaintVO.complaintStatus == 6}">待補件</c:when>
								<c:when test="${complaintVO.complaintStatus == 7}">審核中</c:when>
								<c:otherwise>未知</c:otherwise>
							</c:choose></td>

						<td>${complaintVO.complaintResult}</td>
						<td><a href="<%= request.getContextPath() %>/complaintServlet?action=getOne_For_Update&complaintId=${complaintVO.complaintId}" class="btn btn-sm btn-primary">修改</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<footer>
		<p>
			© 2024 版權所有. <a href="#">隐私政策</a> | <a href="#">聯繫我們</a>
		</p>
	</footer>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<!-- 判斷有無登入且是否為管理員 -->
	<c:set var="memVO" value="${sessionScope.mem}" />
	<c:if test="${memVO.memberStatus != 1}">
		<script type="text/javascript">
			alert('請先登入');

			location.href = "/CIA103g6/front-end/login.jsp";
		</script>

	</c:if>

	<!--  -->
</body>
</html>

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="zh-Hant">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員申訴案件列表</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-5">


		<!-- 表格標題 -->
		<h3 class="text-center text-primary mb-4">會員申訴案件詳細資訊</h3>

		<!-- 案件列表表格 -->
		<table class="table table-bordered table-striped table-hover">
			<thead class="thead-dark">
				<tr>
					<th>申訴編號</th>
					<th>會員編號</th>
					<th>案件編號</th>
					<th>申訴內容</th>
					<th>申訴日期</th>
					<th>申訴狀態</th>
					<th>處理結果</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${not empty complaintList}">
						<c:forEach var="complaintVO" items="${complaintList}">
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
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="7" class="text-center">無任何申訴案件記錄</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>

		<!-- 返回按鈕 -->
		<div class="text-center mt-4">
			<a href="${pageContext.request.contextPath}/back-end/complaint/select_page.jsp" class="btn btn-secondary">返回查詢頁面</a>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

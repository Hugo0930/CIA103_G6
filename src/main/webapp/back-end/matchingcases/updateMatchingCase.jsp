<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>修改案件</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.form-control[readonly] {
	background-color: #f8f9fa !important; /* 淡灰色背景 */
	color: #495057; /* 加深文字顏色 */
	cursor: not-allowed; /* 禁用指針手勢 */
}

.form-control[readonly]:hover {
	background-color: #e9ecef; /* 懸停時稍微加深背景色 */
}
</style>
</head>
<body>
	<div class="container mt-5">
		<h1 class="text-center text-warning">修改案件</h1>
		<form action="${pageContext.request.contextPath}/matchingCases/update?action=update" method="post">
			<div class="mb-3">
				<label for="caseId" class="form-label">案件編號:</label>
				<input type="text" id="caseId" name="caseId" class="form-control" value="${caseDetails.caseId}" readonly>
			</div>
			<div class="mb-3">
				<label for="memId" class="form-label">發案會員編號:</label>
				<input type="text" id="memId" name="memId" class="form-control" value="${caseDetails.memId}" readonly>
			</div>
			<div class="mb-3">
				<label for="receiverId" class="form-label">接案會員編號:</label>
				<input type="text" id="receiverId" class="form-control" value="${caseDetails.receiverId}" readonly>
			</div>
			<div class="mb-3">
				<label for="title" class="form-label">標題:</label>
				<input type="text" id="title" name="title" class="form-control" value="${caseDetails.title}" readonly>
			</div>
			<div class="mb-3">
				<label for="description" class="form-label">描述:</label>
				<textarea id="description" name="description" class="form-control" readonly>${caseDetails.description}</textarea>
			</div>
			<div class="mb-3">
				<label for="budget" class="form-label">預算:</label>
				<input type="text" id="budget" name="budget" class="form-control" value="${caseDetails.budget}" readonly>
			</div>
			<div class="mb-3">
				<label for="caseTot" class="form-label">總金額:</label>
				<input type="text" id="caseTot" name="caseTot" class="form-control" value="${caseDetails.caseTot}" readonly>
			</div>
			<div class="mb-3">
				<label for="startDate" class="form-label">開始日期:</label>
				<input type="text" id="startDate" class="form-control" value="${caseDetails.startDate}" readonly>
			</div>

			<div class="mb-3">
				<label for="endDate" class="form-label">結束日期:</label>
				<input type="text" id="endDate" class="form-control" value="${caseDetails.endDate}" readonly>
			</div>

			<div class="mb-3">
				<label for="createdAt" class="form-label">建立時間:</label>
				<input type="text" id="createdAt" class="form-control" value="${caseDetails.createdAt}" readonly>
			</div>
			<div class="mb-3">
				<label for="status" class="form-label">案件狀態:</label>
				<select id="status" name="status" class="form-select">
					<option value="0" ${caseDetails.status == 0 ? 'selected' : ''}>媒合中</option>
					<option value="1" ${caseDetails.status == 1 ? 'selected' : ''}>已結案</option>
					<option value="2" ${caseDetails.status == 2 ? 'selected' : ''}>已取消</option>
				</select>
			</div>

			<a href="${pageContext.request.contextPath}/back-end/matchingcases/listMatchingCase.jsp" class="btn btn-secondary">取消更新返回媒合案件列表</a>
			<a href="${pageContext.request.contextPath}/back-end/matchingcases/select_page.jsp" class="btn btn-success">返回管理頁面</a>
		</form>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

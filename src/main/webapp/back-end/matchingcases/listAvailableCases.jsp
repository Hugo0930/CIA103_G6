<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>
<%@ page import="com.matchingcases.model.*"%>

<%
MatchingCasesService matchingcasesSvc = new MatchingCasesService();
List<MatchingCasesVO> list = matchingcasesSvc.getAvailableCasesForReceiver();
pageContext.setAttribute("availableCases", list);
%>
<!-- 只有可應徵的案件列表 -->
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>可應徵的案件列表</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">

<style>
.success-message {
	margin-top: 20px;
}

.table thead th {
	background-color: #f2f2f2;
	text-align: center;
}

.table tbody td {
	text-align: center;
}

.btn-success {
	background-color: #28a745;
}

.btn-success:hover {
	background-color: #218838;
}

.alert-success, .alert-danger {
	text-align: center;
}

.badge {
	font-size: 1rem;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // 使用 jQuery，當頁面加載完成後檢查每個案件的應徵狀態
        $('.check-application').each(function() {
            var caseId = $(this).data('caseid'); // 取得每個案件的 caseId
            var $buttonContainer = $(this);

            // 調用後端的 Servlet 檢查該會員是否已應徵過該案件
            $.post('${pageContext.request.contextPath}/checkApplicationExists', { caseId: caseId }, function(response) {
                if (response.exists) {
                    $buttonContainer.html('<span class="badge bg-secondary">已應徵</span>');
                } else {
                    $buttonContainer.html(`
                        <form action="${pageContext.request.contextPath}/applyForCase" method="post">
                            <input type="hidden" name="caseId" value="` + caseId + `" />
                            <button type="submit" class="btn btn-success">應徵</button>
                        </form>
                    `);
                }
            }, 'json').fail(function() {
                console.error("檢查應徵狀態失敗");
            });
        });
    });
</script>

</head>
<body>
	<div class="container mt-5">
		<h1>可應徵的案件列表</h1>

		<c:if test="${param.success == '1'}">
			<div class="alert alert-success success-message" role="alert">應徵成功！</div>
		</c:if>

		<c:if test="${param.error != null}">
			<div class="alert alert-danger success-message" role="alert">${param.error}</div>
		</c:if>

		<table class="table table-striped">
			<thead>
				<tr>
					<th>案件編號</th>
					<th>案件標題</th>
					<th>案件描述</th>
					<th>預算</th>
					<th>案件金額</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="caseItem" items="${availableCases}">
					<tr>
						<td>${caseItem.caseId}</td>
						<td>${caseItem.title}</td>
						<td>${caseItem.description}</td>
						<td>${caseItem.budget}</td>
						<td>${caseItem.caseTot}</td>
						<td class="check-application" data-caseid="${caseItem.caseId}">
							<!-- 這裡的按鈕會通過 jQuery 和 /checkApplicationExists 動態渲染 --> <span
							class="badge bg-info">檢查中...</span>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>

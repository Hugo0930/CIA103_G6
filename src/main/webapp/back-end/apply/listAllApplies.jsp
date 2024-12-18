<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-TW">
<head>
<meta charset="UTF-8">
<title>所有招募中的案件</title>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1>所有招募中的案件</h1>

    <!-- 成功訊息提示 -->
    <c:if test="${not empty param.success}">
        <div class="alert alert-success" role="alert">
            ${param.success}
        </div>
    </c:if>

    <!-- 案件列表 (範例資料顯示) -->
    <table class="table table-striped">
        <thead>
            <tr>
                <th>案件編號</th>
                <th>描述</th>
                <th>預算</th>
                <th>狀態</th>
            </tr>
        </thead>
        <tbody>
            <!-- 這裡填入動態案件數據 -->
            <c:forEach var="apply" items="${applyList}">
                <tr>
                    <td>${apply.applyId}</td>
                    <td>${apply.description}</td>
                    <td>${apply.budget}</td>
                    <td>${apply.status == 0 ? "招募中" : "已結束"}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
